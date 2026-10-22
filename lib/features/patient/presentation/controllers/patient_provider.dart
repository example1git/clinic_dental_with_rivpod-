import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/features/patient/domain/entities/patient.dart';
import 'package:mysen/features/patient/presentation/controllers/dependecies.dart';

class PatientProvider extends AsyncNotifier<Patient?> {
  @override
  FutureOr<Patient?> build() async {
    final patient = await ref.read(getPatientByUserIDProvider)();
    return patient.fold(
      (l) {
        Error.throwWithStackTrace(l, StackTrace.current);
      },
      (r) {
        return r;
      },
    );
  }

  Future<Patient> addPatient(Patient patient) async {
    final getPatient = await ref.read(addPatientProvider)(patient);
    return getPatient.fold(
      (l) {
        state = AsyncValue.error(l, StackTrace.current);
        throw l;
      },
      (r) {
        return r;
      },
    );
  }
}
