import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';
import 'package:mysen/features/doctor/domain/repositories/repository.dart';

class UploadImage {
  final DoctorRepository repository;
  UploadImage({required this.repository});
  Future<Either<Failure, String>> call(File file, Doctor doctor) {
    return repository.uploadImage(file, doctor);
  }
}
