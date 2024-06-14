import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

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

  Future<List<Ruta>> fetchRutas() async {
    const String soapRequestRutas = '''<?xml version="1.0" encoding="utf-8"?>
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
      body: soapRequestRutas,
    );

    if (response.statusCode == 200) {
      return parseRutas(response.body);
    } else {
      throw Exception('Failed to load data: ${response.reasonPhrase}');
    }
  }

  List<Corte> parseCortes(String responseBody) {
    final document = xml.XmlDocument.parse(responseBody);
    final tables = document.findAllElements('Table');
    return tables.map((element) {
      return Corte(
        bscocNcoc:
            int.tryParse(element.findElements('bscocNcoc').first.text) ?? 0,
        bscntCodf:
            int.tryParse(element.findElements('bscntCodf').first.text) ?? 0,
        bscocNcnt:
            int.tryParse(element.findElements('bscocNcnt').first.text) ?? 0,
        dNomb: element.findElements('dNomb').first.text,
        bscocNmor:
            int.tryParse(element.findElements('bscocNmor').first.text) ?? 0,
        bscocImor:
            double.tryParse(element.findElements('bscocImor').first.text) ??
                0.0,
        bsmednser: element.findElements('bsmednser').first.text,
        bsmedNume: element.findElements('bsmedNume').first.text,
        bscntlati:
            double.tryParse(element.findElements('bscntlati').first.text) ??
                0.0,
        bscntlogi:
            double.tryParse(element.findElements('bscntlogi').first.text) ??
                0.0,
        dNcat: element.findElements('dNcat').first.text,
        dCobc: element.findElements('dCobc').first.text,
        dLotes: element.findElements('dLotes').first.text,
      );
    }).toList();
  }

  List<Ruta> parseRutas(String responseBody) {
    final document = xml.XmlDocument.parse(responseBody);
    final tables = document.findAllElements('Table');
    return tables.map((element) {
      return Ruta(
        bsrutnrut:
            int.tryParse(element.findElements('bsrutnrut').first.text) ?? 0,
        bsrutdesc: element.findElements('bsrutdesc').first.text,
        bsrutabrv: element.findElements('bsrutabrv').first.text,
        bsruttipo:
            int.tryParse(element.findElements('bsruttipo').first.text) ?? 0,
        bsrutnzon:
            int.tryParse(element.findElements('bsrutnzon').first.text) ?? 0,
        bsrutfcor: element.findElements('bsrutfcor').first.text,
        bsrutcper:
            int.tryParse(element.findElements('bsrutcper').first.text) ?? 0,
        bsrutstat:
            int.tryParse(element.findElements('bsrutstat').first.text) ?? 0,
        bsrutride:
            int.tryParse(element.findElements('bsrutride').first.text) ?? 0,
        dNomb: element.findElements('dNomb').first.text,
        GbzonNzon:
            int.tryParse(element.findElements('GbzonNzon').first.text) ?? 0,
        dNzon: element.findElements('dNzon').first.text,
      );
    }).toList();
  }
}

class Ruta {
  final int bsrutnrut;
  final String bsrutdesc;
  final String bsrutabrv;
  final int bsruttipo;
  final int bsrutnzon;
  final String bsrutfcor;
  final int bsrutcper;
  final int bsrutstat;
  final int bsrutride;
  final String dNomb;
  final int GbzonNzon;
  final String dNzon;

  Ruta({
    required this.bsrutnrut,
    required this.bsrutdesc,
    required this.bsrutabrv,
    required this.bsruttipo,
    required this.bsrutnzon,
    required this.bsrutfcor,
    required this.bsrutcper,
    required this.bsrutstat,
    required this.bsrutride,
    required this.dNomb,
    required this.GbzonNzon,
    required this.dNzon,
  });
}

class Corte {
  final int bscocNcoc;
  final int bscntCodf;
  final int bscocNcnt;
  final String dNomb;
  final int bscocNmor;
  final double bscocImor;
  final String bsmednser;
  final String bsmedNume;
  final double bscntlati;
  final double bscntlogi;
  final String dNcat;
  final String dCobc;
  final String dLotes;

  Corte({
    required this.bscocNcoc,
    required this.bscntCodf,
    required this.bscocNcnt,
    required this.dNomb,
    required this.bscocNmor,
    required this.bscocImor,
    required this.bsmednser,
    required this.bsmedNume,
    required this.bscntlati,
    required this.bscntlogi,
    required this.dNcat,
    required this.dCobc,
    required this.dLotes,
  });
}
