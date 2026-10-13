import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/request/domain/entities/request_reservation.dart';

class RequestReservationModel extends RequestReservation {
  new({
    required super.id,
    required super.doctorID,
    required super.patientID,
    required super.patientName,
    required super.stateRequest,
    required super.phone,
    super.reciveTime,
    super.sendTime,
  });

  @override
  RequestReservationModel copyWith({
    String? id,
    String? doctorID,
    String? patientID,
    String? patientName,

    StateRequest? stateRequest,
    String? phone,
    DateTime? sendTime,
    DateTime? reciveTime,
  }) {
    return RequestReservationModel(
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'doctorID': doctorID,
      'patientID': patientID,
      'stateRequest': stateRequest.name,
      'sendTime': sendTime?.toUtc().toIso8601String(),
      'reciveTime': reciveTime?.toUtc().toIso8601String(),
    };
  }

  factory RequestReservationModel.fromMap(Map<String, dynamic> map) {
    return RequestReservationModel(
      id: map['id'] as String,
      doctorID: map['doctorID'] as String,
      patientID: map['patientID'] as String,
      patientName: map['patient']['fullName'] as String,
      stateRequest: StateRequest.values.firstWhere(
        (element) => element.name == map['stateRequest'],
      ),
      phone: map['patient']['phone'] as String,

      sendTime: map['sendTime'] != null
          ? DateTime.parse(map['sendTime']).toLocal()
          : null,
      reciveTime: map['reciveTime'] != null
          ? DateTime.parse(map['reciveTime']).toLocal()
          : null,
    );
  }
  factory RequestReservationModel.fromMapPyload({
    required Map<String, dynamic> map,
    required String patientName,
    required String phone,
  }) {
    return RequestReservationModel(
      id: map['id'] as String,
      doctorID: map['doctorID'] as String,
      patientID: map['patientID'] as String,
      patientName: patientName,
      stateRequest: StateRequest.values.firstWhere(
        (element) => element.name == map['stateRequest'],
      ),
      phone: phone,

      sendTime: map['sendTime'] != null
          ? DateTime.parse(map['sendTime']).toLocal()
          : null,
      reciveTime: map['reciveTime'] != null
          ? DateTime.parse(map['reciveTime']).toLocal()
          : null,
    );
  }
  factory RequestReservationModel.fromMapsql(Map<String, dynamic> map) {
    return RequestReservationModel(
      id: map['id'] as String,
      doctorID: map['doctorID'] as String,
      patientID: map['patientID'] as String,
      patientName: map['fullName'] as String,
      stateRequest: StateRequest.values.firstWhere(
        (element) => element.name == map['stateRequest'],
      ),
      phone: map['phone'] as String,

      sendTime: map['sendTime'] != null
          ? DateTime.parse(map['sendTime'])
          : null,
      reciveTime: map['reciveTime'] != null
          ? DateTime.parse(map['reciveTime'])
          : null,
    );
  }

  Map<String, dynamic> toMapsql() {
    return <String, dynamic>{
      'id': id,
      'doctorID': doctorID,
      'patientID': patientID,
      'fullName': patientName,
      'stateRequest': stateRequest.name,
      'phone': phone,
      'sendTime': sendTime?.toIso8601String(),
      'reciveTime': reciveTime?.toIso8601String(),
    };
  }
}
