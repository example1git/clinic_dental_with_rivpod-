import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/alert.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';
import 'package:mysen/features/doctor/presentation/controllers/dependecies.dart';

class StateWorking extends StatelessWidget {
  const StateWorking({super.key, required this.doctor});

  final Doctor doctor;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsetsGeometry.all(context.padding),
        child: Consumer(
          builder: (context, ref, child) {
            final isloading = ref.watch(doctorProvider).isLoading;
            return Switch(
              value: doctor.isWorking,
              onChanged: (value) {
                Utils.showMyDialog(
                  heightFactor: .3,
                  widthFactor: .8,
                  colorDialog: context.colorScheme.error,
                  context: context,
                  child: Alert(
                    confirme: () {
                      ref
                          .read(doctorProvider.notifier)
                          .updateDoctor(doctor.copyWith(isWorking: value));
                    },
                    title: doctor.isWorking
                        ? context.tr.changeToHolidayM
                        : context.tr.changeToWorkM,
                    isLoading: isloading,
                  ),
                );
              },
              inactiveThumbColor: blackcolor,

              trackColor: WidgetStatePropertyAll(context.primaryContainer),
            );
          },
        ),
      ),
    );
  }
}
