import 'package:flutter/material.dart';
import 'package:mysen/core/utiles.dart';

class ChildPhone extends StatelessWidget {
  const ChildPhone({super.key, required this.phone});

  final String phone;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.phone_android,
                size: context.iconSize,
                color: context.primaryContainer,
              ),
              Text(phone, style: context.number),
            ],
          ),
        ],
      ),
    );
  }
}
