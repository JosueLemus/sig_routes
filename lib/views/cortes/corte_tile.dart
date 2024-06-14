import 'package:flutter/material.dart';
import '../../models/corte.dart';
import 'dart:math';

class CorteTile extends StatelessWidget {
  final Corte corte;

  CorteTile({required this.corte});

  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.brown,
    Colors.cyan,
  ];

  Color _getRandomColor() {
    final _random = Random();
    return _colors[_random.nextInt(_colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: _getRandomColor(),
          child: Text(
            corte.name[0],
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        title: Text(
          corte.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Text('Code: ${corte.code}'),
            Text('Count: ${corte.count}'),
            Text('Lots: ${corte.lots}'),
            Text('Fixed Code: ${corte.fixedCode}'),
            Text('Amount: ${corte.morAmount}'),
          ],
        ),
        trailing: TextButton(
          child: Text('CUT', style: TextStyle(color: Colors.red)),
          onPressed: () {
            // Action for cut
          },
        ),
      ),
    );
  }
}
