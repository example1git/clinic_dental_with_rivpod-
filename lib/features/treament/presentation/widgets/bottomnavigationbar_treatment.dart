import 'package:flutter/material.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/doctor/presentation/widgets/card_bottom_navigation_bar.dart';
import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';
import 'package:mysen/features/treament/presentation/widgets/form_treatment.dart';
import 'package:mysen/features/treament/presentation/widgets/list_delete_treatment.dart';

class BottomNavigationBarTreatment extends StatelessWidget {
  const BottomNavigationBarTreatment({super.key, required this.dp});

  final DoctorPateint dp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.padding),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CardBottomNavigationBar(
            iconData: Icons.add,
            onPressed: () {
              Utils.showMyDialog(
                widthFactor: .8,
                context: context,
                child: FormTreatment(dp: dp),
              );
            },
          ),
          CardBottomNavigationBar(
            iconData: Icons.delete_forever_rounded,
            onPressed: () {
              Utils.showMyDialog(
                context: context,
                child: ListDeleteTreatment(dp: dp),
              );
            },
          ),
        ],
      ),
    );
  }
}
