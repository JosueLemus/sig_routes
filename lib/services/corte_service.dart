import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import '../models/corte.dart';
import '../models/route.dart';

class CorteService {
  final String soapEndpoint = 'http://190.171.244.211:8080/wsVarios/wsBS.asmx';

  Future<List<Corte>> fetchCortes() async {
    const String soapRequestCortes = '''<?xml version="1.0" encoding="utf-8"?>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Body>
    <W2Corte_ReporteParaCortesSIG xmlns="http://activebs.net/">
      <liNrut>1</liNrut>
      <liNcnt>0</liNcnt>
      <liCper>0</liCper>
    </W2Corte_ReporteParaCortesSIG>
  </soap12:Body>
</soap12:Envelope>''';

    final response = await http.post(
      Uri.parse(soapEndpoint),
      headers: {'Content-Type': 'application/soap+xml; charset=utf-8'},
      body: soapRequestCortes,
    );

    if (response.statusCode == 200) {
      return parseCortes(response.body);
    } else {
      throw Exception('Failed to load data: ${response.reasonPhrase}');
    }
  }

  Future<List<RouteModel>> fetchRoutes() async {
    const String soapRequestRoutes = '''<?xml version="1.0" encoding="utf-8"?>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Body>
    <W0Corte_ObtenerRutas xmlns="http://activebs.net/">
      <liNrut>1</liNrut>
    </W0Corte_ObtenerRutas>
  </soap12:Body>
</soap12:Envelope>''';

    final response = await http.post(
      Uri.parse(soapEndpoint),
      headers: {'Content-Type': 'application/soap+xml; charset=utf-8'},
      body: soapRequestRoutes,
    );

    if (response.statusCode == 200) {
      return parseRoutes(response.body);
    } else {
      throw Exception('Failed to load data: ${response.reasonPhrase}');
    }
  }

  List<Corte> parseCortes(String responseBody) {
    final document = xml.XmlDocument.parse(responseBody);
    final tables = document.findAllElements('Table');
    return tables.map((element) {
      return Corte(
        code: int.tryParse(element.findElements('bscocNcoc').first.text) ?? 0,
        fixedCode:
            int.tryParse(element.findElements('bscntCodf').first.text) ?? 0,
        count: int.tryParse(element.findElements('bscocNcnt').first.text) ?? 0,
        name: element.findElements('dNomb').first.text,
        morCount:
            int.tryParse(element.findElements('bscocNmor').first.text) ?? 0,
        morAmount:
            double.tryParse(element.findElements('bscocImor').first.text) ??
                0.0,
        service: element.findElements('bsmednser').first.text,
        serviceNumber: element.findElements('bsmedNume').first.text,
        latitude:
            double.tryParse(element.findElements('bscntlati').first.text) ??
                0.0,
        longitude:
            double.tryParse(element.findElements('bscntlogi').first.text) ??
                0.0,
        category: element.findElements('dNcat').first.text,
        observation: element.findElements('dCobc').first.text,
        lots: element.findElements('dLotes').first.text,
      );
    }).toList();
  }

  List<RouteModel> parseRoutes(String responseBody) {
    final document = xml.XmlDocument.parse(responseBody);
    final tables = document.findAllElements('Table');
    return tables.map((element) {
      return RouteModel(
        number: int.tryParse(element.findElements('bsrutnrut').first.text) ?? 0,
        description: element.findElements('bsrutdesc').first.text,
        abbreviation: element.findElements('bsrutabrv').first.text,
        type: int.tryParse(element.findElements('bsruttipo').first.text) ?? 0,
        zoneNumber:
            int.tryParse(element.findElements('bsrutnzon').first.text) ?? 0,
        date: element.findElements('bsrutfcor').first.text,
        period: int.tryParse(element.findElements('bsrutcper').first.text) ?? 0,
        status: int.tryParse(element.findElements('bsrutstat').first.text) ?? 0,
        ride: int.tryParse(element.findElements('bsrutride').first.text) ?? 0,
        name: element.findElements('dNomb').first.text,
        zone: int.tryParse(element.findElements('GbzonNzon').first.text) ?? 0,
        zoneName: element.findElements('dNzon').first.text,
      );
    }).toList();
  }
}
