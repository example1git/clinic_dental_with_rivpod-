import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/features/appointment/domain/entities/appointment.dart';
import 'package:mysen/features/appointment/presentation/controllers/dependecies.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';

class AppointmentProvider extends AsyncNotifier<List<Appointment>> {
  @override
  FutureOr<List<Appointment>> build() async {
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

  Future<void> addppointment(Appointment appointemnt) async {
    state = const AsyncLoading();
    final getAppointment = await ref.read(addAppointmentProvider)(appointemnt);
    return getAppointment.fold(
      (l) {
        state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        final currentTreatment = state.value ?? [];
        state = AsyncData([...currentTreatment, r]);
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

  void updateTeeh(Map map) {
    final teehts = state
        .where((element) => element['number'] != map['number'])
        .toList();
    state = [...teehts, map];
  }

  void removTeeh(List<String> teethSelect) {
    final currentState = state.where(
      (element) => teethSelect.contains(element['number']),
    );
    state = [...currentState];
  }
}

class PayPaidProvider extends Notifier<int> {
  @override
  build() {
    return 0;
  }

  Future<void> getPayPaid(TreatmentCase treatment) async {
    int paypaid = 0;
    final appointMents = await ref.read(appointmentProvider.future);
    final appointMentsTreatment = appointMents.where(
      (element) => element.treatmentCaseID == treatment.id,
    );
    for (var app in appointMentsTreatment) {
      paypaid = paypaid + app.payPrice;
    }
    state = paypaid;
  }
}

class RemainingProvider extends Notifier<int> {
  @override
  build() {
    return 0;
  }

  Future<void> setRemaining(int remaining) async {
    state = remaining;
  }
}
