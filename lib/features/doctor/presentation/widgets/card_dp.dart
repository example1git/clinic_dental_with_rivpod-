import 'package:flutter/material.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';

class CardPatient extends StatelessWidget {
  const CardPatient({
    super.key,
    required this.trailing,

    required this.title,
    required this.leading,
  });

  final Widget title;
  final Widget leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(context.margin),

      color: context.primarycolor,
      shadowColor: blackcolor,
      elevation: elevation,

      child: Padding(
        padding: EdgeInsets.all(context.padding),
        child: Row(
          children: [
            leading,
            Expanded(child: title),
            trailing ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
