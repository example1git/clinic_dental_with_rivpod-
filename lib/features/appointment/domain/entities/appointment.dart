class Appointment {
  final String id;
  final String treatmentCaseID;
  final String doctorPatientID;
  final DateTime timeAppointment;
  final int payPrice;
  final List<Map>? teethSelected;
  final DateTime? createdAt;

  Appointment({
    required this.id,
    required this.treatmentCaseID,
    required this.doctorPatientID,
    required this.timeAppointment,
    required this.payPrice,
    this.teethSelected,
    this.createdAt,
  });
}
