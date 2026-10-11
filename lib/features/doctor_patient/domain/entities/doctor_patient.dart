class DoctorPateint {
  final String id;
  final String doctorID;
  final String patientID;
  final String doctorFullName;
  final String patientFullName;
  final String patientphone;
  final bool isDeleteDoctor;
  final bool isDeletePatient;
  final DateTime? createdAt;

  DoctorPateint({
    required this.id,
    required this.doctorID,
    required this.patientID,
    this.isDeleteDoctor = false,
    this.isDeletePatient = false,
    this.createdAt,
    required this.doctorFullName,
    required this.patientFullName,
    required this.patientphone,
  });

  DoctorPateint copyWith({
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
    return DoctorPateint(
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
}
