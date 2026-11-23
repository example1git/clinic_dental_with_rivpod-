import 'package:flutter/material.dart';
import 'package:mysen/core/utiles.dart';

class RowProfile extends StatelessWidget {
  const new({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            textAlign: TextAlign.center,
            title,
            style: context.bodyMeduim,
          ),
        ),
        Expanded(
          child: Icon(
            icon,
            color: context.primaryContainer,
            size: context.iconSize,
          ),
        ),
      ],
    );
  }
}
