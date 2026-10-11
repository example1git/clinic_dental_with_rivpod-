import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/my_form_textfiled.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/close.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';
import 'package:mysen/features/doctor/presentation/controllers/dependecies.dart';

class LocationDoctorEdit extends StatefulWidget {
  const LocationDoctorEdit({super.key, required this.doctor});

  final Doctor doctor;

  @override
  State<LocationDoctorEdit> createState() => _LocationDoctorEditState();
}

class _LocationDoctorEditState extends State<LocationDoctorEdit> {
  late TextEditingController locationcontroller;
  GlobalKey<FormState> formKeyLocation = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    locationcontroller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    locationcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: context.mediaSize.shortestSide * .05,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: AlignmentGeometry.center,
          children: [
            const Closed(),
            Row(
              spacing: context.mediaSize.shortestSide * .02,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  size: context.iconSize,
                  Icons.location_on,
                  color: context.colorScheme.error,
                ),
                Text(context.tr.addLocation, style: context.titleLarge),
              ],
            ),
          ],
        ),
        Form(
          key: formKeyLocation,

          child: MytexFormFiled(
            filled: false,
            controller: locationcontroller,
            label: context.tr.location,
            validate: Validate.location,
          ),
        ),

        FractionallySizedBox(
          widthFactor: 1,
          child: Text(widget.doctor.location, style: context.bodyMeduim),
        ),

        FractionallySizedBox(
          widthFactor: 1,
          child: Consumer(
            builder: (context, ref, child) => OutlinedButton(
              style: context.outlinedButtonStyle,
              onPressed: () {
                if (!formKeyLocation.currentState!.validate()) {
                  return;
                }
                final doctor = widget.doctor.copyWith(
                  location: locationcontroller.text.trim(),
                );
                ref.read(doctorProvider.notifier).updateDoctor(doctor);
              },
              child: Text(context.tr.done, style: context.bodyMeduim),
            ),
          ),
        ),
      ],
    );
  }
}
