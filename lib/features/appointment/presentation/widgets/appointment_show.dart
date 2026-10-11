import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/close.dart';
import 'package:mysen/core/widget/error_widget.dart';
import 'package:mysen/features/appointment/domain/entities/appointment.dart';
import 'package:mysen/features/appointment/presentation/controllers/dependecies.dart';
import 'package:mysen/features/appointment/presentation/widgets/appointment_tile.dart';
import 'package:mysen/features/appointment/presentation/widgets/description_flowchartList.dart';
import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';

class AppointmentShow extends ConsumerWidget {
  const AppointmentShow({
    super.key,
    required this.treatment,
    required this.doctorPateint,
  });

  final TreatmentCase treatment;
  final DoctorPateint doctorPateint;
  int payPaid(TreatmentCase treatment, List<Appointment> appointMents) {
    int paypaid = 0;
    for (var app in appointMents.where(
      (p0) => p0.treatmentCaseID == treatment.id,
    )) {
      paypaid = paypaid + app.payPrice;
    }

    return paypaid;
  }

  List<Map<String, Color>> colorizedLeading(
    String trID,
    List<Appointment> appointMents,
  ) {
    final teeths = appointMents.map((element) => element.teethSelected);
    final List<Map<String, Color>> listmap = [];
    for (var teeth in teeths) {
      if (teeth == null) {
        return [];
      }
      final Map<String, Color> map = {};
      for (var t in teeth) {
        map.addAll({t['number']: whitecolor});
      }
      listmap.add(map);
    }
    return listmap;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointemntProvider = ref.watch(appointmentProvider);
    return appointemntProvider.when(
      data: (data) {
        final payPrice = payPaid(treatment, data);
        final appointments = data
            .where((element) => element.treatmentCaseID == treatment.id)
            .toList();
        return Column(
          spacing: context.spacing,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: IconButton(
                    style: context.iconButtonStyle,
                    onPressed: () {
                      Utils.showMyDialog(
                        dismissible: true,
                        widthFactor: .9,
                        heightFactor: .3,
                        colorDialog: context.primarycolor.withAlpha(50),
                        context: context,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    context.tr.totalPrice,
                                    style: context.bodyMeduim,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    textAlign: TextAlign.center,

                                    " ${treatment.totalPrice}",
                                    style: context.textAppointment,
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    context.tr.paidAmount,

                                    style: context.bodyMeduim,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    textAlign: TextAlign.center,

                                    payPrice.toString(),
                                    style: context.textAppointment,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    context.tr.remainingPrice,

                                    style: context.bodyMeduim,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    (treatment.totalPrice - payPrice)
                                        .toString(),
                                    style: context.textAppointment,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.book_online),
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  context.tr.reservesList,

                  style: context.titleLarge?.copyWith(color: whitecolor),
                ),
                const Closed(),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (BuildContext context, int index) {
                  final prevoiusAppointment = appointments.sublist(0, index);
                  int prevoiuspaid = 0;
                  for (var app in prevoiusAppointment) {
                    prevoiuspaid = prevoiuspaid + app.payPrice;
                  }
                  return AppointmentTile(
                    widgetDescription: IconButton(
                      style: context.iconButtonStyle,
                      onPressed: () {
                        Utils.showMyDialog(
                          context: context,
                          child: Column(
                            spacing: context.mediaSize.shortestSide * .02,
                            children: [
                              Stack(
                                alignment: AlignmentGeometry.center,
                                children: [
                                  Text(
                                    context.tr.description,
                                    style: context.titleLarge,
                                  ),
                                  const Closed(),
                                ],
                              ),
                              DescriptionFlowchartList(
                                isNumber: true,
                                appointMent: appointments[index],
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.description_sharp),
                    ),

                    title: DateFormat('yyyy-MM-dd hh:mm a')
                        .format(appointments[index].timeAppointment),

                    index: index,

                    colorized: colorizedLeading(
                      treatment.id,
                      appointments,
                    )[index],
                    isButtonAddTeeth: false,
                    totalPrice: treatment.totalPrice,
                    prevoiuspaid: prevoiuspaid,
                    payPrice: appointments[index].payPrice,
                  );
                },
              ),
            ),
            ChildPhone(phone: doctorPateint.patientphone),
          ],
        );
      },
      error: (error, stackTrace) {
        return CustomErrorWidget(ref: ref, error: error, onPressed: () {});
      },
      loading: () {
        return Center(
          child: CircularProgressIndicator(color: context.primaryContainer),
        );
      },
    );
  }
}

class ChildPhone extends StatelessWidget {
  const ChildPhone({super.key, required this.phone});

  final String phone;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.phone_android,
                size: context.iconSize,
                color: context.primaryContainer,
              ),
              Text(phone, style: context.number),
            ],
          ),
        ],
      ),
    );
  }
}
