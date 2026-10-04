import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';
import 'package:mysen/features/doctor/domain/repositories/repository.dart';

class UpdateDoctor {
  final DoctorRepository repository;
  UpdateDoctor({required this.repository});
  Future<Either<Failure, Doctor>> call(Doctor doctor) {
    return repository.updateDoctor(doctor);
  }
}
