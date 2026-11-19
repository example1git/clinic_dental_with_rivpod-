// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get titleRequest => 'Do you really want to request a booking?';

  @override
  String get titleRequestCancel =>
      'Do you really want to cancel the booking request?';

  @override
  String get stRequestCount => 'You already have an accepted request';

  @override
  String get smRequestCount =>
      'You cannot request a new appointment until your current appointment has ended.';

  @override
  String get stRequestw => 'You have a pending booking';

  @override
  String get smRequestw =>
      'You can request another booking after the current request is rejected or cancelled.';

  @override
  String get requestTitle => 'Booking Request';

  @override
  String get cancelRequest => 'Cancel';

  @override
  String get holiday => 'On Leave';

  @override
  String get accountSuspendedT => 'Account Suspended';

  @override
  String get accountSuspendedM =>
      'Your account has been suspended by the app administration. Please contact the app administration for more information.';

  @override
  String get doctorMale => 'Dr.';

  @override
  String get doctorFemale => 'Dr.';

  @override
  String get sThemeSelectT => 'Notice';

  @override
  String get sThemeSelectM => 'Please choose a theme to save changes.';

  @override
  String get sThemeT => 'Theme Applied';

  @override
  String get sThemeM => 'Please restart the application to apply the changes.';

  @override
  String get setTheme => 'Set Theme';

  @override
  String get theme => 'Theme';

  @override
  String get language => 'Language';

  @override
  String get chooseLanguage => 'Choose Language';

  @override
  String get arabic => 'Arabic';

  @override
  String get english => 'English';

  @override
  String get deleteT => '✔';

  @override
  String get deleteM => 'Deleted Successfully';

  @override
  String get addT => '✔';

  @override
  String get addM => 'Added Successfully';

  @override
  String get totalPrice => 'Total Amount';

  @override
  String get currentPaid => 'Current Paid Amount';

  @override
  String get paidAmount => 'Paid Amount';

  @override
  String get sar => 'SAR';

  @override
  String get treatmentCase => 'Treatment Plan';

  @override
  String get addTreatmentPlan => 'Add Treatment Plan';

  @override
  String get deletedTreatmentPlans => 'Deleted Treatment Plans';

  @override
  String get timeCreate => 'Creation Time';

  @override
  String get previouslyPaid => 'Previously Paid Amount';

  @override
  String get remainingPrice => 'Remaining Amount';

  @override
  String get signOut => 'Sign Out';

  @override
  String get done => 'OK';

  @override
  String get reservesList => 'Reservations List';

  @override
  String get deleteConfirmation => 'Are you sure you want to delete?';

  @override
  String get cancel => 'Back';

  @override
  String get ok => 'Yes';

  @override
  String get doctorAbbreviation => 'D';

  @override
  String get refreshT => 'Updated';

  @override
  String get refreshM => 'Data has been updated. Please try again later.';

  @override
  String get internetT => 'No Internet Connection';

  @override
  String get internetM =>
      'Please check your internet connection and try again.';

  @override
  String get errorT => 'Error';

  @override
  String get errorM => 'Something went wrong. Please try again.';

  @override
  String get errorSignM =>
      'This account already exists. You can use another account or log in.';

  @override
  String get fieldIsEmpty => 'Field is empty';

  @override
  String get failedNames => 'Please enter the full name correctly.';

  @override
  String get failedNicknames => 'Please enter a valid nickname.';

  @override
  String get passwordTooShort => 'Password is too short.';

  @override
  String get invalidPhoneNumber => 'Invalid phone number.';

  @override
  String get phoneNumberNotFound => 'Phone number is not found.';

  @override
  String get addName => 'Add Name';

  @override
  String get timeoutT => 'Connection Timeout';

  @override
  String get timeoutM =>
      'Your internet connection is unstable. Please try again.';

  @override
  String get roleChoice => 'Select your role in the application.';

  @override
  String get code => 'Code';

  @override
  String get codeError => 'Invalid code';

  @override
  String get loadError => 'An error occurred while loading  data';

  @override
  String get retry => 'Retry';

  @override
  String get right => 'Right';

  @override
  String get left => 'Left';

  @override
  String get searchShow => 'Show Search Bar';

  @override
  String get searchHide => 'Hide Search Bar';

  @override
  String get searchFieldTitle => '...search record';

  @override
  String get rowLevelT => 'Error';

  @override
  String get rowLevelM => 'Your account has been suspended by the developer.';

  @override
  String get isWorkT => 'Updated';

  @override
  String get isWorkM => 'You can change your status again after 2 minutes.';

  @override
  String get doctorProfile => 'Doctor Profile';

  @override
  String get createPatients => 'Create Patient Record';

  @override
  String get addLocation => 'Edit Location';

  @override
  String get location => 'Location';

  @override
  String get phoneChangeT => 'Change Phone Number';

  @override
  String get phoneChangeM =>
      'To change the phone number registered to your account, please contact the app administrator.';

  @override
  String get equalzation => 'Enter Qualifications';

  @override
  String get editQualifications => 'Edit Qualifications';

  @override
  String get signUp => 'Signup';

  @override
  String get signIn => 'Login';

  @override
  String get verify => 'Verify your phone number';

  @override
  String get messageResend => 'Didn\'t receive the code?';

  @override
  String get resend => 'Resend';

  @override
  String get name => 'Full Name';

  @override
  String get nickName => 'Nickname';

  @override
  String get phone => 'Phone Number';

  @override
  String get whatsApp => 'WhatsApp Number';

  @override
  String get editPhone => 'Edit Numbers';

  @override
  String get add => 'Add';

  @override
  String get addAppointment => 'Add Appointment';

  @override
  String get appointmentTime => 'Appointment Time';

  @override
  String get appointmentDay => 'Today\'s Appointments';

  @override
  String get changeToHolidayM =>
      'Are you sure you want to change your status to On Leave?';

  @override
  String get changeToWorkM =>
      'Are you sure you want to change your status to Available for Work?';

  @override
  String get holidayStatus => 'On Leave';

  @override
  String get workStatus => 'Available for Work';

  @override
  String get date => 'Date';

  @override
  String get addTeeth => 'Add Teeth';

  @override
  String get addDescription => 'Add Tooth Description';

  @override
  String get description => 'Tooth Description';

  @override
  String get empty => 'Empty';

  @override
  String get noAppointment => 'No Appointment';

  @override
  String get restoreTreatmentPlanM =>
      'Are you sure you want to restore this treatment plan?';

  @override
  String get notificationReservation => 'Booking Requests';

  @override
  String get titleReject => 'Are you sure you want to reject?';

  @override
  String get accept => 'Accept';

  @override
  String get reject => 'Reject';

  @override
  String get allReservations => 'All Reservations';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get specificDate => 'Specific Date';

  @override
  String get addImage => 'Add Image';

  @override
  String get newItem => 'New';

  @override
  String get patientExistT => 'Notice';

  @override
  String get patientExistM => 'Patient record already exists.';

  @override
  String get noWhatsApp => 'No WhatsApp Number';

  @override
  String get noPhone => 'No Phone Number';
}
