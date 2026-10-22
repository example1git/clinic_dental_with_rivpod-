import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/error.dart';
import 'package:mysen/core/my_form_textfiled.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/core/widget/close.dart';
import 'package:mysen/features/doctor/presentation/controllers/dependecies.dart';
import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';
import 'package:mysen/features/doctor_patient/presentation/controllers/dependecies.dart';
import 'package:mysen/features/patient/domain/entities/patient.dart';
import 'package:mysen/features/patient/presentation/controllers/dependecies.dart';
import 'package:mysen/features/patient/presentation/controllers/patient_phone_provider.dart';

class FormAddpatient extends StatefulWidget {
  const FormAddpatient({super.key});

  @override
  State<FormAddpatient> createState() => _FormAddpatientState();
}

class _FormAddpatientState extends State<FormAddpatient> {
  GlobalKey<FormState> formKey = GlobalKey();
  late TextEditingController nameController;
  late TextEditingController nickNamecontroller;
  late TextEditingController phoneController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    nickNamecontroller = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    nickNamecontroller.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: context.spacing,
          children: [
            Stack(
              alignment: AlignmentGeometry.center,
              children: [
                const Closed(),
                Text(
                  context.tr.createPatients,
                  style: context.titleLarge?.copyWith(
                    color: context.primaryContainer,
                  ),
                ),
              ],
            ),
            MytexFormFiled(
              filled: false,

              controller: nameController,
              label: context.tr.name,
              validate: Validate.name,
            ),
            MytexFormFiled(
              filled: false,

              controller: nickNamecontroller,
              label: context.tr.nickName,
              validate: Validate.nickName,
            ),

            MytexFormFiled(
              filled: false,
              validate: Validate.phone,
              keyboardType: TextInputType.number,
              controller: phoneController,
              label: context.tr.phone,
              prefixText: '966+:',
            ),

            Consumer(
              builder: (context, ref, child) => FractionallySizedBox(
                widthFactor: .8,
                child: OutlinedButton(
                  style: context.outlinedButtonStyle,
                  onPressed: () {
                    addPatient(ref, context);
                  },
                  child: Text(context.tr.add, style: context.bodyMeduim),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addPatient(WidgetRef ref, BuildContext contex) async {
    if (!formKey.currentState!.validate()) return;
    final dp = await ref.read(doctorPatientProvider.future);
    if (dp.any((e) => e.patientphone == phoneController.text.trim())) {
      MessageHandle.handleMessage(MessageType.patientExist, contex);
    }
    final doctorPatientNotfir = ref.read(doctorPatientProvider.notifier);

    final fullName =
        ('${nameController.text.trim()} ${nickNamecontroller.text.trim()}')
            .replaceAll(RegExp(r'\s+'), ' ');
    final doctor = await ref.read(doctorProvider.future);
    final patient = await ref.read(
      patientByPhoneProvider(phoneController.text.trim()).future,
    );
    if (doctor == null) {
      return;
    }
    final doctorPatient = DoctorPateint(
      id: '',
      doctorID: doctor.id,
      patientID: '',
      doctorFullName: '',
      patientFullName: fullName,
      patientphone: phoneController.text.trim(),
    );
    if (patient == null) {
      final addPatient = await ref
          .read(patientProvider.notifier)
          .addPatient(
            Patient(
              id: '',
              fullName: fullName,
              phone: phoneController.text.trim(),
            ),
          );
      await doctorPatientNotfir.upsertDoctorPatient(
        doctorPatient.copyWith(
          patientID: addPatient.id,
          isDeletePatient: addPatient.userID == null,
        ),
      );
      return;
    }
    await doctorPatientNotfir.upsertDoctorPatientAndAllTreamentAndAppointment(
      doctorPatient.copyWith(
        patientID: patient.id,
        isDeletePatient: patient.userID == null,
      ),
    );
  }
}
