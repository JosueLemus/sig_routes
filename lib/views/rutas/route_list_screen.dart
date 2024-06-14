import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sig/viewmodels/corte_viewmodel.dart';
import '../shared/loading_indicator.dart';
import 'route_tile.dart';

class RouteListScreen extends StatefulWidget {
  @override
  _RouteListScreenState createState() => _RouteListScreenState();
}

class _RouteListScreenState extends State<RouteListScreen> {
  final TextEditingController _routeSearchController = TextEditingController();

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
                    controller: _routeSearchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar Rutas',
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
                    itemCount: viewModel.routes.length,
                    itemBuilder: (context, index) {
                      final route = viewModel.routes[index];
                      if (_routeSearchController.text.isEmpty ||
                          route.description.toLowerCase().contains(
                              _routeSearchController.text.toLowerCase())) {
                        return RouteTile(route: route);
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
