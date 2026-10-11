import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';

class CardDrawer extends StatelessWidget {
  const CardDrawer({super.key, this.onTap, required this.title, this.iconData});

  final Function()? onTap;
  final String title;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FractionallySizedBox(
        widthFactor: .9,
        child: ListTile(
          title: Text(
            textAlign: TextAlign.center,
            title,
            style: context.bodyMeduim?.copyWith(color: whitecolor),
          ).animate().fade().moveX(),

          trailing: Icon(iconData, color: context.primaryContainer),
        ),
      ),
    );
  }
}
