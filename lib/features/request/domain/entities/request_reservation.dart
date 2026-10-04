enum StateRequest { completed, reject, waiting, accepted, none }

class RequestReservation {
  final String id;
  final String doctorID;
  final String patientID;
  final String patientName;
  final StateRequest stateRequest;
  final String phone;
  final DateTime? sendTime;
  final DateTime? reciveTime;

  RequestReservation({
    required this.id,
    required this.doctorID,
    required this.patientID,
    required this.patientName,
    required this.stateRequest,
    required this.phone,
    this.sendTime,
    this.reciveTime,
  });
}
