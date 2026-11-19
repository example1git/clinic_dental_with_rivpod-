import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/alert.dart';
import 'package:mysen/core/widget/close.dart';
import 'package:mysen/core/widget/error_widget.dart';
import 'package:mysen/features/appointment/presentation/pages/appointment_list.dart';
import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';
import 'package:mysen/features/treament/presentation/controllers/dependecies.dart';

class ListDeleteTreatment extends ConsumerWidget {
  const ListDeleteTreatment({super.key, required this.dp});

  final DoctorPateint dp;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refTreatment = ref.watch(treatmentProvider);
    final notfire = ref.read(treatmentProvider.notifier);

    return refTreatment.when(
      data: (data) {
        final treatments = data
            .where(
              (element) =>
                  element.treatmentSatus == TreatmentSatus.canceled &&
                  element.doctorPatientID == dp.id,
            )
            .toList();
        return Column(
          children: [
            Stack(
              alignment: AlignmentGeometry.center,

              children: [
                Text(
                  context.tr.deletedTreatmentPlans,
                  style: context.titleLarge,
                ),
                const Closed(),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: treatments.length,
                itemBuilder: (BuildContext context, int index) {
                  final treatment = treatments[index];
                  return Card(
                    margin: EdgeInsets.all(context.margin),
                    color: context.primarycolor.withAlpha(10),
                    child: Padding(
                      padding: EdgeInsets.all(context.padding),
                      child: Row(
                        children: [
                          IconButton(
                            style: context.iconButtonStyle,
                            onPressed: () {
                              Utils.showMyDialog(
                                context: context,
                                child: AppointmentList(
                                  treatment: treatment,
                                  doctorPateint: dp,
                                  isDcotor: true,
                                ),
                              );
                            },
                            icon: const Icon(Icons.bookmark_add),
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  context.tr.treatmentCase,
                                  style: context.bodyLarge,
                                ),
                                Text(
                                  textDirection: ui.TextDirection.ltr,
                                  textAlign: TextAlign.center,
                                  DateFormat('yyyy-MM-dd hh:mm a')
                                      .format(treatment.createdTime),
                                  style: context.bodyMeduim,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            style: context.iconButtonStyle,
                            onPressed: () {
                              Utils.showMyDialog(
                                context: context,
                                heightFactor: .3,
                                widthFactor: .8,

                                colorDialog: context.colorScheme.error,

                                child: Alert(
                                  confirme: () {
                                    notfire.updateTreatmentCases(
                                      treatment.copyWith(
                                        treatmentSatus: TreatmentSatus.active,
                                      ),
                                    );
                                    context.pop();
                                  },
                                  title: context.tr.restoreTreatmentPlanM,
                                  isLoading: refTreatment.isLoading,
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.replay_rounded,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) =>
          CustomErrorWidget(ref: ref, error: error, onPressed: () {}),
      loading: () => Center(
        child: CircularProgressIndicator(color: context.primaryContainer),
      ),
    );
  }
}
