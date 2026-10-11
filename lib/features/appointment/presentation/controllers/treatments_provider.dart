import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/features/appointment/domain/entities/appointment.dart';
import 'package:mysen/features/appointment/presentation/controllers/dependecies.dart';

class AppointmentProvider extends AsyncNotifier<List<Appointment>> {
  @override
  FutureOr<List<Appointment>> build() {
    return getAppointment();
  }

  Future<List<Appointment>> getAppointment() async {
    state = const AsyncLoading();
    final getAppointment = await ref.read(getAppointmentProvider)();
    return getAppointment.fold((l) {
      state = AsyncValue.error(l, StackTrace.current);
      throw l;
    }, (r) => r);
  }

  Future<void> getAppointmentByDpID(String dpID) async {
    state = const AsyncLoading();
    final getAppointment = await ref.read(getAppointmentByDpIDProvider)(dpID);
    return getAppointment.fold(
      (l) {
        state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        final currentTreatment = state.value ?? [];
        state = AsyncData([...currentTreatment, ...r]);
      },
    );
  }
}

class TeethAddProvider extends Notifier<List<Map>> {
  @override
  build() {
    return [];
  }

  void setTeeh(Map map) {
    state = [...state, map];
  }

  void removTeeh(List<String> teethSelect) {
    final currentState = state.where(
      (element) => teethSelect.contains(element['number']),
    );
    state = [...currentState];
  }
}
