import 'package:flutter/material.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/alert.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';

class StateWorking extends StatelessWidget {
  const StateWorking({super.key, required this.doctor});

  final Doctor? doctor;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsetsGeometry.all(context.padding),
        child: Switch(
          value: doctor?.isWorking ?? true,
          onChanged: (value) {
            Utils.showMyDialog(
              heightFactor: .3,
              widthFactor: .8,
              colorDialog: context.colorScheme.error,
              context: context,
              child: Alert(
                confirme: () {
                  // doctoreditcontroller.updateDoctorWorking(value);
                },
                title: doctor?.isWorking ?? true
                    ? context.tr.changeToHolidayM
                    : context.tr.changeToWorkM,
                isLoading: false,
              ),
            );
          },
          inactiveThumbColor: blackcolor,

          trackColor: WidgetStatePropertyAll(context.primaryContainer),
        ),
      ),
    );
  }
}
