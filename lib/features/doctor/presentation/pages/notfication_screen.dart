import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/alert.dart';

import 'dart:ui' as ui;

import 'package:mysen/core/widget/backed.dart';
import 'package:mysen/core/widget/error_widget.dart';
import 'package:mysen/features/appointment/presentation/controllers/dependecies.dart';
import 'package:mysen/features/doctor/presentation/widgets/accept.dart';
import 'package:mysen/features/doctor_patient/presentation/controllers/dependecies.dart';
import 'package:mysen/features/request/domain/entities/request_reservation.dart';
import 'package:mysen/features/request/presentation/controllers/dependecies.dart';

class Notfictionscreen extends ConsumerWidget {
  const Notfictionscreen({super.key});

  void accept(RequestReservation request, WidgetRef ref) async {
    final doctorPatients = ref.read(doctorPatientProvider).value;
    final dpNotfir = ref.read(doctorPatientProvider.notifier);
    final requestNotfir = ref.read(requestReservationProvider.notifier);
    final appointmentDate = ref.read(appointmentDateProvider);
    final ispatientExist = doctorPatients?.any(
      (element) => element.patientID == request.patientID,
    );
    final doctorPatient = doctorPatients?.firstWhere(
      (element) => element.id == request.patientID,
    );

    if (ispatientExist!) {
      dpNotfir.updateDoctorPatient(
        doctorPatient!.copyWith(isDeletePatient: false),
      );

      requestNotfir.updateRequestReservation(
        request.copyWith(
          stateRequest: StateRequest.accepted,
          reciveTime: appointmentDate,
        ),
      );
      // MessageHandle.handleMessage(MessageType.add);

      return;
    }
    dpNotfir.upsertDoctorPatientAndAllTreamentAndAppointment(doctorPatient!);
    requestNotfir.updateRequestReservation(
      request.copyWith(
        stateRequest: StateRequest.accepted,
        reciveTime: appointmentDate,
      ),
    );
    // MessageHandle.handleMessage(MessageType.add);
  }

  void reject(RequestReservation request, WidgetRef ref) async {
    final requestNotfir = ref.read(requestReservationProvider.notifier);
    requestNotfir.updateRequestReservation(
      request.copyWith(stateRequest: StateRequest.reject, reciveTime: null),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestReservationRef = ref.read(requestReservationProvider);
    final doctorPatient = ref.read(doctorPatientProvider).value;

    return Scaffold(
      backgroundColor: context.primarycolor,

      appBar: AppBar(
        toolbarHeight: context.mediaSize.shortestSide * .15,
        leadingWidth: context.mediaSize.shortestSide * .15,

        backgroundColor: context.primarycolor,

        leading: const Backed(),
        automaticallyImplyLeading: false,
        title: Text(
          context.tr.notificationReservation,
          style: context.titleLarge,
        ),
        centerTitle: true,
      ),
      body: requestReservationRef.when(
        data: (data) {
          return RefreshIndicator(
            onRefresh: () async {
              // if (notficationcontroller.isfetch) {
              //   notficationcontroller.fetchRequest();
              // }
            },
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final RequestReservation request = data[index];

                final isExist = doctorPatient?.any(
                  (element) => element.patientID == request.patientID,
                );

                return Card(
                  elevation: elevation,
                  color: blackcolor.withAlpha(100),
                  margin: EdgeInsets.all(context.margin),
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(context.padding),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Utils.showMyDialog(
                              widthFactor: .9,

                              context: context,
                              child: Accept(
                                onPressed: () {
                                  accept(request, ref);
                                },
                              ),
                            );
                          },
                          child: Text(
                            context.tr.accept,
                            style: context.textAppointment,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (isExist!)
                                Text(
                                  context.tr.newItem,
                                  style: context.textAppointment,
                                ),
                              Text(
                                request.patientName,
                                style: context.bodyMeduim,
                              ),
                              Text(
                                textDirection: ui.TextDirection.ltr,
                                DateFormat('yyyy -MM-dd hh mm a')
                                    .format(request.sendTime ?? DateTime.now()),
                                style: context.bodyMeduim,
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Utils.showMyDialog(
                              heightFactor: .3,
                              widthFactor: .8,
                              colorDialog: context.colorScheme.error,
                              context: context,
                              child: Alert(
                                confirme: () async {
                                  reject(request, ref);
                                },

                                title: context.tr.titleReject,
                                isLoading: false,
                              ),
                            );
                          },
                          child: Text(
                            context.tr.reject,
                            style: context.bodySmallNotfication?.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
        error: (error, stackTrace) =>
            CustomErrorWidget(ref: ref, error: error, onPressed: () {}),
        loading: () => Center(
          child: CircularProgressIndicator(color: context.primaryContainer),
        ),
      ),
    );
  }
}
