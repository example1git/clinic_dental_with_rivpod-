import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/doctor/controller/appointment_controller.dart';

class DescriptionsButton extends StatelessWidget {
  final AppointmentController appointmentController;
  const DescriptionsButton({super.key, required this.appointmentController});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) =>
            Divider(color: context.primaryContainer),
        itemCount: appointmentController.teethAdd.length,
        itemBuilder: (BuildContext context, int index) {
          final teeth = appointmentController.teethAdd[index];
          return Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(style: context.bodyMeduim, teeth['description']),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FaIcon(
                      size: context.mediaSize.shortestSide * .04,
                      FontAwesomeIcons.tooth,
                      color: whitecolor,
                    ),
                    Text(style: context.bodyMeduim, teeth['number']),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
