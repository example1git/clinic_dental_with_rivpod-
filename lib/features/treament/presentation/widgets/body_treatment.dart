import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/alert.dart';
import 'package:mysen/core/widget/card_treatment.dart';
import 'package:mysen/core/widget/error_widget.dart';
import 'package:mysen/features/appointment/presentation/widgets/appointment_dialog.dart';
import 'package:mysen/features/appointment/presentation/widgets/appointment_show.dart';
import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';
import 'package:mysen/features/treament/presentation/controllers/dependecies.dart';

class BodyTreatment extends ConsumerWidget {
  const BodyTreatment({super.key, required this.dp});

  final DoctorPateint dp;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refTreatment = ref.read(treatmentProvider);
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
                            child: AppointmentShow(
                              treatment: treatment,
                              doctorPateint: dp,
                            ),
                          );
                        },
                        icon: const Icon(Icons.bookmark_added),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        style: context.iconButtonStyle,
                        onPressed: () {
                          AppointmetDialog(treatmentCase: treatment);
                        },

                        icon: const Icon(Icons.add),
                      ),
                    ),
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
