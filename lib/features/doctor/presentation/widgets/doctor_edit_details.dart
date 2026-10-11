import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';
import 'package:mysen/features/doctor/presentation/controllers/dependecies.dart';
import 'package:mysen/features/doctor/presentation/widgets/doctor_edit_equ.dart';
import 'package:mysen/features/doctor/presentation/widgets/doctor_edit_location.dart';
import 'package:mysen/features/doctor/presentation/widgets/doctor_edit_numbers.dart';

class DoctorEditDetails extends ConsumerWidget {
  DoctorEditDetails({super.key, required this.doctor});
  final Doctor doctor;
  File? file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          doctor.isWorking ? context.tr.workStatus : context.tr.holidayStatus,
          style: context.bodyMeduim,
        ),
        OutlinedButton.icon(
          icon: Icon(
            Icons.add,
            size: context.iconSize,

            color: context.primaryContainer,
          ),
          style: context.outlinedButtonStyle?.copyWith(
            minimumSize: WidgetStatePropertyAll(
              Size(
                context.mediaSize.width / 4,
                context.mediaSize.shortestSide * .1,
              ),
            ),
          ),
          onPressed: () async {
            final img = await getImage();
            if (img) {
              ref.read(doctorProvider.notifier).uploadImage(file!, doctor);
            }
          },
          label: Text(
            context.tr.addImage,
            style: context.bodyMeduim?.copyWith(color: whitecolor),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              style: context.iconButtonStyle,
              onPressed: () {
                Utils.showMyDialog(
                  widthFactor: .8,

                  heightFactor: 1,

                  context: context,
                  child: LocationDoctorEdit(doctor: doctor),
                );
              },
              icon: const Icon(Icons.location_on),
            ),
            ExpandIcon(
              size: context.iconSize,
              color: context.primaryContainer,
              onPressed: (value) {
                Utils.showMyDialog(
                  context: context,
                  child: DoctorEditEqu(doctor: doctor),
                );
              },
            ),
            IconButton(
              style: context.iconButtonStyle,
              onPressed: () {
                Utils.showMyDialog(
                  widthFactor: .8,
                  context: context,
                  child: Editnumbers(doctor: doctor),
                );
              },
              icon: const Icon(Icons.phone_android),
            ),
          ],
        ),
      ],
    );
  }

  Future<bool> getImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? xFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (xFile != null) {
      file = File(xFile.path);
      return true;
    }
    return false;
  }
}
