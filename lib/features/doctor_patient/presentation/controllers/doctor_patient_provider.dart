import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/features/appointment/presentation/controllers/dependecies.dart';
import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';
import 'package:mysen/features/doctor_patient/presentation/controllers/dependecies.dart';
import 'package:mysen/features/treament/presentation/controllers/dependecies.dart';

class DoctorPatientProvider extends AsyncNotifier<List<DoctorPateint>> {
  @override
  FutureOr<List<DoctorPateint>> build() {
    return getDoctorPatient();
  }

  Future<List<DoctorPateint>> getDoctorPatient() async {
    state = const AsyncLoading();
    final doctorPatient = await ref.read(getDoctorPatientProvider)();
    return doctorPatient.fold((l) {
      state = AsyncValue.error(l, StackTrace.current);
      throw l;
    }, (r) => r);
  }

  Future<void> upsertDoctorPatient(DoctorPateint doctorPatient) async {
    state = const AsyncLoading();
    final doctorPatientUpsert = await ref.read(upsertDoctorPatientProvider)(
      doctorPatient,
    );
    doctorPatientUpsert.fold(
      (l) {
        state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        final currentDoctorPatients = state.value ?? [];

        state = AsyncData([...currentDoctorPatients, r]);
      },
    );
  }

  Future<void> upsertDoctorPatientAndAllTreamentAndAppointment(
    DoctorPateint doctorPatient,
  ) async {
    state = const AsyncLoading();

    final doctorPatientUpsert = await ref.read(upsertDoctorPatientProvider)(
      doctorPatient,
    );
    await ref
        .read(treatmentProvider.notifier)
        .getTreatmentCasesByDpID(doctorPatient.id);
    await ref
        .read(appointmentProvider.notifier)
        .getAppointmentByDpID(doctorPatient.id);
    doctorPatientUpsert.fold(
      (l) {
        state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        final currentDoctorPatients = state.value ?? [];

        state = AsyncData([...currentDoctorPatients, r]);
      },
    );
  }

  Future<void> updateDoctorPatient(DoctorPateint doctorPatient) async {
    state = const AsyncLoading();
    final doctorPatientUpdate = await ref.read(updateDoctorPatientProvider)(
      doctorPatient,
    );
    doctorPatientUpdate.fold(
      (l) {
        state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        final currentDoctorPatients = state.value ?? [];

        final updatedList = currentDoctorPatients.map((dp) {
          if (dp.id == r.id) {
            return r;
          }
          return dp;
        }).toList();

        state = AsyncValue.data(updatedList);
      },
    );
  }

  Future<void> deleteDoctorPatient(DoctorPateint doctorPatient) async {
    state = const AsyncLoading();
    final doctorPatientdelete = await ref.read(deleteDoctorPatientProvider)(
      doctorPatient,
    );
    doctorPatientdelete.fold(
      (l) {
        state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        final currentDoctorPatients = state.value ?? [];
        final updatedList = currentDoctorPatients
            .where((element) => element.id != doctorPatient.id)
            .toList();

        state = AsyncData(updatedList);
      },
    );
  }
}
