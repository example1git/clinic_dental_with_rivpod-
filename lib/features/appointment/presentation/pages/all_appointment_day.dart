import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/backed.dart';
import 'package:mysen/features/appointment/domain/entities/appointment.dart';
import 'package:mysen/features/appointment/presentation/controllers/dependecies.dart';
import 'package:mysen/features/appointment/presentation/widgets/appointment_days.dart';
import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';
import 'package:mysen/features/doctor_patient/presentation/controllers/dependecies.dart';
import 'package:mysen/features/request/domain/entities/request_reservation.dart';
import 'package:mysen/features/request/presentation/controllers/dependecies.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';
import 'package:mysen/features/treament/presentation/controllers/dependecies.dart';

class Appointmentwithpatient {
  final Appointment appointment;
  final String patientName;
  final String patientPhone;

  Appointmentwithpatient({
    required this.appointment,
    required this.patientName,
    required this.patientPhone,
  });
}

class AllAppointmenteday extends ConsumerStatefulWidget {
  const AllAppointmenteday({super.key});

  @override
  ConsumerState<AllAppointmenteday> createState() => _AllAppointmentedayState();
}

class _AllAppointmentedayState extends ConsumerState<AllAppointmenteday> {
  DateTime dateTimeAppointemntDays = DateTime.now();

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  List<Appointmentwithpatient> fetchAllReserv(
    DateTime datTime,
    List<DoctorPateint> doctorPatient,
    List<RequestReservation> requestRservation,
    List<Appointment> appointMents,
    List<TreatmentCase> treatments,
  ) {
    final List<Appointmentwithpatient> result = [];

    final requests = requestRservation.where(
      (element) => element.stateRequest == StateRequest.accepted,
    );

    for (final request in requests) {
      final receiveTime = request.reciveTime;

      if (receiveTime == null) continue;

      if (!isSameDate(receiveTime, datTime)) continue;

      result.add(
        Appointmentwithpatient(
          appointment: Appointment(
            treatmentCaseID: '',
            timeAppointment: receiveTime,
            payPrice: 0,
            id: '',
            doctorPatientID: '',
          ),
          patientName: request.patientName,
          patientPhone: request.phone,
        ),
      );
    }

    final activeTreatments = treatments.where(
      (element) => element.treatmentSatus == TreatmentSatus.active,
    );

    for (final appointment in appointMents) {
      if (!isSameDate(appointment.timeAppointment, datTime)) {
        continue;
      }

      final treatment = activeTreatments
          .where((element) => element.id == appointment.treatmentCaseID)
          .firstOrNull;

      if (treatment == null) continue;

      final patient = doctorPatient
          .where((element) => element.id == treatment.doctorPatientID)
          .firstOrNull;

      if (patient == null) continue;

      result.add(
        Appointmentwithpatient(
          appointment: appointment,
          patientName: patient.patientFullName,
          patientPhone: patient.patientphone,
        ),
      );
    }

    result.sort(
      (a, b) => a.appointment.timeAppointment.compareTo(
        b.appointment.timeAppointment,
      ),
    );

    return result;
  }

  void setDateDays(DateTime date) {
    setState(() {
      dateTimeAppointemntDays = DateTime(
        date.year,
        date.month,
        date.day,
        dateTimeAppointemntDays.hour,
        dateTimeAppointemntDays.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final doctorPatientAsync = ref.watch(doctorPatientProvider);
    final requestReservationAsync = ref.watch(requestReservationProvider);
    final appointmentAsync = ref.watch(appointmentProvider);
    final treatmentCaseAsync = ref.watch(treatmentProvider);

    if (doctorPatientAsync.isLoading ||
        requestReservationAsync.isLoading ||
        appointmentAsync.isLoading ||
        treatmentCaseAsync.isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: context.primaryContainer),
        ),
      );
    }

    if (doctorPatientAsync.hasError ||
        requestReservationAsync.hasError ||
        appointmentAsync.hasError ||
        treatmentCaseAsync.hasError) {
      return Scaffold(
        body: Center(
          child: Text(context.tr.loadError, style: context.bodyMeduim),
        ),
      );
    }

    final doctorPatients = doctorPatientAsync.value!;
    final requests = requestReservationAsync.value!;
    final appointments = appointmentAsync.value!;
    final treatments = treatmentCaseAsync.value!;

    final today = DateTime.now();

    final yesterday = today.subtract(const Duration(days: 1));

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const Backed(),
          centerTitle: true,
          leadingWidth: context.mediaSize.shortestSide * .15,
          toolbarHeight: context.mediaSize.shortestSide * .15,
          backgroundColor: context.primarycolor,

          title: Text(context.tr.allReservations, style: context.titleLarge),

          bottom: TabBar(
            indicatorColor: context.primaryContainer,

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
            AppointmentDays(
              appointmenstWithPatients: fetchAllReserv(
                today,
                doctorPatients,
                requests,
                appointments,
                treatments,
              ),
            ),

            AppointmentDays(
              appointmenstWithPatients: fetchAllReserv(
                yesterday,
                doctorPatients,
                requests,
                appointments,
                treatments,
              ),
            ),

            Stack(
              alignment: Localizations.localeOf(context).languageCode == 'ar'
                  ? Alignment.topLeft
                  : Alignment.topRight,
              children: [
                AppointmentDays(
                  appointmenstWithPatients: fetchAllReserv(
                    dateTimeAppointemntDays,
                    doctorPatients,
                    requests,
                    appointments,
                    treatments,
                  ),
                ),

                Card(
                  color: context.primarycolor,
                  shadowColor: blackcolor,
                  elevation: elevation,
                  child: IconButton(
                    style: context.iconButtonStyle,

                    onPressed: () async {
                      final dateAppointment = await showDatePicker(
                        context: context,
                        builder: (context, child) =>
                            FractionallySizedBox(child: child),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(3000),
                        initialDate: dateTimeAppointemntDays,
                      );

                      if (dateAppointment != null) {
                        setDateDays(dateAppointment);
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
