import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/patient/data/datasources/patient_local_data_source.dart';
import 'package:mysen/features/patient/data/datasources/patient_remote_data_sorce.dart';
import 'package:mysen/features/patient/data/repositories/patient_repository.dart';
import 'package:mysen/features/patient/domain/entities/patient.dart';
import 'package:mysen/features/patient/domain/repositories/patient_repository.dart';
import 'package:mysen/features/patient/domain/usecases/add_patient.dart';
import 'package:mysen/features/patient/domain/usecases/get_patient_by_phone.dart';
import 'package:mysen/features/patient/domain/usecases/get_patient_by_userid.dart';
import 'package:mysen/features/patient/presentation/controllers/patient_provider.dart';

final patientRepositoryProvider = Provider<PatientRepository>(
  (ref) => PatientRepositoryImp(
    internetService: ref.watch(internetServiceProvider),
    patientRemoteDataSorce: ref.watch(patientRemoteDataSourceProvider),
    patientLocalDataSource: ref.watch(patientLocalDataSourceProvider),
  ),
);
final patientRemoteDataSourceProvider = Provider<PatientRemoteDataSorce>(
  (ref) => PatientRemoteDataSorce(client: client),
);
final patientLocalDataSourceProvider = Provider<PatientLocalDataSource>(
  (ref) => PatientLocalDataSource(),
);

final internetServiceProvider = Provider<InternetService>(
  (ref) => InternetService(),
);
final getPatientByPhoneProvider = Provider<GetPatientByPhone>(
  (ref) => GetPatientByPhone(repository: ref.watch(patientRepositoryProvider)),
);
final getPatientByUserIDProvider = Provider<GetPatientByUserid>(
  (ref) => GetPatientByUserid(repository: ref.watch(patientRepositoryProvider)),
);
final addPatientProvider = Provider<AddPatient>(
  (ref) => AddPatient(repository: ref.watch(patientRepositoryProvider)),
);
final patientProvider = AsyncNotifierProvider<PatientProvider, Patient?>(
  PatientProvider.new,
);
