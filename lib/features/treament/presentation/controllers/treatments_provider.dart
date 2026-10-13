import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';
import 'package:mysen/features/treament/presentation/controllers/dependecies.dart';

class TreatmentsProvider extends AsyncNotifier<List<TreatmentCase>> {
  @override
  FutureOr<List<TreatmentCase>> build() async {
    final treatments = await ref.read(getTreatmentsProvider)();
    return treatments.fold((l) {
      state = AsyncValue.error(l, StackTrace.current);
      throw l;
    }, (r) => r);
  }

  Future<void> getTreatmentCasesByDpID(String dpID) async {
    state = const AsyncLoading();
    final treatments = await ref.read(getTreatmentByDpIDProvider)(dpID);
    return treatments.fold(
      (l) {
        state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        final currentTreatment = state.value ?? [];
        state = AsyncData([...currentTreatment, ...r]);
      },
    );
  }

  Future<void> addTreatmentCases(TreatmentCase treament) async {
    state = const AsyncLoading();
    final treatment = await ref.read(addTreatmentProvider)(treament);
    return treatment.fold(
      (l) {
        state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        final currentTreatment = state.value ?? [];

        state = AsyncData([...currentTreatment, r]);
      },
    );
  }

  Future<void> deleteTreatmentCases(TreatmentCase treament) async {
    state = const AsyncLoading();
    final treatments = await ref.read(deleteTreatmentProvider)(treament);
    return treatments.fold(
      (l) {
        state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        final currentTreatment = state.value ?? [];
        final treatments = currentTreatment.where(
          (element) => element.id != r.id,
        );

        state = AsyncData([...treatments, r]);
      },
    );
  }
}
