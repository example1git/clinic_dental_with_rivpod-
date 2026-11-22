// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get titleRequest => 'هل أنت متأكد من إرسال طلب الحجز؟';

  @override
  String get titleRequestCancel => 'هل أنت متأكد من إلغاء طلب الحجز؟';

  @override
  String get smRequestCount =>
      'لا يمكنك طلب حجز جديد إلا بعد انتهاء موعد حجزك الحالي.';

  @override
  String get stRequestw => 'لديك طلب حجز قيد الانتظار';

  @override
  String get smRequestw =>
      'يمكنك إرسال طلب جديد بعد انتهاء الطلب الحالي أو إلغائه.';

  @override
  String get requestTitle => 'طلب حجز';

  @override
  String get cancelRequest => 'إلغاء';

  @override
  String get requestStatus => 'حالة الطلب';

  @override
  String get waiting => 'انتظار الرد';

  @override
  String get rejected => 'مرفوض';

  @override
  String get accepted => 'مقبول';

  @override
  String get none => 'لا يوجد';

  @override
  String get holiday => 'في إجازة';

  @override
  String get accountSuspendedM =>
      'تم إيقاف حسابك من قبل إدارة التطبيق. يرجى التواصل مع إدارة التطبيق لمزيد من المعلومات.';

  @override
  String get doctorMale => 'الدكتور';

  @override
  String get doctorFemale => 'الدكتورة';

  @override
  String get setTheme => 'تغيير السمة';

  @override
  String get theme => 'السمة';

  @override
  String get language => 'اللغة';

  @override
  String get chooseLanguage => 'اختر اللغة';

  @override
  String get arabic => 'العربية';

  @override
  String get english => 'الإنجليزية';

  @override
  String get deleteM => 'تم الحذف بنجاح';

  @override
  String get addM => 'تمت الإضافة بنجاح';

  @override
  String get totalPrice => 'المبلغ الإجمالي';

  @override
  String get currentPaid => 'المبلغ المدفوع حاليًا';

  @override
  String get paidAmount => 'المبلغ المدفوع';

  @override
  String get sar => 'ر.س';

  @override
  String get treatmentCase => 'الخطة العلاجية';

  @override
  String get addTreatmentPlan => 'إضافة خطة علاجية';

  @override
  String get deletedTreatmentPlans => 'الخطط العلاجية المحذوفة';

  @override
  String get previouslyPaid => 'المبلغ المدفوع سابقًا';

  @override
  String get remainingPrice => 'المبلغ المتبقي';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get done => 'موافق';

  @override
  String get reservesList => 'قائمة الحجوزات';

  @override
  String get deleteConfirmation => 'هل أنت متأكد من الحذف؟';

  @override
  String get cancel => 'رجوع';

  @override
  String get ok => 'نعم';

  @override
  String get doctorAbbreviation => 'د.';

  @override
  String get refreshT => 'تم التحديث';

  @override
  String get internetT => 'لا يوجد اتصال بالإنترنت';

  @override
  String get internetM => 'يرجى التحقق من اتصال الإنترنت والمحاولة مرة أخرى.';

  @override
  String get errorM => 'حدث خطأ، يرجى المحاولة مرة أخرى.';

  @override
  String get errorSignM =>
      'الحساب موجود بالفعل. استخدم حسابًا آخر أو قم بتسجيل الدخول.';

  @override
  String get fieldIsEmpty => 'الحقل فارغ';

  @override
  String get failedNames => 'يرجى إدخال الاسم الثلاثي بشكل صحيح.';

  @override
  String get failedNicknames => 'يرجى إدخال اللقب بشكل صحيح.';

  @override
  String get passwordTooShort => 'كلمة المرور قصيرة جدًا.';

  @override
  String get invalidPhoneNumber => 'رقم الهاتف غير صحيح.';

  @override
  String get phoneNumberNotFound => 'رقم الهاتف غير موجود.';

  @override
  String get addName => 'إضافة الاسم';

  @override
  String get data => 'لا يوجد بيانات';

  @override
  String get timeoutT => 'انتهت مهلة الاتصال';

  @override
  String get timeoutM => 'اتصال الإنترنت غير مستقر، يرجى المحاولة مرة أخرى.';

  @override
  String get code => 'الرمز';

  @override
  String get codeError => 'الرمز غير صحيح';

  @override
  String get loadError => 'حدث خطأ أثناء تحميل البيانات ';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get right => 'يمين';

  @override
  String get left => 'يسار';

  @override
  String get searchShow => 'إظهار شريط البحث';

  @override
  String get searchHide => 'إخفاء شريط البحث';

  @override
  String get searchFieldTitle => 'ابحث عن سجل...';

  @override
  String get rowLevelM => 'تم إيقاف حسابك من قبل إدارة النظام.';

  @override
  String get doctorProfile => 'الملف الشخصي';

  @override
  String get createPatients => 'إنشاء سجل مريض';

  @override
  String get addLocation => 'تعديل الموقع';

  @override
  String get location => 'الموقع';

  @override
  String get phoneChangeT => 'تغيير رقم الجوال';

  @override
  String get phoneChangeM =>
      'لتغيير رقم الجوال المسجل في حسابك، يرجى التواصل مع إدارة التطبيق.';

  @override
  String get equalzation => 'أدخل المؤهلات';

  @override
  String get editQualifications => 'تعديل المؤهلات';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get verify => 'تأكيد رقم الهاتف';

  @override
  String get messageResend => 'لم تستلم الرمز؟';

  @override
  String get resend => 'إعادة إرسال';

  @override
  String get name => 'الاسم الثلاثي';

  @override
  String get nickName => 'اللقب';

  @override
  String get add => 'اضافة';

  @override
  String get phone => 'رقم الجوال';

  @override
  String get whatsApp => 'رقم واتساب';

  @override
  String get editPhone => 'تعديل أرقام التواصل';

  @override
  String get addAppointment => 'إضافة موعد';

  @override
  String get appointmentTime => 'موعد الحجز';

  @override
  String get appointmentDay => 'حجوزات اليوم';

  @override
  String get changeToHolidayM => 'هل أنت متأكد من تغيير حالتك إلى إجازة؟';

  @override
  String get changeToWorkM => 'هل أنت متأكد من تغيير حالتك إلى متاح للعمل؟';

  @override
  String get holidayStatus => 'إجازة';

  @override
  String get workStatus => 'متاح للعمل';

  @override
  String get date => 'التاريخ';

  @override
  String get addTeeth => 'إضافة الأسنان';

  @override
  String get addDescription => 'إضافة وصف للسن';

  @override
  String get description => 'وصف الأسنان';

  @override
  String get empty => 'فارغ';

  @override
  String get noAppointment => 'لا يوجد موعد';

  @override
  String get restoreTreatmentPlanM =>
      'هل أنت متأكد من رغبتك في استرجاع هذه الخطة العلاجية؟';

  @override
  String get notificationReservation => 'طلبات الحجز';

  @override
  String get titleReject => 'هل أنت متأكد من رفض الطلب؟';

  @override
  String get accept => 'قبول';

  @override
  String get reject => 'رفض';

  @override
  String get allReservations => 'جميع الحجوزات';

  @override
  String get today => 'اليوم';

  @override
  String get yesterday => 'أمس';

  @override
  String get specificDate => 'تاريخ محدد';

  @override
  String get addImage => 'إضافة صورة';

  @override
  String get newItem => 'جديد';

  @override
  String get patientExistM => 'سجل المريض موجود بالفعل.';

  @override
  String get noWhatsApp => 'لا يوجد رقم واتساب';

  @override
  String get noPhone => 'لا يوجد رقم جوال';
}
