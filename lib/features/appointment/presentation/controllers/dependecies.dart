import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/provider/providers.dart';
import 'package:mysen/features/appointment/data/datasources/appointment_local_data_sorce.dart';
import 'package:mysen/features/appointment/data/datasources/appointment_remote_data_sorce.dart';
import 'package:mysen/features/appointment/data/repositories/appointment_repository.dart';
import 'package:mysen/features/appointment/domain/entities/appointment.dart';
import 'package:mysen/features/appointment/domain/repositories/appointment_repository.dart';
import 'package:mysen/features/appointment/domain/usecases/add_appointment.dart';
import 'package:mysen/features/appointment/domain/usecases/get_appointment.dart';
import 'package:mysen/features/appointment/domain/usecases/get_appointment_by_dpID.dart';
import 'package:mysen/features/appointment/presentation/controllers/appointment_date.dart';
import 'package:mysen/features/appointment/presentation/controllers/appointments_provider.dart';
import 'package:mysen/features/appointment/presentation/pages/appointment_dialog.dart';

final appointmentRepositoryProvider = Provider<AppointmentRepository>(
  (ref) => AppointmentRepositoryImp(
    internetService: ref.watch(internetServiceProvider),
    appointmentRemoteDataSorce: ref.watch(appointmentRemoteDataSourceProvider),
    appointmentLocalDataSorce: ref.watch(appointmentLocalDataSourceProvider),
  ),
);
final appointmentRemoteDataSourceProvider =
    Provider<AppointmentRemoteDataSorce>(
      (ref) => AppointmentRemoteDataSorce(client: client),
    );
final appointmentLocalDataSourceProvider = Provider<AppointmentLocalDataSorce>(
  (ref) => AppointmentLocalDataSorce(),
);
final getAppointmentProvider = Provider<GetAppointment>(
  (ref) => GetAppointment(repository: ref.watch(appointmentRepositoryProvider)),
);
final getAppointmentByDpIDProvider = Provider<GetAppointmentByDpid>(
  (ref) => GetAppointmentByDpid(
    repository: ref.watch(appointmentRepositoryProvider),
  ),
);
final addAppointmentProvider = Provider<AddAppointment>(
  (ref) => AddAppointment(repository: ref.watch(appointmentRepositoryProvider)),
);
final appointmentProvider =
    AsyncNotifierProvider<AppointmentProvider, List<Appointment>>(
      AppointmentProvider.new,
    );
final teehtProvider = NotifierProvider<TeethAddProvider, List<Map>>(
  TeethAddProvider.new,
);
final payPaidProvider = NotifierProvider<PayPaidProvider, int>(
  PayPaidProvider.new,
);
final remainingProvider = NotifierProvider<RemainingProvider, int>(
  RemainingProvider.new,
);
final appointmentDateProvider =
    NotifierProvider<AppointmentDateProvider, DateTime>(
      AppointmentDateProvider.new,
    );
