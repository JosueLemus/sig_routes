import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sig/viewmodels/corte_viewmodel.dart';
import '../shared/loading_indicator.dart';
import 'corte_tile.dart';

class CorteListScreen extends StatefulWidget {
  @override
  _CorteListScreenState createState() => _CorteListScreenState();
}

class _CorteListScreenState extends State<CorteListScreen> {
  final TextEditingController _corteSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CorteViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.loading) {
            return LoadingIndicator();
          } else if (viewModel.errorMessage.isNotEmpty) {
            return Center(child: Text(viewModel.errorMessage));
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _corteSearchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar Cortes',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      (context as Element).markNeedsBuild();
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.cortes.length,
                    itemBuilder: (context, index) {
                      final corte = viewModel.cortes[index];
                      if (_corteSearchController.text.isEmpty ||
                          corte.name.toLowerCase().contains(
                              _corteSearchController.text.toLowerCase())) {
                        return CorteTile(corte: corte);
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
