import 'package:flutter/material.dart';
import '../models/corte.dart';
import '../models/route.dart';
import '../services/corte_service.dart';

class CorteViewModel extends ChangeNotifier {
  List<Corte> cortes = [];
  List<RouteModel> routes = [];
  bool loading = true;
  String errorMessage = '';

  final CorteService corteService = CorteService();

  CorteViewModel() {
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final fetchedCortes = await corteService.fetchCortes();
      final fetchedRoutes = await corteService.fetchRoutes();
      cortes = fetchedCortes;
      routes = fetchedRoutes;
      loading = false;
    } catch (e) {
      errorMessage = 'Failed to load data: $e';
      loading = false;
    }
    notifyListeners();
  }
}
