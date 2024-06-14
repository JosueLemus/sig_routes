import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sig/views/cortes/corte_list_screen.dart';
import 'package:sig/views/rutas/route_list_screen.dart';
import '../../viewmodels/corte_viewmodel.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Cortes y Rutas'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Cortes'),
              Tab(text: 'Rutas'),
            ],
          ),
        ),
        body: Consumer<CorteViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (viewModel.errorMessage.isNotEmpty) {
              return Center(child: Text(viewModel.errorMessage));
            } else {
              return TabBarView(
                children: [
                  CorteListScreen(),
                  RouteListScreen(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
