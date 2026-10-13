import 'package:mysen/core/utiles.dart';

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
  RequestReservation copyWith({
    String? id,
    String? doctorID,
    String? patientID,
    String? patientName,

    StateRequest? stateRequest,
    String? phone,
    DateTime? sendTime,
    DateTime? reciveTime,
  }) {
    return RequestReservation(
      id: id ?? this.id,
      doctorID: doctorID ?? this.doctorID,
      patientID: patientID ?? this.patientID,
      patientName: patientName ?? this.patientName,
      stateRequest: stateRequest ?? this.stateRequest,
      phone: phone ?? this.phone,

      sendTime: sendTime ?? this.sendTime,
      reciveTime: reciveTime ?? this.reciveTime,
    );
  }
}
