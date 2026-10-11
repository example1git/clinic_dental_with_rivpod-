import 'package:flutter/material.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';

class CardBottomNavigationBar extends StatelessWidget {
  const CardBottomNavigationBar({
    super.key,
    required this.iconData,
    required this.onPressed,
  });

  final IconData iconData;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: context.primaryContainer,
      child: IconButton(
        style: context.iconButtonStyle,
        onPressed: onPressed,
        icon: Icon(iconData, color: context.primarycolor),
      ),
    );
  }
}
