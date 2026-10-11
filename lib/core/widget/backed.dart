import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mysen/core/utiles.dart';

class Backed extends StatelessWidget {
  const Backed({super.key, this.leftDirction = false});
  final bool leftDirction;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: context.iconButtonStyle,
      onPressed: () {
        context.pop();
      },
      icon: Icon(leftDirction ? Icons.arrow_forward : Icons.arrow_back),
    );
  }
}
