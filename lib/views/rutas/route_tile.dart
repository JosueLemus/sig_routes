import 'package:flutter/material.dart';
import '../../models/route.dart';

class RouteTile extends StatelessWidget {
  final RouteModel route;

  RouteTile({required this.route});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(15),
        title: Text(
          route.description,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Text('Zone: ${route.zoneName}'),
            Text('Responsible: ${route.name}'),
          ],
        ),
      ),
    );
  }
}
