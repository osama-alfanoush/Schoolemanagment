// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'سويت المدرسة';

  @override
  String get activeFlavor => 'النكهة النشطة';

  @override
  String get apiBaseUrl => 'عنوان واجهة البرمجة';

  @override
  String get currentLocale => 'اللغة الحالية';

  @override
  String get notConfigured => 'غير محدد';

  @override
  String get sampleAmount => 'مبلغ تجريبي';

  @override
  String get sampleDate => 'التاريخ';

  @override
  String get digitShape => 'شكل الأرقام';

  @override
  String get digitShapeWestern => 'غربي';

  @override
  String get digitShapeArabicIndic => 'عربي هندي';

  @override
  String get textDirection => 'اتجاه النص';

  @override
  String get upgradeRequiredTitle => 'يجب تحديث التطبيق';

  @override
  String get upgradeRequiredBody =>
      'هذه النسخة من التطبيق لم تعد مدعومة. حدّث التطبيق من متجر Play للمتابعة.';

  @override
  String get upgradeRecommendedBody => 'يتوفر إصدار أحدث من التطبيق.';

  @override
  String get upgradeCheckAgain => 'تحقّق مرة أخرى';

  @override
  String get later => 'لاحقًا';

  @override
  String get notFoundTitle => 'الصفحة غير موجودة';

  @override
  String get notFoundBody => 'الرابط الذي فتحته غير صالح أو لم يعد متاحًا.';

  @override
  String get goHome => 'العودة إلى الرئيسية';

  @override
  String get switchRoleTitle => 'تبديل الحساب';

  @override
  String get switchRoleBody =>
      'لديك أكثر من دور في المدرسة. اختر الدور الذي تريد عرضه.';

  @override
  String get roleParent => 'ولي أمر';

  @override
  String get roleTeacher => 'معلّم';

  @override
  String get roleStudent => 'طالب';

  @override
  String get signInTitle => 'تسجيل الدخول';

  @override
  String get noMobileRoleTitle => 'التطبيق غير متاح لحسابك';

  @override
  String get noMobileRoleBody =>
      'تطبيق الجوال مخصّص لأولياء الأمور والمعلّمين والطلاب. استخدم لوحة التحكم على المتصفح.';

  @override
  String get screenNotBuiltTitle => 'هذه الشاشة قيد الإنشاء';

  @override
  String get screenNotBuiltBody => 'لم يتم بناء هذه الشاشة بعد.';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navFees => 'الرسوم';

  @override
  String get navAcademics => 'الدراسة';

  @override
  String get navMessages => 'الرسائل';

  @override
  String get navProfile => 'الحساب';

  @override
  String get navToday => 'اليوم';

  @override
  String get navClasses => 'الصفوف';

  @override
  String get navTimetable => 'الجدول';

  @override
  String get navAssignments => 'الواجبات';

  @override
  String get navGrades => 'الدرجات';

  @override
  String get loading => 'جارٍ التحميل…';

  @override
  String get emptyTitle => 'لا توجد بيانات';

  @override
  String get emptyBody => 'لا يوجد ما يُعرض حاليًا.';

  @override
  String get errorTitle => 'تعذّر تحميل البيانات';

  @override
  String get errorOfflineTitle => 'لا يوجد اتصال بالإنترنت';

  @override
  String get errorOfflineBody => 'تحقّق من اتصالك بالإنترنت ثم أعد المحاولة.';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get requestIdLabel => 'رقم المرجع';

  @override
  String get requestIdHint => 'اذكر هذا الرقم عند التواصل مع المدرسة.';

  @override
  String get offlineBanner => 'أنت غير متصل. تُعرض بيانات محفوظة.';

  @override
  String get pendingSyncTooltip => 'عناصر لم تُرسل إلى الخادم بعد';

  @override
  String get failedSyncTooltip => 'عناصر تعذّرت مزامنتها';

  @override
  String pendingSyncCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count عنصر بانتظار المزامنة',
      many: '$count عنصرًا بانتظار المزامنة',
      few: '$count عناصر بانتظار المزامنة',
      two: 'عنصران بانتظار المزامنة',
      one: 'عنصر واحد بانتظار المزامنة',
      zero: 'لا شيء بانتظار المزامنة',
    );
    return '$_temp0';
  }

  @override
  String failedSyncCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count عنصر تعذّرت مزامنته',
      many: '$count عنصرًا تعذّرت مزامنته',
      few: '$count عناصر تعذّرت مزامنتها',
      two: 'عنصران تعذّرت مزامنتهما',
      one: 'عنصر واحد تعذّرت مزامنته',
      zero: 'لا شيء تعذّرت مزامنته',
    );
    return '$_temp0';
  }

  @override
  String lastUpdated(String time) {
    return 'آخر تحديث: $time';
  }

  @override
  String get signInSubtitle =>
      'سجّل الدخول بالبريد الإلكتروني وكلمة المرور التي زوّدتك بها المدرسة.';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get showPassword => 'إظهار كلمة المرور';

  @override
  String get hidePassword => 'إخفاء كلمة المرور';

  @override
  String get signInAction => 'تسجيل الدخول';

  @override
  String get emailRequired => 'أدخل البريد الإلكتروني.';

  @override
  String get emailInvalid => 'البريد الإلكتروني غير صالح.';

  @override
  String get passwordRequired => 'أدخل كلمة المرور.';

  @override
  String get loginInvalidCredentials =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة.';

  @override
  String get loginTooManyAttempts =>
      'محاولات كثيرة خلال وقت قصير. انتظر قليلًا ثم حاول مرة أخرى.';

  @override
  String get loginNoSchoolAccess =>
      'لا يوجد لحسابك ارتباط مدرسي فعّال. تواصل مع إدارة المدرسة.';

  @override
  String get loginDeviceNotReady =>
      'تعذّر تجهيز معرّف هذا الجهاز. أعد تشغيل التطبيق ثم حاول مرة أخرى.';

  @override
  String get loginFailedGeneric => 'تعذّر تسجيل الدخول. حاول مرة أخرى.';

  @override
  String loginAccountLocked(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other:
          'تم إيقاف الحساب مؤقتًا بسبب محاولات دخول خاطئة. حاول مرة أخرى بعد $minutes دقيقة.',
      many:
          'تم إيقاف الحساب مؤقتًا بسبب محاولات دخول خاطئة. حاول مرة أخرى بعد $minutes دقيقة.',
      few:
          'تم إيقاف الحساب مؤقتًا بسبب محاولات دخول خاطئة. حاول مرة أخرى بعد $minutes دقائق.',
      two: 'تم إيقاف الحساب مؤقتًا بسبب محاولات دخول خاطئة. حاول مرة أخرى بعد دقيقتين.',
      one: 'تم إيقاف الحساب مؤقتًا بسبب محاولات دخول خاطئة. حاول مرة أخرى بعد دقيقة.',
      zero: 'تم إيقاف الحساب مؤقتًا بسبب محاولات دخول خاطئة. حاول مرة أخرى بعد قليل.',
    );
    return '$_temp0';
  }

  @override
  String get mfaTitle => 'التحقق بخطوتين';

  @override
  String get mfaBody => 'أدخل رمز التحقق من تطبيق المصادقة على هاتفك.';

  @override
  String get mfaCodeLabel => 'رمز التحقق';

  @override
  String get mfaRecoveryCodeLabel => 'رمز الاسترداد';

  @override
  String get mfaUseRecoveryCode => 'استخدام رمز استرداد';

  @override
  String get mfaUseAuthenticatorCode => 'استخدام رمز تطبيق المصادقة';

  @override
  String get mfaVerifyAction => 'تحقّق';

  @override
  String get mfaCodeRequired => 'أدخل الرمز.';

  @override
  String get mfaCodeIncomplete => 'الرمز غير مكتمل.';

  @override
  String get mfaInvalidCode => 'الرمز غير صحيح. حاول مرة أخرى.';

  @override
  String get mfaChallengeExpired =>
      'انتهت صلاحية جلسة التحقق. سجّل الدخول مرة أخرى.';

  @override
  String get mfaEnrollmentRequiredTitle => 'يلزم إعداد التحقق بخطوتين';

  @override
  String get mfaEnrollmentRequiredBody =>
      'حسابك يتطلّب التحقق بخطوتين ولم يتم إعداده بعد. أكمل الإعداد من لوحة التحكم على المتصفح، ثم عد إلى التطبيق.';

  @override
  String get backToSignIn => 'العودة إلى تسجيل الدخول';

  @override
  String get changePasswordTitle => 'يجب تغيير كلمة المرور';

  @override
  String get changePasswordBody =>
      'كلمة المرور الحالية مؤقتة. اختر كلمة مرور جديدة للمتابعة.';

  @override
  String get currentPasswordLabel => 'كلمة المرور الحالية';

  @override
  String get newPasswordLabel => 'كلمة المرور الجديدة';

  @override
  String get confirmPasswordLabel => 'تأكيد كلمة المرور الجديدة';

  @override
  String get changePasswordAction => 'حفظ كلمة المرور';

  @override
  String get passwordTooShort => 'كلمة المرور قصيرة جدًا.';

  @override
  String get passwordNeedsUppercase => 'أضف حرفًا لاتينيًا كبيرًا على الأقل.';

  @override
  String get passwordNeedsDigit => 'أضف رقمًا على الأقل.';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get currentPasswordIncorrect => 'كلمة المرور الحالية غير صحيحة.';

  @override
  String get accountDeactivated => 'تم إيقاف حسابك. تواصل مع إدارة المدرسة.';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get appLockTitle => 'التطبيق مقفل';

  @override
  String get appLockBody =>
      'افتح القفل للمتابعة. القفل يحمي ما هو معروض على الشاشة فقط؛ جلستك لم تنتهِ.';

  @override
  String get appLockUnlockAction => 'فتح القفل';

  @override
  String get appLockReason => 'افتح قفل تطبيق المدرسة';

  @override
  String get appLockFailed =>
      'لم يتم التعرّف عليك. حاول مرة أخرى أو سجّل الخروج.';

  @override
  String get appLockLockedOut =>
      'تم إيقاف المحاولات مؤقتًا. انتظر قليلًا أو سجّل الخروج.';

  @override
  String get appLockUnavailable =>
      'لا يمكن عرض طلب الفتح على هذا الجهاز. سجّل الخروج ثم ادخل من جديد.';

  @override
  String get securityTitle => 'الأمان';

  @override
  String get appLockSetting => 'قفل التطبيق';

  @override
  String get appLockSettingBody =>
      'اطلب بصمة أو رمز الجهاز عند العودة إلى التطبيق.';

  @override
  String get appLockUnsupported =>
      'هذا الجهاز لا يدعم قفل الشاشة. فعّل قفل الشاشة في إعدادات الجهاز أولًا.';

  @override
  String get appLockTimeoutSetting => 'القفل بعد';

  @override
  String get appLockTimeoutImmediate => 'فورًا';

  @override
  String get devicesTitle => 'الأجهزة';

  @override
  String get devicesBody => 'الأجهزة التي سجّلت الدخول إلى حسابك.';

  @override
  String get devicesEmpty => 'لا توجد أجهزة مسجّلة بعد.';

  @override
  String get deviceThisDevice => 'هذا الجهاز';

  @override
  String get deviceLastSeen => 'آخر ظهور';

  @override
  String get deviceRevoke => 'إنهاء الجلسة';

  @override
  String get deviceRevokeConfirmTitle => 'إنهاء الجلسة على هذا الجهاز؟';

  @override
  String get deviceRevokeConfirmBody =>
      'سيُطلب تسجيل الدخول من جديد على ذلك الجهاز.';

  @override
  String get deviceRevokeSelfBody =>
      'هذا هو الجهاز الذي تستخدمه الآن. سيتم تسجيل خروجك فورًا.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirm => 'تأكيد';

  @override
  String get diagnosticsTitle => 'تشخيص';

  @override
  String get activateTitle => 'تفعيل الحساب';

  @override
  String get activateBody =>
      'أدخل رمز التفعيل الذي زوّدتك به المدرسة. لا حاجة لكلمة مرور.';

  @override
  String get activateCodeLabel => 'رمز التفعيل';

  @override
  String get activateAction => 'تفعيل';

  @override
  String get activateCodeRequired => 'أدخل رمز التفعيل.';

  @override
  String get activateCodeIncomplete => 'الرمز غير مكتمل.';

  @override
  String get activateCodeRejected =>
      'هذا الرمز غير صالح أو تم استخدامه. تواصل مع إدارة المدرسة للحصول على رمز جديد.';

  @override
  String get activateNoSchoolAccess =>
      'لا يوجد لحسابك ارتباط مدرسي فعّال. تواصل مع إدارة المدرسة.';

  @override
  String get activateHaveCode => 'لديك رمز تفعيل من المدرسة؟';

  @override
  String get activateOpen => 'التفعيل برمز';

  @override
  String get activateProtectTitle => 'احمِ التطبيق';

  @override
  String get activateProtectBody =>
      'فعّل قفل التطبيق ليطلب بصمتك أو رمز جهازك عند فتحه. يمكنك تغيير ذلك لاحقًا من الأمان.';

  @override
  String get activateProtectEnable => 'تفعيل القفل';

  @override
  String get skip => 'تخطٍّ';

  @override
  String get parentHomeTitle => 'الرئيسية';

  @override
  String get parentHomeEmpty =>
      'لم يتم ربط أي طالب بحسابك بعد. تواصل مع إدارة المدرسة.';

  @override
  String get attendanceThisWeek => 'الحضور هذا الأسبوع';

  @override
  String get attendanceNotRecorded => 'لم يُسجَّل الحضور بعد';

  @override
  String get nextPayment => 'القسط القادم';

  @override
  String get noPaymentDue => 'لا توجد أقساط مستحقة';

  @override
  String get dueToday => 'يستحق اليوم';

  @override
  String get latestGrade => 'آخر درجة';

  @override
  String get noGradeYet => 'لا توجد درجات منشورة بعد';

  @override
  String get todaySchedule => 'حصص اليوم';

  @override
  String get noLessonsToday => 'لا توجد حصص اليوم';

  @override
  String daysRemaining(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'بعد $days يوم',
      many: 'بعد $days يومًا',
      few: 'بعد $days أيام',
      two: 'بعد يومين',
      one: 'بعد يوم',
      zero: 'يستحق اليوم',
    );
    return '$_temp0';
  }

  @override
  String daysOverdue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'متأخر $days يوم',
      many: 'متأخر $days يومًا',
      few: 'متأخر $days أيام',
      two: 'متأخر يومان',
      one: 'متأخر يوم',
    );
    return '$_temp0';
  }

  @override
  String get feesTitle => 'الرسوم';

  @override
  String get feesBalance => 'الرصيد المستحق';

  @override
  String get feesBilled => 'إجمالي الرسوم';

  @override
  String get feesPaid => 'المدفوع';

  @override
  String get feesNothingDue => 'لا توجد رسوم مستحقة';

  @override
  String get feesSchedule => 'جدول الأقساط';

  @override
  String get feesScheduleMismatch =>
      'مجموع الأقساط لا يطابق إجمالي الخطة. تواصل مع إدارة المدرسة.';

  @override
  String get payAction => 'ادفع';

  @override
  String get payConfirmTitle => 'تأكيد الدفع';

  @override
  String get payConfirmAction => 'تأكيد الدفع';

  @override
  String get payOfflineTitle => 'الدفع يحتاج اتصالًا بالإنترنت';

  @override
  String get payOfflineBody =>
      'لا يمكن حفظ الدفع للإرسال لاحقًا. تحقّق من اتصالك ثم حاول مرة أخرى.';

  @override
  String get payFailed => 'تعذّر إتمام الدفع. حاول مرة أخرى.';

  @override
  String get payAlreadySettled => 'تم سداد هذا القسط.';

  @override
  String get payStarted => 'تم بدء عملية الدفع';

  @override
  String get paymentReference => 'رقم العملية';

  @override
  String get invoiceTitle => 'الفاتورة';

  @override
  String get invoicesTitle => 'الفواتير';

  @override
  String get invoicesEmpty => 'لا توجد فواتير.';

  @override
  String get clearanceTitle => 'حالة الفوترة الإلكترونية';

  @override
  String get clearancePending => 'قيد المعالجة — لم تصدر بعد';

  @override
  String get clearanceCleared => 'معتمدة';

  @override
  String get clearanceRejected => 'مرفوضة';

  @override
  String get clearanceNoQrYet =>
      'يظهر رمز الاستجابة السريعة بعد اعتماد الفاتورة من الدائرة.';

  @override
  String get downloadReceipt => 'تنزيل الإيصال';

  @override
  String get academicsTitle => 'الدراسة';

  @override
  String get attendanceSection => 'الحضور';

  @override
  String get gradesSection => 'الدرجات';

  @override
  String get reportCardsSection => 'الشهادات';

  @override
  String get statusPresent => 'حاضر';

  @override
  String get statusAbsent => 'غائب';

  @override
  String get statusLate => 'متأخر';

  @override
  String get statusExcused => 'بعذر';

  @override
  String get attendanceEmpty => 'لم يُسجَّل حضور في هذه الفترة.';

  @override
  String get explainAbsenceAction => 'توضيح الغياب';

  @override
  String get explainAbsenceTitle => 'توضيح الغياب';

  @override
  String get explainAbsenceBody =>
      'أرسل سبب الغياب إلى المدرسة. المدرسة وحدها تقرّر اعتبار الغياب بعذر.';

  @override
  String get explainAbsenceHint => 'سبب الغياب';

  @override
  String get explainAbsenceSubmit => 'إرسال';

  @override
  String get explainAbsenceRequired => 'اكتب سبب الغياب.';

  @override
  String get explanationFiled => 'تم إرسال التوضيح إلى المدرسة.';

  @override
  String get explanationFromSchool => 'ملاحظة المدرسة';

  @override
  String get explanationFromYou => 'توضيحك';

  @override
  String get gradesEmpty => 'لا توجد درجات منشورة بعد.';

  @override
  String get reportCardsEmpty => 'لا توجد شهادات صادرة بعد.';

  @override
  String get reportCardDownload => 'تنزيل الشهادة';

  @override
  String reportCardVersion(int version) {
    String _temp0 = intl.Intl.pluralLogic(
      version,
      locale: localeName,
      other: 'الإصدار $version',
      two: 'الإصدار الثاني',
      one: 'الإصدار الأول',
    );
    return '$_temp0';
  }

  @override
  String get inboxTitle => 'الإشعارات';

  @override
  String get notificationsEmpty => 'لا توجد إشعارات.';

  @override
  String get preferencesTitle => 'تفضيلات الإشعارات';

  @override
  String get categoryFees => 'الرسوم';

  @override
  String get categoryAttendance => 'الحضور';

  @override
  String get categoryGrades => 'الدرجات';

  @override
  String get categoryMessages => 'الرسائل';

  @override
  String get categoryAnnouncements => 'الإعلانات';

  @override
  String get categoryEmergency => 'الطوارئ';

  @override
  String get categoryAlwaysOn => 'تصل دائمًا';

  @override
  String get messagesTitle => 'الرسائل';

  @override
  String get messagesEmpty =>
      'لا توجد رسائل. تبدأ المدرسة المحادثة عند الحاجة.';

  @override
  String get messageReplyHint => 'اكتب ردك';

  @override
  String get messageSend => 'إرسال';

  @override
  String get messageReplyOnly => 'يمكنك الرد على رسائل المدرسة فقط.';

  @override
  String get messageOutsideHours => 'يمكن إرسال الرسائل خلال ساعات الدوام فقط.';

  @override
  String get messageFailed => 'تعذّر إرسال الرسالة. حاول مرة أخرى.';

  @override
  String get timetableTitle => 'الجدول الأسبوعي';

  @override
  String get timetableEmpty => 'لا يوجد جدول لهذا الصف بعد.';

  @override
  String get teacherTodayTitle => 'يومي';

  @override
  String get teacherClassesTitle => 'صفوفي';

  @override
  String get teacherNoPeriods => 'لا توجد حصص مسجّلة اليوم.';

  @override
  String get teacherNoClasses => 'لم تُسنَد إليك أي صفوف بعد.';

  @override
  String get attendanceOutstanding => 'لم يُرصد الحضور';

  @override
  String get attendanceQueued => 'بانتظار الإرسال';

  @override
  String get attendanceSubmitted => 'وصل المدرسة';

  @override
  String get attendanceQueuedExplained =>
      'محفوظ على هذا الجهاز فقط، ولم يصل المدرسة بعد.';

  @override
  String get attendanceWindowClosed => 'انتهت مهلة تعديل الحضور لهذا اليوم.';

  @override
  String get attendanceRejectedTitle => 'إرسال حضور مرفوض';

  @override
  String get rosterTitle => 'قائمة الصف';

  @override
  String get rosterSearchHint => 'ابحث بالاسم أو رقم القيد';

  @override
  String get rosterEmpty => 'لا يوجد طلاب في هذا الصف.';

  @override
  String get rosterNoMatch => 'لا نتائج مطابقة.';

  @override
  String get homeroomBadge => 'مربّي الصف';

  @override
  String get guardianContactTitle => 'التواصل مع ولي الأمر';

  @override
  String get guardianNone => 'لا يوجد ولي أمر مسجّل.';

  @override
  String get guardianNoPhone => 'لا يوجد رقم مسجّل.';

  @override
  String get guardianCall => 'اتصال';

  @override
  String get guardianCallFailed => 'تعذّر بدء الاتصال.';

  @override
  String studentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count طالب',
      many: '$count طالبًا',
      few: '$count طلاب',
      two: 'طالبان',
      one: 'طالب واحد',
      zero: 'لا طلاب',
    );
    return '$_temp0';
  }
}
