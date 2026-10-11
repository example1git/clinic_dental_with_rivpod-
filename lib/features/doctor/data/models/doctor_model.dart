import 'dart:convert';

import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';

class DoctorModel extends Doctor {
  DoctorModel({
    required super.id,
    super.userID,
    required super.fullName,
    required super.phone,
    super.gender,
    required super.location,
    super.isWorking,
    super.imgUrl,
    super.createdAt,
    super.equlatifications,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "userID": userID,
      'fullName': fullName,
      'phone': phone,
      'equlatifications': equlatifications,
      'location': location,
      'imgUrl': imgUrl,
      'isWorking': isWorking,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'] as String,
      userID: map['userID'] as String?,
      fullName: map['fullName'] as String,
      phone: Map<String, dynamic>.from(map['phone'] as Map),
      gender: Gender.values.firstWhere(
        (element) => element.name == map['gender'],
      ),
      isWorking: map['isWorking'] as bool? ?? true,
      equlatifications: map['equlatifications'] != null
          ? List<String>.from(map['equlatifications'])
          : null,
      location: map['location'] as String,
      imgUrl: map['imgUrl'] as String?,
    );
  }

  Map<String, dynamic> toMapSql() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'phone': jsonEncode(phone),
      'equlatifications': jsonEncode(equlatifications),
      'location': location,
      'gender': gender?.name,
      'imgUrl': imgUrl,
      'isWorking': isWorking ? 1 : 0,
    };
  }

  factory DoctorModel.fromMapSql(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      phone: Map<String, dynamic>.from(jsonDecode(map['phone']) as Map),
      gender: Gender.values.firstWhere(
        (element) => element.name == map['gender'],
      ),
      isWorking: map['isWorking'] == 1,
      equlatifications: jsonDecode(map['equlatifications']) != null
          ? List<String>.from(jsonDecode(map['equlatifications']))
          : null,
      location: map['location'] as String,
      imgUrl: map['imgUrl'] as String?,
    );
  }

  DoctorModel copyWith({
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
    return DoctorModel(
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
