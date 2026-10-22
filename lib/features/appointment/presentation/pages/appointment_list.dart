import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/close.dart';
import 'package:mysen/core/widget/error_widget.dart';
import 'package:mysen/features/appointment/domain/entities/appointment.dart';
import 'package:mysen/features/appointment/presentation/controllers/dependecies.dart';
import 'package:mysen/features/appointment/presentation/widgets/appointment_tile.dart';
import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';

class AppointmentList extends ConsumerWidget {
  const AppointmentList({
    super.key,
    required this.treatment,
    required this.doctorPateint,
    required this.isDcotor,
  });

  final TreatmentCase treatment;

  final DoctorPateint doctorPateint;
  final bool isDcotor;

  int getPrevoiuspaid(int index, List<Appointment> appointments) {
    final prevoiusAppointment = appointments.sublist(0, index);
    int prevoiuspaid = 0;
    for (var app in prevoiusAppointment) {
      prevoiuspaid = prevoiuspaid + app.payPrice;
    }
    return prevoiuspaid;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(payPaidProvider.notifier).getPayPaid(treatment);
    final appointemntProvider = ref.watch(appointmentProvider);
    return appointemntProvider.when(
      data: (data) {
        final appointments = data
            .where((element) => element.treatmentCaseID == treatment.id)
            .toList();

        return Column(
          spacing: context.spacing,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                PrcieDetailes(treatment: treatment),
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
                  return AppointmentTile(
                    totalPrice: treatment.totalPrice,
                    appointment: appointments[index],
                    prevoiuspaid: index == 0
                        ? 0
                        : getPrevoiuspaid(index, appointments),
                  );
                },
              ),
            ),
            isDcotor
                ? ChildPhone(phone: doctorPateint.patientphone)
                : SizedBox.shrink(),
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

class PrcieDetailes extends ConsumerWidget {
  const new({super.key, required this.treatment});

  final TreatmentCase treatment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payPrice = ref.watch(payPaidProvider);
    return Align(
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
                        (treatment.totalPrice - payPrice).toString(),
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
