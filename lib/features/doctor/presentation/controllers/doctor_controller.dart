import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';
import 'package:mysen/features/doctor/domain/usecases/get_doctor_by_userid.dart';
import 'package:mysen/features/doctor/domain/usecases/update_doctor.dart';

class DoctorController extends GetxController {
  final GetDoctorByUserid getDoctorByUserid;
  final UpdateDoctor updateDoctor;
  DoctorController({
    required this.getDoctorByUserid,
    required this.updateDoctor,
  });
  TextEditingController nameController = TextEditingController();
  TextEditingController nickNamecontroller = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Rxn<Doctor> doctor = Rxn<Doctor>();
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  Future<void> fetchDoctorByUserID() async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await getDoctorByUserid();
    result.fold(
      (left) {
        errorMessage.value = left.message;
      },
      (data) {
        doctor.value = data;
      },
    );
    isLoading.value = false;
  }

  Future<void> editDoctor(Doctor doctoru) async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await updateDoctor(doctoru);
    result.fold(
      (left) {
        errorMessage.value = left.message;
      },
      (data) {
        doctor.value = data;
      },
    );
    isLoading.value = false;
  }
}
