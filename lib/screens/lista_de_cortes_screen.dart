import 'package:flutter/material.dart';
import '../services/corte_service.dart';

class ListaDeCortes extends StatefulWidget {
  @override
  _ListaDeCortesState createState() => _ListaDeCortesState();
}

class _ListaDeCortesState extends State<ListaDeCortes> {
  List<Corte> cortes = [];
  List<Ruta> rutas = [];
  bool loading = true;
  String errorMessage = '';

  final CorteService corteService = CorteService();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final fetchedCortes = await corteService.fetchCortes();
      final fetchedRutas = await corteService.fetchRutas();
      setState(() {
        cortes = fetchedCortes;
        rutas = fetchedRutas;
        loading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load data: $e';
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Cortes y Rutas'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : ListView(
                  children: [
                    ExpansionTile(
                      title: const Text('Rutas'),
                      children: rutas.map((ruta) {
                        return ListTile(
                          title: Text(ruta.bsrutdesc),
                          subtitle: Text(
                              'Zona: ${ruta.dNzon} - Responsable: ${ruta.dNomb}'),
                        );
                      }).toList(),
                    ),
                    ExpansionTile(
                      title: const Text('Cortes'),
                      children: cortes.map((corte) {
                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              corte.dNomb,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('C.U.: ${corte.bscocNcoc}'),
                                Text('Cant. Fac.: ${corte.bscocNcnt}'),
                                Text('UMZ: ${corte.dLotes}'),
                                Text('Domestica C.F.: ${corte.bscntCodf}'),
                                Text('Importe: ${corte.bscocImor}'),
                              ],
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                // Acción para cortar
                              },
                              child: const Text('CORTAR'),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
    );
  }
}
