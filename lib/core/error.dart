import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mysen/core/utiles.dart';

class ErrorHndel {
  static void handleError(ErrorType type) {
    switch (type) {
      case ErrorType.internet:
        Utils.showSnacBar(title: 'internetT'.tr, message: 'internetM'.tr);

        break;
      case ErrorType.timeout:
        Utils.showSnacBar(title: 'timeoutT'.tr, message: 'timeoutM'.tr);

        break;
      case ErrorType.error:
        Utils.showSnacBar(title: 'errorT'.tr, message: 'errorM'.tr);

        break;
      case ErrorType.authlogin:
        Utils.showSnacBar(
          title: 'errorT'.tr,
          message: 'number is not found'.tr,
        );

        break;
      case ErrorType.authsign:
        Utils.showSnacBar(title: 'errorT'.tr, message: 'errorSignM'.tr);

        break;
      case ErrorType.code:
        Utils.showSnacBar(title: 'errorT'.tr, message: 'codeError'.tr);

        break;

      case ErrorType.rls:
        Utils.showSnacBar(
          title: 'accountSuspendedT'.tr,
          message: 'accountSuspendedM'.tr,
        );

        break;
    }
  }
}

enum ErrorType { internet, authlogin, authsign, timeout, error, code, rls }

class MessageHandle {
  static void handleMessage(MessageType type) {
    switch (type) {
      case MessageType.requestWaiting:
        Utils.showSnacBar(title: 'stRequestw'.tr, message: 'smRequestw'.tr);

        break;
      case MessageType.requestComplete:
        Utils.showSnacBar(
          title: 'stRequestCount'.tr,
          message: 'smRequestCount'.tr,
        );

        break;
      case MessageType.refreshDoctorPatient:
        Utils.showSnacBar(title: 'refreshT'.tr, message: 'refreshM'.tr);

        break;

      case MessageType.applyTheme:
        Utils.showSnacBar(title: 'sThemeT'.tr, message: 'sThemeM'.tr);

        break;
      case MessageType.patientExist:
        Utils.showSnacBar(
          title: 'patientExistT'.tr,
          message: 'patientExistM'.tr,
        );

        break;
      case MessageType.isdoctorWork:
        Utils.showSnacBar(title: 'isworkT'.tr, message: 'isworkM'.tr);

        break;
      case MessageType.phoneDoctorEdit:
        Utils.showSnacBar(title: 'phoneChangeT'.tr, message: 'phoneChangeM'.tr);

        break;
      case MessageType.delete:
        Utils.showSnacBar(
          title: 'DeleteT'.tr,
          message: 'DeleteM'.tr,
          duration: const Duration(seconds: 1),
        );

        break;
      case MessageType.add:
        Utils.showSnacBar(
          title: 'AddT'.tr,
          message: 'AddM'.tr,
          duration: const Duration(seconds: 1),
        );

        break;
    }
  }
}

enum MessageType {
  requestComplete,
  requestWaiting,
  refreshDoctorPatient,
  applyTheme,
  patientExist,
  isdoctorWork,
  phoneDoctorEdit,
  delete,
  add,
}
