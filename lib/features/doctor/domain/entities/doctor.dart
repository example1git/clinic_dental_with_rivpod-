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
  Doctor copyWith({
    String? id,
    String? userID,
    String? fullName,
    Map<String, dynamic>? phone,
    String? location,
    Gender? gender,
    bool? isWorking,
    List<String>? equlatifications,
    String? imgUrl,
    DateTime? createdAt,
  }) {
    return Doctor(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      gender: gender ?? this.gender,
      isWorking: isWorking ?? this.isWorking,
      equlatifications: equlatifications ?? this.equlatifications,
      imgUrl: imgUrl ?? this.imgUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
