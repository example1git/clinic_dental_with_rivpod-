import 'dart:convert';

import 'package:mysen/features/appointment/domain/entities/appointment.dart';

class AppointmentModel extends Appointment {
  new({
    required super.id,
    required super.treatmentCaseID,
    required super.doctorPatientID,
    required super.timeAppointment,
    super.teethSelected,
    required super.payPrice,
  });

  AppointmentModel copyWith({
    String? id,
    String? treatmentCaseID,
    String? doctorPatientID,
    DateTime? timeAppointment,
    int? payPrice,
    List<Map>? teethSelected,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      treatmentCaseID: treatmentCaseID ?? this.treatmentCaseID,
      doctorPatientID: doctorPatientID ?? this.doctorPatientID,
      timeAppointment: timeAppointment ?? this.timeAppointment,
      payPrice: payPrice ?? this.payPrice,
      teethSelected: teethSelected ?? this.teethSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'treatmentCaseID': treatmentCaseID,
      'doctorPatientID': doctorPatientID,
      'timeAppointment': timeAppointment.toUtc().toIso8601String(),
      'payPrice': payPrice,
      'teethSelected': teethSelected,
    };
  }

  Map<String, dynamic> toMapSql() {
    return <String, dynamic>{
      'id': id,
      'treatmentCaseID': treatmentCaseID,
      'doctorPatientID': doctorPatientID,
      'timeAppointment': timeAppointment.toIso8601String(),
      'payPrice': payPrice,
      'teethSelected': jsonEncode(teethSelected),
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'] as String,
      treatmentCaseID: map['treatmentCaseID'] as String,
      doctorPatientID: map['doctorPatientID'] as String,

      timeAppointment: DateTime.parse(map['timeAppointment']).toLocal(),
      teethSelected: map['teethSelected'] != null
          ? List<Map<String, dynamic>>.from(map['teethSelected'] as List)
          : null,
      payPrice: map['payPrice'] as int,
      // createdAt: map['createdAt'] != null
      //     ? DateTime.tryParse(map['createdAt'])
      //     : null,
    );
  }
  factory AppointmentModel.fromMapSql(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'] as String,
      treatmentCaseID: map['treatmentCaseID'] as String,
      doctorPatientID: map['doctorPatientID'] as String,
      timeAppointment: DateTime.parse(map['timeAppointment']),
      teethSelected: map['teethSelected'] != null
          ? List<Map<String, dynamic>>.from(
              (jsonDecode(map['teethSelected']) as List),
            )
          : null,
      payPrice: map['payPrice'] as int,
      // createdAt: map['createdAt'] != null
      //     ? DateTime.tryParse(map['createdAt'])
      //     : null,
    );
  }
}
