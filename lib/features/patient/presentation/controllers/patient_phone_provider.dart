import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/features/patient/domain/entities/patient.dart';
import 'package:mysen/features/patient/presentation/controllers/dependecies.dart';

final patientByPhoneProvider = FutureProvider.family<Patient?, String>((
  ref,
  phone,
) async {
  final patient = await ref.read(getPatientByPhoneProvider)(phone);
  return patient.fold((l) {
    throw l;
  }, (r) => r);
});
