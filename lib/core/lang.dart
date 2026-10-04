import 'package:get/get.dart';

class Lang implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ar': {
      // Patient *****************************
      'title request': 'هل أنت متأكد من إرسال طلب الحجز؟',
      'title requestcancel': 'هل أنت متأكد من إلغاء طلب الحجز؟',

      'stRequestCount': 'لديك طلب حجز مقبول',
      'smRequestCount':
          'لا يمكنك طلب حجز جديد إلا بعد انتهاء موعد حجزك الحالي.',
      'stRequestw': 'لديك طلب حجز قيد الانتظار',
      'smRequestw': 'يمكنك إرسال طلب جديد بعد رفض الطلب الحالي أو إلغائه.',
      'requestTitle': 'طلب حجز',
      'cancelRequest': 'إلغاء',
      'holiday': 'في إجازة',
      'accountSuspendedT': 'تم إيقاف الحساب',
      'accountSuspendedM':
          'تم إيقاف حسابك من قبل إدارة التطبيق. يرجى التواصل مع إدارة التطبيق لمزيد من المعلومات.',

      // Doctor and Patient *****************************
      'doctor_male': 'الدكتور',
      'doctor_female': 'الدكتورة',

      'sThemeSelectT': 'تنبيه',
      'sThemeSelectM': 'يرجى اختيار سمة لحفظ التغييرات.',
      'sThemeT': 'تم تطبيق السمة',
      'sThemeM': 'يرجى إعادة تشغيل التطبيق لتطبيق التغييرات.',
      'set theme': 'تغيير السمة',
      'theme': 'السمة',

      'Language': 'اللغة',
      'Chose Language': 'اختر اللغة',
      'Arabia': 'العربية',
      'English': 'الإنجليزية',

      'DeleteT': '✔',
      'DeleteM': 'تم الحذف بنجاح',

      'ِِAddT': '✔',
      'AddM': 'تمت الإضافة بنجاح',

      'total price': 'المبلغ الإجمالي',
      'currentPaid': 'المبلغ المدفوع حاليًا',
      'payPaid': 'المبلغ المدفوع',
      'treatmentcase': 'الخطة العلاجية',
      'AddTreatmentPlan': 'إضافة خطة علاجية',
      'deletedTreatmentPlans': 'الخطط العلاجية المحذوفة',

      'timeCreate': 'وقت الإنشاء',
      'previouslyPaid': 'المبلغ المدفوع سابقًا',
      'remaining price': 'المبلغ المتبقي',
      'previously paid': 'المبلغ المدفوع سابقًا',

      'signOut': 'تسجيل الخروج',
      'done': 'موافق',

      'reserves list': 'قائمة الحجوزات',

      'title delet': 'هل أنت متأكد من الحذف؟',
      'cancel': 'رجوع',
      'ok': 'نعم',

      'D': 'د.',

      'refreshT': 'تم التحديث',
      'refreshM': 'تم تحديث البيانات، يمكنك المحاولة مرة أخرى لاحقا.',
      'internetT': 'لا يوجد اتصال بالإنترنت',
      'internetM': 'يرجى التحقق من اتصال الإنترنت والمحاولة مرة أخرى.',

      'errorT': 'خطأ',
      'errorM': 'حدث خطأ، يرجى المحاولة مرة أخرى.',
      'errorSignM':
          'الحساب موجود بالفعل. استخدم حسابًا آخر أو قم بتسجيل الدخول',

      'Field is empty': 'الحقل فارغ',
      'faild names': 'يرجى إدخال الاسم الثلاثي بشكل صحيح.',
      'faild Nickames': 'يرجى إدخال اللقب بشكل صحيح.',
      'length passwors': 'كلمة المرور قصيرة جداً.',
      'number is not valid': 'رقم الهاتف غير صحيح.',
      'number is not found': 'رقم الهاتف غير موجود.',
      'AddName': 'إضافة الاسم',

      'timeoutT': 'انتهت مهلة الاتصال',
      'timeoutM': 'اتصال الإنترنت غير مستقر، يرجى المحاولة مرة أخرى.',

      'rolechoice': 'حدد دورك في التطبيق',

      'Code': 'الرمز',
      'codeError': 'الرمز غير صحيح',

      'right': 'يمين',
      'left': 'يسار',

      // Doctor *****************************
      'searchShow': 'إظهار شريط البحث',
      'searchHide': 'إخفاء شريط البحث',
      'searchFiledTitle': 'ابحث عن سجل...',

      'rowlevelT': 'تنبيه',
      'rowlevelM': 'تم إيقاف حسابك من قبل إدارة النظام.',

      'isworkT': 'تم التحديث',
      'isworkM': 'يمكنك تغيير الحالة مرة أخرى بعد دقيقتين.',

      'doctor profile': 'الملف الشخصي',
      'create patients': 'إنشاء سجل مريض',

      'Add location': 'تعديل الموقع',
      'location': 'الموقع',
      'phoneChangeT': 'تغيير رقم الجوال',
      'phoneChangeM':
          'لتغيير رقم الجوال المسجل في حسابك، يرجى التواصل مع إدارة التطبيق.',

      'equalzation': 'أدخل المؤهلات',
      'editQualifications': 'تعديل المؤهلات',

      'signin': 'إنشاء حساب',
      'login': 'تسجيل الدخول',
      'Verify': 'تأكيد رقم الهاتف',

      'messageResend': 'لم تستلم الرمز؟',

      'Resend': 'إعادة إرسال',

      'name': 'الاسم الثلاثي',
      'nickName': 'اللقب',

      'phone': 'رقم الجوال',
      'whatsApp': 'رقم واتساب',

      'editPhone': 'تعديل أرقام التواصل',

      'Add': 'إضافة',

      'Add apointmentn': 'إضافة موعد',
      'time Appointment': 'موعد الحجز',
      'appoinment Day': 'حجوزات اليوم',
      'changeToHolidayM': 'هل أنت متأكد من تغيير حالتك إلى إجازة؟',
      'changeToWorkM': 'هل أنت متأكد من تغيير حالتك إلى متاح للعمل؟',
      'holidayStatus': 'إجازة',
      'workStatus': 'متاح للعمل',

      'date': 'التاريخ',

      'Add teeth': 'إضافة الأسنان',
      'AddDescription': 'إضافة وصف للسن',
      'description': 'وصف الأسنان',
      'empty': 'فارغ',
      'noAppointment': 'لا يوجد موعد',
      'restoreTreatmentPlanM':
          'هل أنت متأكد من رغبتك في استرجاع هذه الخطة العلاجية؟',

      'notfication reservation': 'طلبات الحجز',

      'title reject': 'هل أنت متأكد من رفض الطلب؟',

      'Accept': 'قبول',
      'reject': 'رفض',
      'allReservations': 'جميع الحجوزات',
      'today': 'اليوم',
      'yesterday': 'أمس',
      'specificDate': 'تاريخ محدد',

      'add image': 'إضافة صورة',
      'New': 'جديد',

      'patientExistT': 'تنبيه',
      'patientExistM': 'سجل المريض موجود بالفعل.',

      'No WhatsApp': 'لا يوجد رقم واتساب',
      'No phone': 'لا يوجد رقم جوال',
    },
    'en': {
      // Patient *****************************
      'requestTitle': 'Booking Request',
      'title request': 'Do you really want to request a booking?',
      'title requestcancel':
          'Do you really want to cancel the booking request?',

      'stRequestCount': 'You already have an accepted request',
      'smRequestCount':
          'You cannot request a new appointment until your current appointment has ended.',

      'stRequestw': 'You have a pending booking',
      'smRequestw':
          'You can request another booking after the current request is rejected or cancelled.',
      'cancelRequest': 'Cancel',

      'holiday': 'On Leave',
      'accountSuspendedT': 'Account Suspended',
      'accountSuspendedM':
          'Your account has been suspended by the app administration. Please contact the app administration for more information.',

      // Doctor and Patient *****************************
      'doctor_male': 'Dr.',
      'doctor_female': 'Dr.',
      'sThemeSelectT': 'Notice',
      'sThemeSelectM': 'Please choose a theme to save changes.',
      'sThemeT': 'Theme Applied',
      'sThemeM': 'Please restart the application to apply the changes.',
      'set theme': 'Set Theme',
      'theme': 'Theme',
      'Language': 'Language',
      'Chose Language': 'Choose Language',
      'Arabia': 'Arabic',
      'English': 'English',

      'DeleteT': '✔',
      'DeleteM': 'Deleted Successfully',
      'ِِAddT': '✔',
      'AddM': 'Added Successfully',

      'total price': 'Total Amount',
      'currentPaid': 'Current Paid Amount',
      'payPaid': 'Paid Amount',
      'treatmentcase': 'Treatment Plan',
      'AddTreatmentPlan': 'Add Treatment Plan',
      'deletedTreatmentPlans': 'Deleted Treatment Plans',
      'timeCreate': 'Creation Time',

      'previouslyPaid': 'Previously Paid Amount',
      'pay price': 'Paid Amount',
      'remaining price': 'Remaining Amount',
      'previously paid': 'Previously Paid Amount',
      'signOut': 'Sign Out',
      'done': 'OK',
      'reserves list': 'Reservations List',
      'title delet': 'Are you sure you want to delete?',
      'cancel': 'Back',
      'ok': 'Yes',
      'D': 'D',
      'refreshT': 'Updated',
      'refreshM': 'Data has been updated. Please try again later.',
      'internetT': 'No Internet Connection',
      'internetM': 'Please check your internet connection and try again.',

      'errorT': 'Error',
      'errorM': 'Something went wrong. Please try again.',
      'errorSignM':
          'This account already exists. You can use another account or log in.',

      'Field is empty': 'Field is empty',
      'faild names': 'Please enter the full name correctly.',
      'faild Nickames': 'Please enter a valid nickname.',
      'length passwors': 'Password is too short.',
      'number is not valid': 'Invalid phone number.',
      'number is not found': 'phone number is not found',
      'AddName': 'Add Name',

      'timeoutT': 'Connection Timeout',
      'timeoutM': 'Your internet connection is unstable. Please try again.',
      'rolechoice': 'Select your role in the application.',
      'Code': 'Code',
      'codeError': 'Invalid code',
      'right': 'Right',
      'left': 'Left',

      // Doctor *****************************
      'searchShow': 'Show Search Bar',
      'searchHide': 'Hide Search Bar',
      'searchFiledTitle': '...search record',

      'rowlevelT': 'Error',
      'rowlevelM': 'Your account has been suspended by the developer.',
      'isworkT': 'Updated',
      'isworkM': 'You can change your status again after 2 minutes.',
      'doctor profile': 'Doctor Profile',
      'create patients': 'Create Patient Record',
      'Add location': 'Edit Location',
      'phoneChangeT': 'Change Phone Number',
      'phoneChangeM':
          'To change the phone number registered to your account, please contact the app administrator.',

      'location': 'Location',
      'equalzation': 'Enter Qualifications',
      'editQualifications': 'Edit Qualifications',

      'signin': 'Signup',
      'login': 'Login',
      'Verify': 'Verify your phone number',
      'messageResend': 'Didnt receive the code?',
      'Resend': 'Resend',

      'name': 'Full Name',
      'nickName': 'Nickname',
      'phone': 'Phone Number',
      'whatsApp': 'WhatsApp Number',
      'editPhone': 'Edit Numbers',
      'Add': 'Add',
      'Add apointmentn': 'Add Appointment',
      'changeToHolidayM':
          'Are you sure you want to change your status to On Leave?',
      'changeToWorkM':
          'Are you sure you want to change your status to Available for Work?',
      'holidayStatus': 'On Leave',
      'workStatus': 'Available for Work',
      'time Appointment': 'Appointment Time',
      'appoinment Day': "Today's Appointments",

      'date': 'Date',
      'Add teeth': 'Add Teeth',
      'AddDescription': 'Add Tooth Description',
      'description': 'Tooth Description',

      'empty': 'Empty',
      'noAppointment': 'No Appointment',
      'restoreTreatmentPlanM':
          'Are you sure you want to restore this treatment plan?',

      'notfication reservation': 'Booking Requests',
      'title reject': 'Are you sure you want to reject?',
      'allReservations': 'All Reservations',

      'Accept': 'Accept',
      'reject': 'Reject',
      'add image': 'Add Image',
      'New': 'New',
      'patientExistT': 'Notice',
      'patientExistM': 'Patient record already exists.',
      'today': 'Today',
      'yesterday': 'Yesterday',
      'specificDate': 'Specific Date',
      'No WhatsApp': 'No WhatsApp Number',
      'No phone': 'No Phone Number',
    },
  };
}
