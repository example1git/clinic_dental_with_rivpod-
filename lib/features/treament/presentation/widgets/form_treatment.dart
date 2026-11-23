import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mysen/core/my_form_textfiled.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/close.dart';
import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';
import 'package:mysen/features/treament/presentation/controllers/dependecies.dart';

class FormTreatment extends StatefulWidget {
  const FormTreatment({super.key, required this.dp});

  final DoctorPateint dp;

  @override
  State<FormTreatment> createState() => _FormTreatmentState();
}

class _FormTreatmentState extends State<FormTreatment> {
  final GlobalKey<FormState> formKeyTreatment = GlobalKey();
  late TextEditingController totalPriceController;
  @override
  void initState() {
    super.initState();
    totalPriceController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    totalPriceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeyTreatment,
      child: Column(
        spacing: context.spacing,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentGeometry.center,
            children: [
              const Closed(),
              Text(context.tr.addTreatmentPlan, style: context.titleLarge),
            ],
          ),

          MytexFormFiled(
            filled: false,
            controller: totalPriceController,
            keyboardType: TextInputType.number,
            label: context.tr.totalPrice,
            validate: Validate.price,
          ),

          Consumer(
            builder: (context, ref, child) => OutlinedButton(
              style: context.outlinedButtonStyle,
              onPressed: () {
                if (!formKeyTreatment.currentState!.validate()) {
                  return;
                }
                final treament = TreatmentCase(
                  id: '',
                  doctorPatientID: widget.dp.id,
                  totalPrice: int.parse(totalPriceController.text.trim()),
                  treatmentSatus: TreatmentSatus.active,
                  createdTime: DateTime.now(),
                );
                ref
                    .read(treatmentProvider.notifier)
                    .addTreatmentCases(treament);
                context.pop();
              },
              child: Text(context.tr.done, style: context.bodyMeduim),
            ),
          ),
        ],
      ),
    );
  }
}
