import 'package:flutter/material.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/backed.dart';
import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';
import 'package:mysen/features/treament/presentation/widgets/body_treatment.dart';
import 'package:mysen/features/treament/presentation/widgets/bottomnavigationbar_treatment.dart';

class TreatmentCaseScreen extends StatelessWidget {
  const TreatmentCaseScreen({
    super.key,
    required this.dp,
    required this.isDoctor,
  });
  final DoctorPateint dp;
  final bool isDoctor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: isDoctor
          ? BottomNavigationBarTreatment(dp: dp)
          : null,
      appBar: AppBar(
        toolbarHeight: context.mediaSize.shortestSide * .15,
        leadingWidth: context.mediaSize.shortestSide * .15,

        leading: const Backed(),
        automaticallyImplyLeading: false,
        title: Text(context.tr.treatmentList, style: context.titleLarge),
        centerTitle: true,

        backgroundColor: context.primarycolor,
      ),

      body: BodyTreatment(dp: dp, isDoctor: isDoctor),
    );
  }
}
