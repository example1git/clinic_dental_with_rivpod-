enum TreatmentSatus { active, canceled, deleted }

class TreatmentCase {
  final String id;
  final String doctorPatientID;
  final int totalPrice;
  final TreatmentSatus treatmentSatus;

  final DateTime createdTime;
  final DateTime? createdAt;

  TreatmentCase({
    required this.id,
    required this.doctorPatientID,
    required this.totalPrice,
    required this.treatmentSatus,
    required this.createdTime,
    this.createdAt,
  });
}
