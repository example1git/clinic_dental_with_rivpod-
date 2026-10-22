import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/provider/providers.dart';
import 'package:mysen/features/doctor/data/datasources/local_data_sourc.dart';
import 'package:mysen/features/doctor/data/datasources/remot_data_source.dart';
import 'package:mysen/features/doctor/data/repositories/doctor_repository.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';
import 'package:mysen/features/doctor/domain/repositories/repository.dart';
import 'package:mysen/features/doctor/domain/usecases/get_doctor_by_userid.dart';
import 'package:mysen/features/doctor/domain/usecases/get_doctors.dart';
import 'package:mysen/features/doctor/domain/usecases/update_doctor.dart';
import 'package:mysen/features/doctor/domain/usecases/upload_image.dart';
import 'package:mysen/features/doctor/presentation/controllers/doctor_provider.dart';
import 'package:mysen/features/doctor/presentation/controllers/doctors_provider.dart';

final doctorRepositoryProvider = Provider<DoctorRepository>(
  (ref) => DoctorRepositoryImp(
    internetService: ref.watch(internetServiceProvider),
    doctorRemotDataSource: ref.watch(doctorRemoteDataSourceProvider),
    doctorLocalDataSource: ref.watch(doctorLocalDataSourceProvider),
  ),
);
final doctorRemoteDataSourceProvider = Provider<DoctorRemotDataSource>(
  (ref) => DoctorRemotDataSource(client: client),
);
final doctorLocalDataSourceProvider = Provider<DoctorLocalDataSourc>(
  (ref) => DoctorLocalDataSourc(),
);

final getDoctorByUseridProvider = Provider<GetDoctorByUserid>(
  (ref) => GetDoctorByUserid(repository: ref.watch(doctorRepositoryProvider)),
);
final getDoctorsProvider = Provider<GetDoctors>(
  (ref) => GetDoctors(repository: ref.watch(doctorRepositoryProvider)),
);
final updateDoctorProvider = Provider<UpdateDoctor>(
  (ref) => UpdateDoctor(repository: ref.watch(doctorRepositoryProvider)),
);
final uploadImageProvider = Provider<UploadImage>(
  (ref) => UploadImage(repository: ref.watch(doctorRepositoryProvider)),
);
final doctorProvider = AsyncNotifierProvider<DoctorProvider, Doctor?>(
  DoctorProvider.new,
);
final doctorsProvider = AsyncNotifierProvider<DoctorsProvider, List<Doctor>>(
  DoctorsProvider.new,
);
final equlatificationsProvider =
    NotifierProvider<EqulatificationsProvider, List<String>>(
      EqulatificationsProvider.new,
    );
final isSearch = StateProvider<bool>((ref) => false);
