import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';
import 'package:mysen/features/doctor/presentation/controllers/dependecies.dart';

class DoctorProvider extends AsyncNotifier<Doctor?> {
  @override
  FutureOr<Doctor?> build() async {
    final getDoctor = await ref.read(getDoctorByUseridProvider)();
    return getDoctor.fold(
      (l) {
        Error.throwWithStackTrace(l, StackTrace.current);
      },
      (r) {
        ref
            .read(equlatificationsProvider.notifier)
            .setEqulatifications(r?.equlatifications ?? []);
        return r;
      },
    );
  }

  Future<void> reload() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> updateDoctor(Doctor doctor) async {
    state = const AsyncLoading();
    final doctorUpdate = await ref.read(updateDoctorProvider)(doctor);
    doctorUpdate.fold(
      (l) {
        state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        state = AsyncValue.data(r);
      },
    );
  }

  Future<void> uploadImage(File file, Doctor doctor) async {
    state = const AsyncLoading();
    final upload = await ref.read(uploadImageProvider)(file, doctor);
    upload.fold(
      (l) {
        state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        state = AsyncValue.data(doctor.copyWith(imgUrl: r));
      },
    );
  }
}

class EqulatificationsProvider extends Notifier<List<String>> {
  @override
  List<String> build() {
    return [];
  }

  void setEqulatifications(List<String> eq) {
    state = eq;
  }

  void addEqulatifications(String eq) {
    state = [...state, eq];
  }

  void removeEqulatifications(String eq) {
    final currentState = state.where((element) => element != eq).toList();
    state = currentState;
  }
}
