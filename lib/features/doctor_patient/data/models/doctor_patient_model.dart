import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';

class DoctorPatientModel extends DoctorPateint {
  DoctorPatientModel({
    required super.doctorID,
    required super.patientID,
    required super.id,
    required super.doctorFullName,
    required super.patientFullName,
    required super.patientphone,
    super.isDeleteDoctor = false,
    super.isDeletePatient = false,
    super.createdAt,
  });

  @override
  DoctorPatientModel copyWith({
    String? id,
    String? doctorID,
    String? patientID,
    String? doctorFullName,
    String? patientFullName,
    String? patientphone,
    bool? isDeleteDoctor,
    bool? isDeletePatient,
    DateTime? createdAt,
  }) {
    return DoctorPatientModel(
      id: id ?? this.id,
      doctorID: doctorID ?? this.doctorID,
      patientID: patientID ?? this.patientID,
      doctorFullName: doctorFullName ?? this.doctorFullName,
      patientFullName: patientFullName ?? this.patientFullName,
      patientphone: patientphone ?? this.patientphone,
      isDeleteDoctor: isDeleteDoctor ?? this.isDeleteDoctor,
      isDeletePatient: isDeletePatient ?? this.isDeletePatient,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'doctorID': doctorID,
      'patientID': patientID,
      'isDeleteDoctor': isDeleteDoctor,
      'isDeletePatient': isDeletePatient,
    };
  }

  Map<String, dynamic> toMapSql() {
    return <String, dynamic>{
      'id': id,
      'doctorID': doctorID,
      'patientID': patientID,
      'doctorFullName': doctorFullName,
      'patientFullName': patientFullName,
      'patientphone': patientphone,
      'isDeleteDoctor': isDeleteDoctor ? 1 : 0,
      'isDeletePatient': isDeletePatient ? 1 : 0,
    };
  }

  factory DoctorPatientModel.fromMap(Map<String, dynamic> map) {
    return DoctorPatientModel(
      id: map['id'] as String,
      doctorID: map['doctorID'] as String,
      patientID: map['patientID'] as String,
      doctorFullName: map['doctor']['fullName'] as String,
      patientFullName: map['patient']['fullName'] as String,
      patientphone: map['patient']['phone'] as String,
      isDeleteDoctor: map['isDeleteDoctor'] as bool? ?? false,
      isDeletePatient: map['isDeletePatient'] as bool? ?? false,
      // createdAt: map['createdAt'] != null
      //     ? DateTime.parse(map['createdAt'])
      //     : null,
    );
  }
  factory DoctorPatientModel.fromMapSql(Map<String, dynamic> map) {
    return DoctorPatientModel(
      id: map['id'] as String,
      doctorID: map['doctorID'] as String,
      patientID: map['patientID'] as String,
      doctorFullName: map['doctorFullName'] as String,
      patientFullName: map['patientFullName'] as String,
      patientphone: map['patientphone'] as String,
      isDeleteDoctor: map['isDeleteDoctor'] == 1,
      isDeletePatient: map['isDeletePatient'] == 1,

      // createdAt: map['createdAt'] != null
      //     ? DateTime.parse(map['createdAt'])
      //     : null,
    );
  }
}
