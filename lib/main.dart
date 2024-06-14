import 'package:flutter/material.dart';
import 'screens/lista_de_cortes_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListaDeCortes(),
    );
  }
}
