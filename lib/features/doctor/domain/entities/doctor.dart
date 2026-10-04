import 'package:mysen/core/utiles.dart';

class Doctor {
  final String id;
  final String? userID;
  final String fullName;
  final Map<String, dynamic> phone;
  final String location;
  Gender? gender;
  final bool isWorking;
  final List<String>? equlatifications;
  final String? imgUrl;
  final DateTime? createdAt;

  Doctor({
    required this.id,
    this.userID,
    required this.fullName,
    required this.location,
    required this.phone,
    this.gender,
    this.isWorking = true,
    this.equlatifications,
    this.imgUrl,
    this.createdAt,
  });
}
