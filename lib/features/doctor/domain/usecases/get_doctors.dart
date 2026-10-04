import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';
import 'package:mysen/features/doctor/domain/repositories/repository.dart';

class GetDoctors {
  final DoctorRepository repository;
  GetDoctors({required this.repository});
  Future<Either<Failure, List<Doctor>>> call() {
    return repository.getDoctors();
  }
}
