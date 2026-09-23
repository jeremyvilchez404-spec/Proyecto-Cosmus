import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String icon;
  final String title;
  final String value;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Text(
          icon,
          style: const TextStyle(fontSize: 25),
        ),

        title: Text(title),

        trailing: Text(
          value,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}