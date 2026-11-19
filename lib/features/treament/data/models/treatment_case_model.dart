import 'package:mysen/features/treament/domain/entities/treatment_case.dart';

class TreatmentCaseModel extends TreatmentCase {
  new({
    required super.id,
    required super.doctorPatientID,
    required super.totalPrice,
    required super.treatmentSatus,
    required super.createdTime,
  });

  @override
  TreatmentCaseModel copyWith({
    String? id,
    String? doctorPatientID,
    int? totalPrice,
    TreatmentSatus? treatmentSatus,
    DateTime? createdTime,
  }) {
    return TreatmentCaseModel(
      id: id ?? this.id,
      doctorPatientID: doctorPatientID ?? this.doctorPatientID,
      totalPrice: totalPrice ?? this.totalPrice,
      treatmentSatus: treatmentSatus ?? this.treatmentSatus,
      createdTime: createdTime ?? this.createdTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'doctorPatientID': doctorPatientID,
      'totalPrice': totalPrice,
      'treatmentStatus': treatmentSatus.name,
      'createdTime': createdTime.toUtc().toIso8601String(),
    };
  }

  Map<String, dynamic> toMapSql() {
    return <String, dynamic>{
      'id': id,
      'doctorPatientID': doctorPatientID,
      'totalPrice': totalPrice,
      'treatmentStatus': treatmentSatus.name,
      'createdTime': createdTime.toIso8601String(),
    };
  }

  factory TreatmentCaseModel.fromMap(Map<String, dynamic> map) {
    return TreatmentCaseModel(
      id: map['id'] as String,
      doctorPatientID: map['doctorPatientID'] as String,
      totalPrice: map['totalPrice'] as int,
      treatmentSatus: TreatmentSatus.values.firstWhere(
        (element) => element.name == map['treatmentStatus'],
      ),
      createdTime: DateTime.parse(map['createdTime']).toLocal(),

      // createdAt: map['createdAt'] != null
      //     ? DateTime.tryParse(map['createdAt'])
      //     : null,
    );
  }
  factory TreatmentCaseModel.fromMapSql(Map<String, dynamic> map) {
    return TreatmentCaseModel(
      id: map['id'] as String,
      doctorPatientID: map['doctorPatientID'] as String,
      totalPrice: map['totalPrice'] as int,
      treatmentSatus: TreatmentSatus.values.firstWhere(
        (element) => element.name == map['treatmentStatus'],
      ),
      createdTime: DateTime.parse(map['createdTime']),

      // createdAt: map['createdAt'] != null
      //     ? DateTime.tryParse(map['createdAt'])
      //     : null,
    );
  }
}
