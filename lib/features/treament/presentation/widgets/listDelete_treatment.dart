import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/alert.dart';
import 'package:mysen/core/widget/close.dart';
import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';


class ListDeleteTreatment extends StatelessWidget {
  const ListDeleteTreatment({
    super.key,
    required this.dp,
  });


  final DoctorPateint dp;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentGeometry.center,

          children: [
            Text( context.tr.deletedTreatmentPlans, style: context.titleLarge),
            const Closed(),
          ],
        ),
        Expanded(
          child:  ListView.builder(
              // itemCount: treatmentController.treatmentCaseCanceled.length,
              itemCount:2,
              itemBuilder: (BuildContext context, int index) {
                final treatment = TreatmentCase(id: '', doctorPatientID: '', totalPrice: 100, treatmentSatus: TreatmentSatus.active, createdTime: DateTime.now());
                    // treatmentController.treatmentCaseCanceled[index];

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
                              child:SizedBox.shrink(),
                                // AppointmentShow(
                                //   appointments: appointmentController
                                //       .appointMentsTreatemnt(treatment),

                                //   phone: dp.phone,

                                //   colorized: appointmentController
                                //       .colorizedLeading(treatment.id),
                                //   treatment: treatment,
                                //   childAppointment: ChildPhone(phone: dp.phone),
                                //   payPaid: appointmentController.payPaid(
                                //     treatment,
                                //   ),
                                // ),
                              
                              
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
                                  // treatmentController.updateTreatmentCase(
                                  //   treatment,
                                  // );
                                },
                                title:  context.tr.restoreTreatmentPlanM,
                                isLoading:false
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
  }
}
