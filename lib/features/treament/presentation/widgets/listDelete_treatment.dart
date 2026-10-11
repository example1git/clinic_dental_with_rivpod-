import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/doctor/controller/appointment_controller.dart';
import 'package:mysen/features/doctor/controller/treatment_controller.dart';
import 'package:mysen/features/doctor/widget/child_phone.dart';
import 'package:mysen/features/shared/model/patientsfordoctor.dart';
import 'package:mysen/features/shared/widget/alert.dart';
import 'package:mysen/features/shared/widget/appointment_show.dart';
import 'package:mysen/features/shared/widget/close.dart';

class ListDeleteTreatment extends StatelessWidget {
  const ListDeleteTreatment({
    super.key,
    required this.treatmentController,
    required this.dp,
    required this.appointmentController,
  });

  final TreatmentController treatmentController;
  final AppointmentController appointmentController;

  final Patientsfordoctor dp;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentGeometry.center,

          children: [
            Text('deletedTreatmentPlans'.tr, style: context.titleLarge),
            const Closed(),
          ],
        ),
        Expanded(
          child: Obx(
            () => ListView.builder(
              itemCount: treatmentController.treatmentCaseCanceled.length,
              itemBuilder: (BuildContext context, int index) {
                final treatment =
                    treatmentController.treatmentCaseCanceled[index];

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
                              child: Obx(
                                () => AppointmentShow(
                                  appointments: appointmentController
                                      .appointMentsTreatemnt(treatment),

                                  phone: dp.phone,

                                  colorized: appointmentController
                                      .colorizedLeading(treatment.id),
                                  treatment: treatment,
                                  childAppointment: ChildPhone(phone: dp.phone),
                                  payPaid: appointmentController.payPaid(
                                    treatment,
                                  ),
                                ),
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
                                'treatmentcase'.tr,
                                style: context.bodyLarge,
                              ),
                              Text(
                                textDirection: ui.TextDirection.ltr,
                                textAlign: TextAlign.center,
                                DateFormat(
                                  'yyyy-MM-dd hh:mm a',
                                ).format(treatment.createdAt!),
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
                                  treatmentController.updateTreatmentCase(
                                    treatment,
                                  );
                                },
                                title: 'restoreTreatmentPlanM'.tr,
                                isLoading: treatmentController.isLoading,
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
        ),
      ],
    );
  }
}
