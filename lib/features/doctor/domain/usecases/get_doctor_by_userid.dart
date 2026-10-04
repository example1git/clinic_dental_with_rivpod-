import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';
import 'package:mysen/features/doctor/domain/repositories/repository.dart';

class GetDoctorByUserid {
  final DoctorRepository repository;

  GetDoctorByUserid({required this.repository});
  Future<Either<Failure, Doctor>> call() {
    return repository.getDoctorByUserID();
  }
}
