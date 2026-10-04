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
}
