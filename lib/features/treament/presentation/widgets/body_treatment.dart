import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
  const BodyTreatment({super.key, required this.dp, required this.isDoctor});

  final DoctorPateint dp;
  final bool isDoctor;

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
              delete: isDoctor
                  ? IconButton(
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
                              context.pop();
                            },
                            title: context.tr.deleteConfirmation,
                            isLoading: refTreatment.isLoading,
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete),
                    )
                  : null,

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
                              isDcotor: isDoctor,
                            ),
                          );
                        },
                        icon: const Icon(Icons.bookmark_added),
                      ),
                    ),
                    isDoctor
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
        return CustomErrorWidget(
          ref: ref,
          error: error,
          onPressed: () {
            ref.invalidate(treatmentProvider);
          },
        );
      },
      loading: () => Center(
        child: CircularProgressIndicator(color: context.primaryContainer),
      ),
    );
  }
}
