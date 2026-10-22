import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/features/request/domain/entities/request_reservation.dart';
import 'package:mysen/features/request/presentation/controllers/dependecies.dart';

class RequestReservationProvider
    extends AsyncNotifier<List<RequestReservation>> {
  @override
  FutureOr<List<RequestReservation>> build() async {
    final getRequestReservation = await ref.read(
      getRequestReservationProvider,
    )();
    return getRequestReservation.fold((l) {
      state = AsyncValue.error(l, StackTrace.current);
      throw l;
    }, (r) => r);
  }

  Future<void> upsertRequestReservation(
    RequestReservation requestReservation,
  ) async {
    state = const AsyncLoading();
    final upsertRequestReservation = await ref.read(
      upsertRequestReservationProvider,
    )(requestReservation);
    upsertRequestReservation.fold(
      (l) {
        state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        final currentrequestReservation = state.value ?? [];

        state = AsyncData([...currentrequestReservation, r]);
      },
    );
  }

  Future<void> updateRequestReservation(
    RequestReservation requestReservation,
  ) async {
    state = const AsyncLoading();
    final updateRequestReservation = await ref.read(
      updateRequestReservationProvider,
    )(requestReservation);
    updateRequestReservation.fold(
      (l) {
        state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        final currentrequestReservation = state.value ?? [];

        state = AsyncData([...currentrequestReservation, r]);
      },
    );
  }
}
