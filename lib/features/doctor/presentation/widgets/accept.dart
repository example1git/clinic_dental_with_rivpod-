import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/close.dart';
import 'package:mysen/features/appointment/presentation/controllers/dependecies.dart';

class Accept extends StatelessWidget {
  const Accept({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: context.spacing,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            const Closed(),
            Text(context.tr.appointmentTime, style: context.titleLarge),
          ],
        ),

        Consumer(
          builder: (context, ref, child) {
            final appointmentDateNotfir = ref.read(
              appointmentDateProvider.notifier,
            );
            final getAppointmentDateProvider = ref.read(
              appointmentDateProvider,
            );

            return Row(
              children: [
                IconButton(
                  style: context.iconButtonStyle,
                  onPressed: () async {
                    final timeappintemt = await showTimePicker(
                      builder: (context, child) =>
                          FractionallySizedBox(child: child),
                      context: context,
                      initialTime: TimeOfDay(
                        hour: DateTime.now().hour,
                        minute: DateTime.now().minute,
                      ),
                    );
                    if (timeappintemt != null) {
                      appointmentDateNotfir.setTime(timeappintemt);
                    }
                  },
                  icon: const Icon(Icons.alarm_outlined),
                ),
                IconButton(
                  style: context.iconButtonStyle,
                  onPressed: () async {
                    final dateappintemt = await showDatePicker(
                      builder: (context, child) =>
                          FractionallySizedBox(child: child),
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(3000),
                    );

                    if (dateappintemt != null) {
                      appointmentDateNotfir.setDate(dateappintemt);
                    }
                  },
                  icon: const Icon(Icons.calendar_month),
                ),

                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: context.mediaSize.shortestSide * .02,

                    children: [
                      Text(
                        "${context.tr.date} : ",
                        style: context.textAppointment,
                      ),

                      Text(
                        textDirection: ui.TextDirection.ltr,

                        DateFormat('yyyy-MM-dd hh:mm a')
                            .format(getAppointmentDateProvider),
                        style: context.textAppointment,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        OutlinedButton(
          style: context.outlinedButtonStyle,
          onPressed: onPressed,
          child: Text(context.tr.done),
        ),
      ],
    );
  }
}
