import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mysen/core/utiles.dart';

class Closed extends StatelessWidget {
  const Closed({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        style: context.iconButtonStyle,
        onPressed: () {
          context.pop();
        },
        icon: const Icon(Icons.clear),
      ),
    );
  }
}
