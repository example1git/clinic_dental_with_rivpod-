import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/appointment/presentation/pages/all_appointment_day.dart';
import 'package:mysen/features/appointment/presentation/widgets/teeth_floawchart_button.dart';

class AppointmentDays extends StatelessWidget {
  const AppointmentDays({super.key, required this.appointmenstWithPatients});

  final List<Appointmentwithpatient> appointmenstWithPatients;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(context.padding),
      itemCount: appointmenstWithPatients.length,
      itemBuilder: (BuildContext context, int index) {
        final appointmentWithPatient = appointmenstWithPatients[index];
        return Card(
          margin: EdgeInsets.all(context.margin),
          color: context.primarycolor,
          shadowColor: blackcolor,
          elevation: 2,
          child: ListTile(
            title: Text(
              textAlign: TextAlign.center,
              appointmentWithPatient.patientName,
              style: context.bodyMeduim,
            ),
            subtitle: Text(
              textDirection: ui.TextDirection.ltr,
              textAlign: TextAlign.center,
              DateFormat('yyyy-MM-dd hh:mm a')
                  .format(appointmentWithPatient.appointment.timeAppointment),
              style: context.bodyMeduim,
            ),
            leading: appointmentWithPatient.appointment.teethSelected == null
                ? const SizedBox.shrink()
                : IconButton(
                    iconSize: context.iconSize,
                    onPressed: () {
                      Utils.showMyDialog(
                        context: context,
                        child: TeethFlowchart(
                          isButtonAddTeeth: false,
                          isWidgetTeeth: false,
                          teethSelected: [],
                        ),
                      );
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.tooth,
                      color: context.primaryContainer,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
