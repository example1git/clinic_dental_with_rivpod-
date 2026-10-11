import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'translate/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @titleRequest.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من إرسال طلب الحجز؟'**
  String get titleRequest;

  /// No description provided for @titleRequestCancel.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من إلغاء طلب الحجز؟'**
  String get titleRequestCancel;

  /// No description provided for @stRequestCount.
  ///
  /// In ar, this message translates to:
  /// **'لديك طلب حجز مقبول'**
  String get stRequestCount;

  /// No description provided for @smRequestCount.
  ///
  /// In ar, this message translates to:
  /// **'لا يمكنك طلب حجز جديد إلا بعد انتهاء موعد حجزك الحالي.'**
  String get smRequestCount;

  /// No description provided for @stRequestw.
  ///
  /// In ar, this message translates to:
  /// **'لديك طلب حجز قيد الانتظار'**
  String get stRequestw;

  /// No description provided for @smRequestw.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك إرسال طلب جديد بعد login الطلب الحالي أو إلغائه.'**
  String get smRequestw;

  /// No description provided for @requestTitle.
  ///
  /// In ar, this message translates to:
  /// **'طلب حجز'**
  String get requestTitle;

  /// No description provided for @cancelRequest.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancelRequest;

  /// No description provided for @holiday.
  ///
  /// In ar, this message translates to:
  /// **'في إجازة'**
  String get holiday;

  /// No description provided for @accountSuspendedT.
  ///
  /// In ar, this message translates to:
  /// **'تم إيقاف الحساب'**
  String get accountSuspendedT;

  /// No description provided for @accountSuspendedM.
  ///
  /// In ar, this message translates to:
  /// **'تم إيقاف حسابك من قبل إدارة التطبيق. يرجى التواصل مع إدارة التطبيق لمزيد من المعلومات.'**
  String get accountSuspendedM;

  /// No description provided for @doctorMale.
  ///
  /// In ar, this message translates to:
  /// **'الدكتور'**
  String get doctorMale;

  /// No description provided for @doctorFemale.
  ///
  /// In ar, this message translates to:
  /// **'الدكتورة'**
  String get doctorFemale;

  /// No description provided for @sThemeSelectT.
  ///
  /// In ar, this message translates to:
  /// **'تنبيه'**
  String get sThemeSelectT;

  /// No description provided for @sThemeSelectM.
  ///
  /// In ar, this message translates to:
  /// **'يرجى اختيار سمة لحفظ التغييرات.'**
  String get sThemeSelectM;

  /// No description provided for @sThemeT.
  ///
  /// In ar, this message translates to:
  /// **'تم تطبيق السمة'**
  String get sThemeT;

  /// No description provided for @sThemeM.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إعادة تشغيل التطبيق لتطبيق التغييرات.'**
  String get sThemeM;

  /// No description provided for @setTheme.
  ///
  /// In ar, this message translates to:
  /// **'تغيير السمة'**
  String get setTheme;

  /// No description provided for @theme.
  ///
  /// In ar, this message translates to:
  /// **'السمة'**
  String get theme;

  /// No description provided for @language.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get language;

  /// No description provided for @chooseLanguage.
  ///
  /// In ar, this message translates to:
  /// **'اختر اللغة'**
  String get chooseLanguage;

  /// No description provided for @arabic.
  ///
  /// In ar, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In ar, this message translates to:
  /// **'الإنجليزية'**
  String get english;

  /// No description provided for @deleteT.
  ///
  /// In ar, this message translates to:
  /// **'✔'**
  String get deleteT;

  /// No description provided for @deleteM.
  ///
  /// In ar, this message translates to:
  /// **'تم الحذف بنجاح'**
  String get deleteM;

  /// No description provided for @addT.
  ///
  /// In ar, this message translates to:
  /// **'✔'**
  String get addT;

  /// No description provided for @addM.
  ///
  /// In ar, this message translates to:
  /// **'تمت الإضافة بنجاح'**
  String get addM;

  /// No description provided for @totalPrice.
  ///
  /// In ar, this message translates to:
  /// **'المبلغ الإجمالي'**
  String get totalPrice;

  /// No description provided for @currentPaid.
  ///
  /// In ar, this message translates to:
  /// **'المبلغ المدفوع حاليًا'**
  String get currentPaid;

  /// No description provided for @paidAmount.
  ///
  /// In ar, this message translates to:
  /// **'المبلغ المدفوع'**
  String get paidAmount;

  /// No description provided for @treatmentCase.
  ///
  /// In ar, this message translates to:
  /// **'الخطة العلاجية'**
  String get treatmentCase;

  /// No description provided for @addTreatmentPlan.
  ///
  /// In ar, this message translates to:
  /// **'إضافة خطة علاجية'**
  String get addTreatmentPlan;

  /// No description provided for @deletedTreatmentPlans.
  ///
  /// In ar, this message translates to:
  /// **'الخطط العلاجية المحذوفة'**
  String get deletedTreatmentPlans;

  /// No description provided for @timeCreate.
  ///
  /// In ar, this message translates to:
  /// **'وقت الإنشاء'**
  String get timeCreate;

  /// No description provided for @previouslyPaid.
  ///
  /// In ar, this message translates to:
  /// **'المبلغ المدفوع سابقًا'**
  String get previouslyPaid;

  /// No description provided for @remainingPrice.
  ///
  /// In ar, this message translates to:
  /// **'المبلغ المتبقي'**
  String get remainingPrice;

  /// No description provided for @signOut.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get signOut;

  /// No description provided for @done.
  ///
  /// In ar, this message translates to:
  /// **'موافق'**
  String get done;

  /// No description provided for @reservesList.
  ///
  /// In ar, this message translates to:
  /// **'قائمة الحجوزات'**
  String get reservesList;

  /// No description provided for @deleteConfirmation.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من الحذف؟'**
  String get deleteConfirmation;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'رجوع'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In ar, this message translates to:
  /// **'نعم'**
  String get ok;

  /// No description provided for @doctorAbbreviation.
  ///
  /// In ar, this message translates to:
  /// **'د.'**
  String get doctorAbbreviation;

  /// No description provided for @refreshT.
  ///
  /// In ar, this message translates to:
  /// **'تم التحديث'**
  String get refreshT;

  /// No description provided for @refreshM.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث البيانات، يمكنك المحاولة مرة أخرى لاحقًا.'**
  String get refreshM;

  /// No description provided for @internetT.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد اتصال بالإنترنت'**
  String get internetT;

  /// No description provided for @internetM.
  ///
  /// In ar, this message translates to:
  /// **'يرجى التحقق من اتصال الإنترنت والمحاولة مرة أخرى.'**
  String get internetM;

  /// No description provided for @errorT.
  ///
  /// In ar, this message translates to:
  /// **'خطأ'**
  String get errorT;

  /// No description provided for @errorM.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ، يرجى المحاولة مرة أخرى.'**
  String get errorM;

  /// No description provided for @errorSignM.
  ///
  /// In ar, this message translates to:
  /// **'الحساب موجود بالفعل. استخدم حسابًا آخر أو قم بتسجيل الدخول.'**
  String get errorSignM;

  /// No description provided for @fieldIsEmpty.
  ///
  /// In ar, this message translates to:
  /// **'الحقل فارغ'**
  String get fieldIsEmpty;

  /// No description provided for @failedNames.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال الاسم الثلاثي بشكل صحيح.'**
  String get failedNames;

  /// No description provided for @failedNicknames.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال اللقب بشكل صحيح.'**
  String get failedNicknames;

  /// No description provided for @passwordTooShort.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور قصيرة جدًا.'**
  String get passwordTooShort;

  /// No description provided for @invalidPhoneNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف غير صحيح.'**
  String get invalidPhoneNumber;

  /// No description provided for @phoneNumberNotFound.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف غير موجود.'**
  String get phoneNumberNotFound;

  /// No description provided for @addName.
  ///
  /// In ar, this message translates to:
  /// **'إضافة الاسم'**
  String get addName;

  /// No description provided for @timeoutT.
  ///
  /// In ar, this message translates to:
  /// **'انتهت مهلة الاتصال'**
  String get timeoutT;

  /// No description provided for @timeoutM.
  ///
  /// In ar, this message translates to:
  /// **'اتصال الإنترنت غير مستقر، يرجى المحاولة مرة أخرى.'**
  String get timeoutM;

  /// No description provided for @roleChoice.
  ///
  /// In ar, this message translates to:
  /// **'حدد دورك في التطبيق'**
  String get roleChoice;

  /// No description provided for @code.
  ///
  /// In ar, this message translates to:
  /// **'الرمز'**
  String get code;

  /// No description provided for @codeError.
  ///
  /// In ar, this message translates to:
  /// **'الرمز غير صحيح'**
  String get codeError;

  /// No description provided for @loadError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ أثناء تحميل البيانات '**
  String get loadError;

  /// No description provided for @retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retry;

  /// No description provided for @right.
  ///
  /// In ar, this message translates to:
  /// **'يمين'**
  String get right;

  /// No description provided for @left.
  ///
  /// In ar, this message translates to:
  /// **'يسار'**
  String get left;

  /// No description provided for @searchShow.
  ///
  /// In ar, this message translates to:
  /// **'إظهار شريط البحث'**
  String get searchShow;

  /// No description provided for @searchHide.
  ///
  /// In ar, this message translates to:
  /// **'إخفاء شريط البحث'**
  String get searchHide;

  /// No description provided for @searchFieldTitle.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن سجل...'**
  String get searchFieldTitle;

  /// No description provided for @rowLevelT.
  ///
  /// In ar, this message translates to:
  /// **'تنبيه'**
  String get rowLevelT;

  /// No description provided for @rowLevelM.
  ///
  /// In ar, this message translates to:
  /// **'تم إيقاف حسابك من قبل إدارة النظام.'**
  String get rowLevelM;

  /// No description provided for @isWorkT.
  ///
  /// In ar, this message translates to:
  /// **'تم التحديث'**
  String get isWorkT;

  /// No description provided for @isWorkM.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك تغيير الحالة مرة أخرى بعد دقيقتين.'**
  String get isWorkM;

  /// No description provided for @doctorProfile.
  ///
  /// In ar, this message translates to:
  /// **'الملف الشخصي'**
  String get doctorProfile;

  /// No description provided for @createPatients.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء سجل مريض'**
  String get createPatients;

  /// No description provided for @addLocation.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الموقع'**
  String get addLocation;

  /// No description provided for @location.
  ///
  /// In ar, this message translates to:
  /// **'الموقع'**
  String get location;

  /// No description provided for @phoneChangeT.
  ///
  /// In ar, this message translates to:
  /// **'تغيير رقم الجوال'**
  String get phoneChangeT;

  /// No description provided for @phoneChangeM.
  ///
  /// In ar, this message translates to:
  /// **'لتغيير رقم الجوال المسجل في حسابك، يرجى التواصل مع إدارة التطبيق.'**
  String get phoneChangeM;

  /// No description provided for @equalzation.
  ///
  /// In ar, this message translates to:
  /// **'أدخل المؤهلات'**
  String get equalzation;

  /// No description provided for @editQualifications.
  ///
  /// In ar, this message translates to:
  /// **'تعديل المؤهلات'**
  String get editQualifications;

  /// No description provided for @signUp.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب'**
  String get signUp;

  /// No description provided for @signIn.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get signIn;

  /// No description provided for @verify.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد رقم الهاتف'**
  String get verify;

  /// No description provided for @messageResend.
  ///
  /// In ar, this message translates to:
  /// **'لم تستلم الرمز؟'**
  String get messageResend;

  /// No description provided for @resend.
  ///
  /// In ar, this message translates to:
  /// **'إعادة إرسال'**
  String get resend;

  /// No description provided for @name.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الثلاثي'**
  String get name;

  /// No description provided for @nickName.
  ///
  /// In ar, this message translates to:
  /// **'اللقب'**
  String get nickName;

  /// No description provided for @phone.
  ///
  /// In ar, this message translates to:
  /// **'رقم الجوال'**
  String get phone;

  /// No description provided for @whatsApp.
  ///
  /// In ar, this message translates to:
  /// **'رقم واتساب'**
  String get whatsApp;

  /// No description provided for @editPhone.
  ///
  /// In ar, this message translates to:
  /// **'تعديل أرقام التواصل'**
  String get editPhone;

  /// No description provided for @add.
  ///
  /// In ar, this message translates to:
  /// **'إضافة'**
  String get add;

  /// No description provided for @addAppointment.
  ///
  /// In ar, this message translates to:
  /// **'إضافة موعد'**
  String get addAppointment;

  /// No description provided for @appointmentTime.
  ///
  /// In ar, this message translates to:
  /// **'موعد الحجز'**
  String get appointmentTime;

  /// No description provided for @appointmentDay.
  ///
  /// In ar, this message translates to:
  /// **'حجوزات اليوم'**
  String get appointmentDay;

  /// No description provided for @changeToHolidayM.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من تغيير حالتك إلى إجازة؟'**
  String get changeToHolidayM;

  /// No description provided for @changeToWorkM.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من تغيير حالتك إلى متاح للعمل؟'**
  String get changeToWorkM;

  /// No description provided for @holidayStatus.
  ///
  /// In ar, this message translates to:
  /// **'إجازة'**
  String get holidayStatus;

  /// No description provided for @workStatus.
  ///
  /// In ar, this message translates to:
  /// **'متاح للعمل'**
  String get workStatus;

  /// No description provided for @date.
  ///
  /// In ar, this message translates to:
  /// **'التاريخ'**
  String get date;

  /// No description provided for @addTeeth.
  ///
  /// In ar, this message translates to:
  /// **'إضافة الأسنان'**
  String get addTeeth;

  /// No description provided for @addDescription.
  ///
  /// In ar, this message translates to:
  /// **'إضافة وصف للسن'**
  String get addDescription;

  /// No description provided for @description.
  ///
  /// In ar, this message translates to:
  /// **'وصف الأسنان'**
  String get description;

  /// No description provided for @empty.
  ///
  /// In ar, this message translates to:
  /// **'فارغ'**
  String get empty;

  /// No description provided for @noAppointment.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد موعد'**
  String get noAppointment;

  /// No description provided for @restoreTreatmentPlanM.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من رغبتك في استرجاع هذه الخطة العلاجية؟'**
  String get restoreTreatmentPlanM;

  /// No description provided for @notificationReservation.
  ///
  /// In ar, this message translates to:
  /// **'طلبات الحجز'**
  String get notificationReservation;

  /// No description provided for @titleReject.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من رفض الطلب؟'**
  String get titleReject;

  /// No description provided for @accept.
  ///
  /// In ar, this message translates to:
  /// **'قبول'**
  String get accept;

  /// No description provided for @reject.
  ///
  /// In ar, this message translates to:
  /// **'رفض'**
  String get reject;

  /// No description provided for @allReservations.
  ///
  /// In ar, this message translates to:
  /// **'جميع الحجوزات'**
  String get allReservations;

  /// No description provided for @today.
  ///
  /// In ar, this message translates to:
  /// **'اليوم'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In ar, this message translates to:
  /// **'أمس'**
  String get yesterday;

  /// No description provided for @specificDate.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ محدد'**
  String get specificDate;

  /// No description provided for @addImage.
  ///
  /// In ar, this message translates to:
  /// **'إضافة صورة'**
  String get addImage;

  /// No description provided for @newItem.
  ///
  /// In ar, this message translates to:
  /// **'جديد'**
  String get newItem;

  /// No description provided for @patientExistT.
  ///
  /// In ar, this message translates to:
  /// **'تنبيه'**
  String get patientExistT;

  /// No description provided for @patientExistM.
  ///
  /// In ar, this message translates to:
  /// **'سجل المريض موجود بالفعل.'**
  String get patientExistM;

  /// No description provided for @noWhatsApp.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد رقم واتساب'**
  String get noWhatsApp;

  /// No description provided for @noPhone.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد رقم جوال'**
  String get noPhone;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
