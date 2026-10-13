import 'package:flutter/material.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/backed.dart';
import 'package:mysen/features/appointment/domain/entities/appointment.dart';
import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';
import 'package:mysen/features/request/domain/entities/request_reservation.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';

class Appointmentwithpatient {
  final Appointment appointment;
  final String patientName;

  Appointmentwithpatient({
    required this.appointment,
    required this.patientName,
  });
}

class AllAppointmenteday extends StatelessWidget {
  AllAppointmenteday({super.key});
  DateTime dateTimeAppointemntDays = DateTime(0, 0, 0, 0);

  List<Appointmentwithpatient> fetchAllReserv(
    DateTime datTime,
    List<DoctorPateint> doctorPatient,
    List<RequestReservation> requestRservation,
    List<Appointment> appointMents,
    List<TreatmentCase> treatments,
  ) {
    final List<RequestReservation> requests = requestRservation
        .where((p0) => p0.stateRequest == StateRequest.accepted)
        .toList();

    List<Appointmentwithpatient> result = [];
    for (var r in requests) {
      if (r.reciveTime != null) {
        final isSameDate =
            r.reciveTime?.year == datTime.year &&
            r.reciveTime?.month == datTime.month &&
            r.reciveTime?.day == datTime.day;
        if (!isSameDate) continue;
        result.add(
          Appointmentwithpatient(
            appointment: Appointment(
              treatmentCaseID: '',
              timeAppointment: r.reciveTime!,
              payPrice: 0,
              id: '',
              doctorPatientID: '',
            ),
            patientName: r.patientName,
          ),
        );
      }
    }
    for (var appointment in appointMents) {
      final appoimentDate = appointment.timeAppointment;
      final isSameDate =
          appoimentDate.year == datTime.year &&
          appoimentDate.month == datTime.month &&
          appoimentDate.day == datTime.day;
      if (!isSameDate) continue;
      final List<TreatmentCase> treatmentCaseActive = treatments
          .where((element) => element.treatmentSatus == TreatmentSatus.active)
          .toList();

      final treatment = treatmentCaseActive.firstWhere(
        (element) => element.id == appointment.treatmentCaseID,
      );
      // if ( treatment == null) continue;

      final patient = doctorPatient.firstWhere(
        (element) => element.id == treatment.doctorPatientID,
      );
      // if (patient == null) continue;
      result.add(
        Appointmentwithpatient(
          appointment: appointment,
          patientName: patient.patientFullName,
        ),
      );
    }

    return result;
  }

  void setDateDays(DateTime date) {
    dateTimeAppointemntDays = DateTime(
      date.year,
      date.month,
      date.day,
      dateTimeAppointemntDays.hour,
      dateTimeAppointemntDays.minute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: context.primarycolor,
        appBar: AppBar(
          leading: const Backed(),
          centerTitle: true,
          leadingWidth: context.mediaSize.shortestSide * .15,

          toolbarHeight: context.mediaSize.shortestSide * .15,

          backgroundColor: context.primarycolor,

          title: Text(context.tr.allReservations, style: context.titleLarge),
          bottom: TabBar(
            tabs: [
              Tab(child: Text(context.tr.today, style: context.bodyMeduim)),
              Tab(child: Text(context.tr.yesterday, style: context.bodyMeduim)),
              Tab(
                child: Text(context.tr.specificDate, style: context.bodyMeduim),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // AppointmentDays(
            //   appointmenstWithPatients: fetchAllReserv(DateTime.now()),
            // ),
            // AppointmentDays(
            //   appointmenstWithPatients: fetchAllReserv(
            //     DateTime(
            //       DateTime.now().year,
            //       DateTime.now().month,
            //       DateTime.now().day - 1,
            //     ),
            //   ),
            // ),

            Stack(
              alignment: AlignmentGeometry.topRight,
              children: [
                // AppointmentDays(
                //   appointmenstWithPatients: appointmentController
                //       .fetchAllReserv(
                //         appointmentController.dateTimeAppointemntDays.value,
                //       ),
                // ),

                Card(
                  color: context.primarycolor,
                  shadowColor: blackcolor,
                  elevation: elevation,
                  child: IconButton(
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
                        setDateDays(dateappintemt);
                      }
                    },
                    icon: const Icon(Icons.calendar_month),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
