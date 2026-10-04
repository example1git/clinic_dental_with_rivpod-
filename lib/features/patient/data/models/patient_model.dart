import 'package:mysen/features/patient/domain/entities/patient.dart';

class PatientModel extends Patient {
  new({
    required super.id,
    required super.fullName,
    required super.phone,
    super.userID,
  });

  PatientModel copyWith({
    String? id,
    String? userID,
    String? fullName,
    String? phone,
    String? accessCode,
    DateTime? crearedAt,
  }) {
    return PatientModel(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'fullName': fullName,
      'phone': phone,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      userID: map['userID'] as String?,
      phone: map['phone'] as String,

      // createdAt: map['createdAt'] != null
      //     ? DateTime.parse(map['createdAt'])
      //     : null,
    );
  }

  Map<String, dynamic> toMapsql() {
    return <String, dynamic>{'id': id, 'fullName': fullName, 'phone': phone};
  }

  factory PatientModel.fromMapsql(Map<String, dynamic> map) {
    return PatientModel(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      phone: map['phone'] as String,
    );
  }
}
