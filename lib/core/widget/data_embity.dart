import 'package:flutter/material.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';

class DataEmbity extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        context.tr.data,
        style: context.bodyMeduim?.copyWith(color: blackcolor),
      ),
    );
  }
}
