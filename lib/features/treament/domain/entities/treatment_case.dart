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
  TreatmentCase copyWith({
    String? id,
    String? doctorPatientID,
    int? totalPrice,
    TreatmentSatus? treatmentSatus,
    DateTime? createdTime,
  }) {
    return TreatmentCase(
      id: id ?? this.id,
      doctorPatientID: doctorPatientID ?? this.doctorPatientID,
      totalPrice: totalPrice ?? this.totalPrice,
      treatmentSatus: treatmentSatus ?? this.treatmentSatus,
      createdTime: createdTime ?? this.createdTime,
    );
  }
}
