import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/appointment/domain/entities/appointment.dart';
import 'package:mysen/features/appointment/presentation/widgets/appointment_table.dart';
import 'package:mysen/features/appointment/presentation/widgets/teeth_floawchart_button.dart';

class AppointmentTile extends StatelessWidget {
  const AppointmentTile({
    super.key,
    required this.totalPrice,
    required this.appointment,
    required this.prevoiuspaid,
  });

  final Appointment appointment;
  final int totalPrice;
  final int prevoiuspaid;

  @override
  Widget build(BuildContext context) {
    final payPrice = appointment.payPrice;
    return Padding(
      padding: EdgeInsets.all(context.padding),
      child: ExpansionTile(
        trailing: Icon(Icons.expand_more, size: context.iconSize),

        iconColor: whitecolor,
        collapsedIconColor: context.primaryContainer,
        leading: IconButton(
          iconSize: context.iconSize,
          onPressed: () {
            Utils.showMyDialog(
              context: context,
              child: TeethFlowchart(
                isWidgetTeeth: false,
                teethSelected: appointment.teethSelected ?? [],
                isButtonAddTeeth: false,
              ),
            );
          },
          icon: const FaIcon(FontAwesomeIcons.tooth),
        ),

        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.raduis),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.raduis),
        ),

        collapsedBackgroundColor: context.primaryContainer.withAlpha(50),
        backgroundColor: context.primaryContainer.withAlpha(10),

        title: Column(
          children: [
            Text(context.tr.appointmentTime, style: context.bodyMeduim),
            Directionality(
              textDirection: ui.TextDirection.ltr,
              child: Text(
                DateFormat('yyyy-MM-dd hh:mm a')
                    .format(appointment.timeAppointment),

                style: context.bodyMeduim,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),

        children: [
          AppointmentTable(
            title: context.tr.totalPrice,
            traling: totalPrice.toString(),
          ),
          AppointmentTable(
            title: context.tr.previouslyPaid,
            traling: prevoiuspaid.toString(),
          ),
          AppointmentTable(
            title: context.tr.paidAmount,
            traling: payPrice.toString(),
          ),
          AppointmentTable(
            title: context.tr.remainingPrice,
            traling: "${totalPrice - prevoiuspaid - payPrice}",
          ),
        ],
      ),
    );
  }
}
