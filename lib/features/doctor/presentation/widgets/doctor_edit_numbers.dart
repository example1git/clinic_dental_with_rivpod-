import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/error.dart';
import 'package:mysen/core/my_form_textfiled.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/close.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';
import 'package:mysen/features/doctor/presentation/controllers/dependecies.dart';

class Editnumbers extends StatefulWidget {
  const Editnumbers({super.key, required this.doctor});

  final Doctor doctor;

  @override
  State<Editnumbers> createState() => _EditnumbersState();
}

class _EditnumbersState extends State<Editnumbers> {
  late TextEditingController whatscontroller;
  GlobalKey<FormState> formKeyPhone = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    whatscontroller = TextEditingController();
    whatscontroller.text = widget.doctor.phone['whatsApp'];
  }

  @override
  void dispose() {
    super.dispose();
    whatscontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeyPhone,
      child: Column(
        spacing: context.mediaSize.shortestSide * .05,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentGeometry.center,
            children: [
              const Closed(),
              Text(context.tr.editPhone, style: context.titleLarge),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.doctor.phone['phone'], style: context.bodyMeduim),
              IconButton(
                style: context.iconButtonStyle,
                onPressed: () {
                  MessageHandle.handleMessage(
                    MessageType.phoneDoctorEdit,
                    context,
                  );
                },
                icon: const Icon(Icons.phone_android),
              ),
            ],
          ),

          MytexFormFiled(
            filled: false,
            keyboardType: TextInputType.number,
            controller: whatscontroller,
            label: context.tr.whatsApp,
            validate: Validate.phone,
            prefixText: '966+:',
          ),

          Consumer(
            builder: (context, ref, child) => OutlinedButton(
              style: context.outlinedButtonStyle,
              onPressed: () {
                if (!formKeyPhone.currentState!.validate()) {
                  return;
                }
                final doctor = widget.doctor.copyWith(
                  phone: {'whatsApp': whatscontroller.text},
                );
                ref.read(doctorProvider.notifier).updateDoctor(doctor);
              },
              child: Text(context.tr.done, style: context.bodyMeduim),
            ),
          ),
        ],
      ),
    );
  }
}
