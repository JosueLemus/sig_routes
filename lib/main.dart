import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sig/views/main_screen.dart';
import 'viewmodels/corte_viewmodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CorteViewModel(),
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            brightness: Brightness.dark),
        home: MainScreen(),
      ),
    );
  }
}
