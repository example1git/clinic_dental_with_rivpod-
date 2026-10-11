import 'package:flutter/material.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/backed.dart';
import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';
import 'package:mysen/features/treament/presentation/widgets/body_treatment.dart';
import 'package:mysen/features/treament/presentation/widgets/bottomnavigationbar_treatment.dart';

class TreatmentCase extends StatelessWidget {
  const TreatmentCase({super.key, required this.dp});
  final DoctorPateint dp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primarycolor,
      bottomNavigationBar: BottomNavigationBarTreatment(dp: dp),
      appBar: AppBar(
        toolbarHeight: context.mediaSize.shortestSide * .15,
        leadingWidth: context.mediaSize.shortestSide * .15,

        leading: const Backed(),
        automaticallyImplyLeading: false,
        title: Text(dp.patientFullName, style: context.titleLarge),
        centerTitle: true,

        backgroundColor: context.primarycolor,
      ),
      body: BodyTreatment(dp: dp),
    );
  }
}
