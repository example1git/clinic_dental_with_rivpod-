import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/close.dart';
import 'package:mysen/core/widget/data_embity.dart';
import 'package:mysen/core/widget/error_widget.dart';
import 'package:mysen/features/appointment/domain/entities/appointment.dart';
import 'package:mysen/features/appointment/presentation/controllers/dependecies.dart';
import 'package:mysen/features/appointment/presentation/widgets/appointment_tile.dart';
import 'package:mysen/features/appointment/presentation/widgets/child_phone.dart';
import 'package:mysen/features/appointment/presentation/widgets/price_details.dart';
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
    final getAppointemntProvider = ref.watch(appointmentProvider);
    return getAppointemntProvider.when(
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
            if (data.isEmpty)
              const Expanded(child: DataEmbity())
            else
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
                : const SizedBox.shrink(),
          ],
        );
      },
      error: (error, stackTrace) {
        return CustomErrorWidget(
          error: error,
          onPressed: () {
            ref.invalidate(appointmentProvider);
          },
          isScaffold: false,
        );
      },
      loading: () {
        return Center(
          child: CircularProgressIndicator(color: context.primaryContainer),
        );
      },
    );
  }
}
