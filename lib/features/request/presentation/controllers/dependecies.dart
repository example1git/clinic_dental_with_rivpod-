import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/provider/providers.dart';
import 'package:mysen/features/request/data/datasources/request_reservation_local_data_source.dart';
import 'package:mysen/features/request/data/datasources/request_reservation_remote_data_source.dart';
import 'package:mysen/features/request/data/repositories/request_reservation_repository.dart';
import 'package:mysen/features/request/domain/entities/request_reservation.dart';
import 'package:mysen/features/request/domain/repositories/request_reservation_repository.dart';
import 'package:mysen/features/request/domain/usecases/get_request_reservation.dart';
import 'package:mysen/features/request/domain/usecases/update_request_reservation.dart';
import 'package:mysen/features/request/domain/usecases/upsert_request_reservation.dart';
import 'package:mysen/features/request/presentation/controllers/request_reservation_provider.dart';

final requestReservationRepositoryProvider =
    Provider<RequestReservationRepository>(
      (ref) => RequestReservationRepositoryImp(
        internetService: ref.watch(internetServiceProvider),
        requestReservationRemoteDataSource: ref.watch(
          requestReservationRemoteDataSourceProvider,
        ),
        requestReservationLocalDataSource: ref.watch(
          requestReservationLocalDataSourceProvider,
        ),
      ),
    );
final requestReservationRemoteDataSourceProvider =
    Provider<RequestReservationRemoteDataSource>(
      (ref) => RequestReservationRemoteDataSource(client: client),
    );
final requestReservationLocalDataSourceProvider =
    Provider<RequestReservationLocalDataSource>(
      (ref) => RequestReservationLocalDataSource(),
    );

final getRequestReservationProvider = Provider<GetRequstReserve>(
  (ref) => GetRequstReserve(
    repository: ref.watch(requestReservationRepositoryProvider),
  ),
);

final upsertRequestReservationProvider = Provider<UpsertRequestReservation>(
  (ref) => UpsertRequestReservation(
    repository: ref.watch(requestReservationRepositoryProvider),
  ),
);
final updateRequestReservationProvider = Provider<UpdateRequestReservation>(
  (ref) => UpdateRequestReservation(
    repository: ref.watch(requestReservationRepositoryProvider),
  ),
);

final requestReservationProvider =
    AsyncNotifierProvider<RequestReservationProvider, List<RequestReservation>>(
      RequestReservationProvider.new,
    );
