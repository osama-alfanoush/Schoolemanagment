# مساحة العمل المالية للطلاب

## القرار المعماري

تم توسيع الجداول المالية القائمة، ولم يُنشأ رصيد طالب موازٍ. مصدر الأرقام هو:

- الرسوم: `invoices.amount`.
- المقبوضات الفعلية: `payments` ذات الحالة `posted`.
- الخصومات والتسويات: `student_financial_adjustments` ذات الحالة `posted`.
- الأقساط: `payment_plans` و`installments`.
- القيود: `journal_batches` ورؤوسها، و`journal_entries` كأسطر مدينة/دائنة.

يبقى `invoices.paid_amount` حقلاً توافقياً للشاشات القديمة، ويُعاد حسابه عند الترحيل والعكس من الدفعات المرحلة. أداة المطابقة القائمة تقارن هذا الحقل مع تخصيصات الدفع.

## دورة العمل

سند القبض والتسوية والقيد اليدوي تستخدم الحالات:

`draft -> approved -> posted -> reversed`

الترحيل والعكس يتمان داخل transaction مع `lockForUpdate`. لا تُحذف السندات أو القيود المرحلة؛ ينشأ قيد عكسي موثق. يمنع الترحيل إلى فترة مالية مغلقة.

## الصلاحيات الجديدة

- `finance.student.view`
- `finance.receipts.{view,create,approve,post,reverse}`
- `finance.adjustments.{view,create,approve,post,reverse}`
- `finance.journal.{view,create,approve,post,reverse}`
- `finance.reports.{view,export}`

تُزرع الصلاحيات افتراضياً لدور `finance`، بينما يملك `admin` تجاوزاً شاملاً. يمكن استخدام `user_permissions` لمنح أو منع إجراء بعينه.

## التشغيل

```bash
php artisan migrate
php artisan db:seed --class=PermissionSeeder
```

لا توجد متغيرات بيئة جديدة. الرجوع ممكن عبر `php artisan migrate:rollback --step=1` فقط قبل إدخال سندات فعلية؛ بعد وجود بيانات مالية يجب أخذ نسخة احتياطية وعدم إسقاط الجداول.

## نقاط النهاية الرئيسية

- `GET /api/finance/students/search`
- `GET /api/finance/students/{id}`
- `GET /api/finance/students/{id}/statement`
- `GET|POST /api/finance/receipts`
- `POST /api/finance/receipts/{id}/{approve|post|reverse}`
- `GET|POST /api/finance/adjustments`
- `POST /api/finance/adjustments/{id}/{approve|post|reverse}`
- `GET|POST /api/accounting/journal-batches`
- `POST /api/accounting/journal-batches/{id}/{approve|post|reverse}`
- `GET /api/finance/workspace-reports/{type}`

## التحقق التشغيلي المختصر

1. افتح `/finance/students` وابحث برقم القبول أو الاسم أو الهاتف أو ولي الأمر.
2. افتح `/finance/payments` وأنشئ سنداً مع توزيع تلقائي أو يدوي، ثم اعتمده ورحّله.
3. تأكد أن الدفعة ظهرت في ملف الطالب وكشف الحساب وأن قيد `student_receipt` متوازن.
4. اعكس سنداً اختبارياً بسبب واضح وتأكد من رجوع الفاتورة/القسط وظهور قيد العكس دون حذف الدفعة.
5. أنشئ خصماً من `/finance/adjustments` واعتمده ورحّله ثم راجع رصيد الطالب.
6. راجع تقرير `reconciliation` في `/finance/reports` وتأكد أن الحالة `matched`.

## حدود معروفة

- ترحيل مدفوعات بوابة Stripe القديمة لا يملك مستخدم نظام يمكن نسب قيد اليومية إليه؛ السندات اليدوية الجديدة وكل قبض الأقساط من مساحة العمل تولّد قيوداً آلية. يلزم تعريف هوية system actor قبل ربط webhook باليومية دون نسبة العملية إلى موظف غير حقيقي.
- تصدير مركز التقارير الجديد حالياً CSV متوافق مع Excel للصفحة المعروضة، بينما PDF متاح للسندات وتقارير المحاسبة الحالية. تصدير مجموعات ضخمة بالكامل يجب أن ينتقل إلى job مؤجل بدلاً من تحميلها في طلب HTTP واحد.
- الفرع والسنة الأكاديمية ظاهران من ملف الطالب، لكن الفواتير القديمة لا تحمل مفتاح فرع/سنة مستقلاً؛ لذلك لا يمكن فرض عزل مالي متعدد الفروع بأمان قبل ترحيل هذه المفاتيح إلى بيانات الفواتير التاريخية.
