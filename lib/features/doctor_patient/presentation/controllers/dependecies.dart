import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/provider/providers.dart';
import 'package:mysen/features/doctor_patient/data/datasources/local_data_source.dart';
import 'package:mysen/features/doctor_patient/data/datasources/remote_data_source.dart';
import 'package:mysen/features/doctor_patient/data/repositories/doctor_patient_repositry.dart';
import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';
import 'package:mysen/features/doctor_patient/domain/repositories/doctor_patient_repository.dart';
import 'package:mysen/features/doctor_patient/domain/usecases/delete_doctor_patient.dart';
import 'package:mysen/features/doctor_patient/domain/usecases/get_doctor_patient.dart';
import 'package:mysen/features/doctor_patient/domain/usecases/update_dcotor_patient.dart';
import 'package:mysen/features/doctor_patient/domain/usecases/upsert_doctor_patient.dart';
import 'package:mysen/features/doctor_patient/presentation/controllers/doctor_patient_provider.dart';

final doctorPatientRepositoryProvider = Provider<DoctorPatientRepository>(
  (ref) => DoctorPatientRepositryImp(
    internetService: ref.watch(internetServiceProvider),
    doctorPatientRemoteDatasource: ref.watch(
      doctorPatientRemoteDataSourceProvider,
    ),
    doctorPatientLocalDataSourc: ref.watch(
      doctorPatientLocalDataSourceProvider,
    ),
  ),
);
final doctorPatientRemoteDataSourceProvider =
    Provider<DoctorPatientRemoteDatasource>(
      (ref) => DoctorPatientRemoteDatasource(client: client),
    );
final doctorPatientLocalDataSourceProvider =
    Provider<DoctorPatientLocalDataSourc>(
      (ref) => DoctorPatientLocalDataSourc(),
    );

final getDoctorPatientProvider = Provider<GetDoctorPatient>(
  (ref) =>
      GetDoctorPatient(repository: ref.watch(doctorPatientRepositoryProvider)),
);
final updateDoctorPatientProvider = Provider<UpdateDcotorPatient>(
  (ref) => UpdateDcotorPatient(
    repository: ref.watch(doctorPatientRepositoryProvider),
  ),
);
final upsertDoctorPatientProvider = Provider<UpsertDoctorPatient>(
  (ref) => UpsertDoctorPatient(
    repository: ref.watch(doctorPatientRepositoryProvider),
  ),
);
final deleteDoctorPatientProvider = Provider<DeleteDoctorPatient>(
  (ref) => DeleteDoctorPatient(
    repository: ref.watch(doctorPatientRepositoryProvider),
  ),
);
final doctorPatientProvider =
    AsyncNotifierProvider<DoctorPatientProvider, List<DoctorPateint>>(
      DoctorPatientProvider.new,
    );
