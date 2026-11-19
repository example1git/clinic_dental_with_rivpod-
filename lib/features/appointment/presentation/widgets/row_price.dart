import 'package:flutter/material.dart';
import 'package:mysen/core/utiles.dart';

class RowPrice extends StatelessWidget {
  const RowPrice({super.key, required this.price, required this.title});

  final int price;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            textAlign: TextAlign.center,
            title,
            style: context.bodyMeduim,
          ),
        ),
        Expanded(
          child: Text(
            textAlign: TextAlign.center,

            "$price ${context.tr.sar}",
            style: context.textAppointment,
          ),
        ),
      ],
    );
  }
}
