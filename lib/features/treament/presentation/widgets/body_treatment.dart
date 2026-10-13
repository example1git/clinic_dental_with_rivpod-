import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/alert.dart';
import 'package:mysen/core/widget/card_treatment.dart';
import 'package:mysen/core/widget/error_widget.dart';
import 'package:mysen/features/appointment/presentation/pages/appointment_dialog.dart';
import 'package:mysen/features/appointment/presentation/pages/appointment_list.dart';
import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';
import 'package:mysen/features/treament/presentation/controllers/dependecies.dart';

class BodyTreatment extends ConsumerWidget {
  const BodyTreatment({
    super.key,
    required this.dp,
    required this.isWidgetAddAppointment,
  });

  final DoctorPateint dp;
  final bool isWidgetAddAppointment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refTreatment = ref.watch(treatmentProvider);
    final notfire = ref.read(treatmentProvider.notifier);

    return refTreatment.when(
      data: (data) {
        final treatments = data
            .where(
              (element) =>
                  element.treatmentSatus == TreatmentSatus.active &&
                  element.doctorPatientID == dp.id,
            )
            .toList();
        return ListView.builder(
          itemCount: treatments.length,
          itemBuilder: (BuildContext context, int index) {
            final treatment = treatments[index];

            return CardTreatment(
              treatment: treatment,
              delete: IconButton(
                style: context.iconButtonStyle,
                onPressed: () {
                  Utils.showMyDialog(
                    context: context,
                    heightFactor: .3,
                    widthFactor: .8,

                    colorDialog: context.colorScheme.error,
                    child: Alert(
                      confirme: () {
                        notfire.deleteTreatmentCases(treatment);
                      },
                      title: context.tr.deleteConfirmation,
                      isLoading: false,
                    ),
                  );
                },
                icon: const Icon(Icons.delete),
              ),

              leading: SizedBox(
                width: context.mediaSize.width * .2,
                child: Row(
                  children: [
                    Expanded(
                      child: IconButton(
                        style: context.iconButtonStyle,
                        onPressed: () {
                          Utils.showMyDialog(
                            context: context,
                            child: AppointmentList(
                              treatment: treatment,
                              doctorPateint: dp,
                            ),
                          );
                        },
                        icon: const Icon(Icons.bookmark_added),
                      ),
                    ),
                    isWidgetAddAppointment
                        ? Expanded(
                            child: IconButton(
                              style: context.iconButtonStyle,
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => AppointmetDialog(
                                      treatmentCase: treatment,
                                      dp: dp,
                                    ),
                                  ),
                                );
                              },

                              icon: const Icon(Icons.add),
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            );
          },
        );
      },
      error: (error, stackTrace) {
        return CustomErrorWidget(ref: ref, error: error, onPressed: () {});
      },
      loading: () => Center(
        child: CircularProgressIndicator(color: context.primaryContainer),
      ),
    );
  }
}
