import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';

class CardTreatment extends StatelessWidget {
  const CardTreatment({
    super.key,
    required this.treatment,
    required this.leading,
    this.delete,
  });

  final TreatmentCase treatment;
  final Widget leading;
  final Widget? delete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(context.margin),
      elevation: elevation,

      shadowColor: blackcolor,
      color: context.primarycolor,
      child: ListTile(
        minVerticalPadding: context.padding,
        trailing: delete ?? const SizedBox.shrink(),

        title: Text(
          textAlign: TextAlign.center,
          context.tr.treatmentCase,

          style: context.bodyLarge?.copyWith(color: context.primaryContainer),
        ),
        subtitle: Text(
          textDirection: ui.TextDirection.ltr,
          textAlign: TextAlign.center,
          DateFormat('yyyy-MM-dd hh:mm a').format(treatment.createdTime),
          style: context.bodyMeduim,
        ),
        leading: leading,
      ),
    );
  }
}
