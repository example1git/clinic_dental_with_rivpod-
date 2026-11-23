import 'package:flutter/material.dart';
import 'package:mysen/core/utiles.dart';

class ErrorHndel {
  static void handleError(ErrorType type, BuildContext context) {
    switch (type) {
      case ErrorType.internet:
        Utils.showSnackBar(message: context.tr.internetM, context: context);

        break;
      case ErrorType.timeout:
        Utils.showSnackBar(message: context.tr.timeoutT, context: context);

        break;
      case ErrorType.error:
        Utils.showSnackBar(message: context.tr.errorM, context: context);

        break;
      case ErrorType.authlogin:
        Utils.showSnackBar(
          message: context.tr.phoneNumberNotFound,
          context: context,
        );

        break;
      case ErrorType.authsign:
        Utils.showSnackBar(message: context.tr.errorSignM, context: context);

        break;
      case ErrorType.code:
        Utils.showSnackBar(context: context, message: context.tr.codeError);

        break;

      case ErrorType.rls:
        Utils.showSnackBar(
          message: context.tr.accountSuspendedM,
          context: context,
        );

        break;
    }
  }
}

enum ErrorType { internet, authlogin, authsign, timeout, error, code, rls }

class MessageHandle {
  static void handleMessage(MessageType type, BuildContext context) {
    switch (type) {
      case MessageType.requestWaiting:
        Utils.showSnackBar(context: context, message: context.tr.stRequestw);

        break;
      case MessageType.requestComplete:
        Utils.showSnackBar(
          context: context,
          message: context.tr.smRequestCount,
        );

        break;
      case MessageType.refreshDoctorPatient:
        // Utils.showSnackBar(context: context, message: context.tr.refreshM);

        break;

      case MessageType.refresh:
        Utils.showSnackBar(context: context, message: context.tr.refreshT);

        break;
      case MessageType.patientExist:
        Utils.showSnackBar(context: context, message: context.tr.patientExistM);

        break;
      case MessageType.isdoctorWork:
        // Utils.showSnackBar(context: context, message: context.tr.isWorkM);

        break;
      case MessageType.phoneDoctorEdit:
        Utils.showSnackBar(context: context, message: context.tr.phoneChangeM);

        break;
      case MessageType.delete:
        Utils.showSnackBar(context: context, message: context.tr.deleteM);

        break;
      case MessageType.add:
        Utils.showSnackBar(context: context, message: context.tr.addM);

        break;
    }
  }
}

enum MessageType {
  requestComplete,
  refresh,
  requestWaiting,
  refreshDoctorPatient,
  patientExist,
  isdoctorWork,
  phoneDoctorEdit,
  delete,
  add,
}
