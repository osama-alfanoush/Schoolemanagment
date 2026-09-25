# تقرير تجهيز School Management Suite للإنتاج

تاريخ المراجعة: 2026-08-04

## حالة التسليم

هذه النسخة **Release Candidate مؤهلة محلياً**: نجحت بوابات Laravel وPostgreSQL 16 والتزامن وPlaywright/Chromium، ونجح بناء صور الإنتاج والنسخ الاحتياطي والاستعادة. لم يعد نقص PHP/PostgreSQL/Chromium حاجزاً.

قرار الإطلاق الخارجي ما يزال **NO-GO مشروطاً** إلى أن تُختبر خدمات SMTP وStripe وFCM بحسابات sandbox حقيقية، وتُحدد بنية الهدف وDNS/TLS والمراقبة ونسخة الرجوع. إعدادات `.env.prod` و`.env.staging` المحلية خارج Git ولا تحتوي مفاتيح الخدمات الخارجية.

لا تنشر قبل نجاح أوامر قسم «بوابة الإطلاق» أدناه على خادم CI أو staging مماثل للإنتاج.

## أهم الإصلاحات المنفذة

| المجال | ما تم تنفيذه |
|---|---|
| عزل المدارس | `CurrentSchool` كسياق request/worker، middleware موحد، global scopes وفرض `school_id` عند الإنشاء ومنع تغييره عند التعديل، وتقييد استعلامات المستخدمين بعضوية مدرسية فعالة. |
| المصادقة | منع إصدار token عندما لا يملك المستخدم مدرسة فعالة وحيدة؛ refresh وMFA يعملان داخل المدرسة المحققة. |
| قاعدة البيانات | migration تضيف ملكية مدرسية غير nullable للوحدات التي كانت تعتمد على علاقات غير مباشرة، وتحوّل المعرفات التجارية الفريدة إلى قيود مركبة مع المدرسة، وتتوقف دون تخمين عند بيانات متعددة المدارس غير قابلة للإسناد. |
| الصلاحيات | cache للصلاحيات مفصول حسب المدرسة، وصفوف role/user permissions مدرسية، وseed للصلاحيات لكل مدرسة. |
| المالية | قيود دفتر الأستاذ مدرسية ومتوازنة وذرّية وidempotent، مع رفض الترحيل أو العكس داخل فترة مغلقة. المدفوعات والإيصالات والتسويات مفلترة مدرسياً. |
| التزامن | أقفال صفوف ومعاملات للأقساط، أوامر الشراء، الاستلام، حساب المورد، المخزون، استعارة/إرجاع الكتب، وتخصيص النقل. |
| الإشعارات | التسليم المجدول لا يُرسل فور الإنشاء، وكل قناة تُسلّم مرة واحدة، والـcommands/outbox تعالج كل مدرسة في سياق مستقل. |
| الملفات والاستيراد | استيراد الطلاب CSV أصبح streaming بحد حجم/صفوف ومعاملة لكل صف، والتحقق من الصور والموارد بقي خاضعاً للـbackend. |
| الإنتاج | أمثلة env آمنة، preflight يمنع debug/HTTP/CORS غير الآمن والأسرار الوهمية، Nginx يمنع تنفيذ PHP خارج `index.php`، queue بعد commit، نسختا API، Redis، scheduler ونسخ PostgreSQL والملفات المرفوعة. |
| الاعتمادات | تحديث lockfile لإغلاق ثغرات PostCSS وbrace-expansion؛ نتيجة `npm audit` الحالية صفر. |

## الثوابت الأمنية والمالية

- `school_id` القادم من العميل لا يقرر الصلاحية ولا يستطيع نقل السجل بين المدارس.
- المستخدم المرتبط بأكثر من مدرسة فعالة يُمنع حتى يُنفذ اختيار مدرسة صريح.
- القراءة والكتابة على النماذج المدرسية تفشل خارج `CurrentSchool` أو تُقيد به.
- المعرفات مثل رقم الفاتورة، ISBN، SKU، رقم الموظف، رقم أمر الشراء ورقم المسير يمكن تكرارها بين مدرستين ولا يمكن تكرارها داخل المدرسة نفسها.
- العملية المالية الحساسة تُنفذ داخل transaction، ويمنع تكرار أثرها بواسطة idempotency key أو قيد فريد أو قفل صف.
- الفترة المالية `closed` أو `audited` تمنع إنشاء قيد أو قيد عكسي جديد.
- النسخة القديمة من HR/Payroll P0 محفوظة، ومسارات الكتابة القديمة ما زالت موقوفة كما في تقريرها الأصلي.

## الترحيل الجديد

الملف:

`laravel-api/database/migrations/2026_08_03_000002_enforce_school_scope_across_modules.php`

سلوكه:

1. يضيف `school_id` nullable مؤقتاً للجداول غير المباشرة.
2. إذا كانت هناك مدرسة واحدة فقط، يسند الصفوف القديمة إليها.
3. إذا كانت هناك عدة مدارس، يتوقف ويعرض الجداول ومعرفات الصفوف غير المسندة؛ لا يدمج ولا يحذف ولا يخمن.
4. يحول الملكية إلى non-null ويضيف الفهارس والقيود الفريدة المركبة.
5. يتوقف عند تكرار تسليم إشعار قبل إنشاء قيد التسليم الواحد.

بما أن المشروع لم يدخل الإنتاج، المسار الأنظف لقاعدة التطوير غير المهمة هو `migrate:fresh` ثم إنشاء بيانات اختبار جديدة. لا تستخدم `--seed` في الإنتاج.

## نتائج التحقق في بيئة العمل

| الفحص | النتيجة |
|---|---|
| تحليل syntax لكل ملفات PHP | 321 ملفاً، ناجح |
| Vitest | 26 ملفاً، 124 اختباراً ناجحاً |
| TypeScript typecheck | ناجح |
| ESLint | exit 0؛ صفر أخطاء و2803 تحذيراً قديماً من استعمال `any` |
| Vite production build | ناجح؛ 3292 module |
| `npm audit` | صفر ثغرات (production وdevelopment) |
| Bash syntax | 6 scripts ناجحة |
| Production Compose YAML | صالح |
| فحص أسرار شائعة | لم يُعثر على مفتاح حقيقي؛ الموجود placeholders فقط |
| Laravel/PHPUnit | 314 اختباراً، 1029 assertion، ناجح؛ Pint ناجح |
| PostgreSQL 16 | `migrate:fresh` ثم rollback لآخر migration ثم migrate، ناجح |
| PostgreSQL concurrency | 4 اختبارات، 17 assertion، ناجح |
| Playwright/Chromium | 7 رحلات حرجة، 7 ناجحة |
| حاويات الإنتاج | preflight وCompose config والبناء ناجحة؛ PHP 8.2.33 و`pdo_pgsql` وRedis وتشغيل UID 82 غير root |
| Staging dependencies | PostgreSQL وRedis والـqueue وS3 الخاص وS3 للملفات العامة، ناجحة |
| أدوار ومدرستان | 16/16 رحلة HTTP فعلية ناجحة مع تحقق عزل بيانات المدرستين؛ MFA للمدير مفعل |
| البريد والإشعارات | in-app وqueue ناجحان، ورسالة البريد عولجت بنقل `log` المحلي؛ SMTP الخارجي غير مختبر |
| الدفع | الدفع اليدوي والتسوية بلا فروقات ناجحان؛ Stripe sandbox/webhook الخارجي غير مختبر |
| النسخ والاستعادة | dump مع SHA-256 وmanifest ناجح؛ الاستعادة والتحقق من أعداد الصفوف وmigrations نجحا خلال 9.85 ثانية |

تحذيرات ESLint غير حاجبة للبناء وليست أخطاء runtime، لكنها دين تقني يجب تخفيضه تدريجياً، خصوصاً في صفحات المالية والمخزون.

## بوابة الإطلاق الإلزامية

نفذ على staging نظيفة تحتوي PHP 8.2+ وComposer وPostgreSQL 16 وDocker وChromium:

```bash
cd laravel-api
composer install --no-interaction --prefer-dist
composer audit
php artisan optimize:clear
php artisan migrate:fresh --env=testing
php artisan test
php artisan test --configuration phpunit.postgres.xml
php artisan migrate:rollback --step=1 --env=testing
php artisan migrate --env=testing
vendor/bin/pint --test
```

ثم الواجهة:

```bash
cd ../school-web
npm ci
npm audit
npm run test -- --run
npm run typecheck
npm run lint
npm run build
npx playwright install --with-deps chromium
npm run test:e2e
```

وأخيراً تحقق حاويات الإنتاج:

```bash
cd ../laravel-api
cp .env.prod.example .env.prod
# استبدل كل placeholder وأدخل النطاقات والأسرار الحقيقية خارج Git
bash deploy/preflight.sh
docker compose --env-file .env.prod -f docker-compose.prod.yml config --quiet
docker compose --env-file .env.prod -f docker-compose.prod.yml build
```

أي فشل في هذه البوابة يوقف النشر؛ لا يُتجاوز بحذف اختبار أو تخفيف assertion.

## أول نشر

1. جهز DNS وTLS أمام Nginx؛ الحاوية تستمع HTTP داخلياً ويتوقع أن ينهي load balancer أو reverse proxy اتصال TLS.
2. ابنِ الواجهة أولاً: `cd school-web && npm ci && npm run build`.
3. أنشئ `laravel-api/.env.prod` من المثال وشغّل `bash deploy/preflight.sh`.
4. من `laravel-api` شغّل `bash deploy/first-run.sh`.
5. أنشئ المدير دون demo seed:

```bash
deploy/prod-up.sh exec api1 php artisan school:provision-admin admin@example.com --school=1
```

6. تحقق من `/api/healthz` ثم `php artisan ops:smoke --json`، وسجل دخولاً فعلياً لكل دور على staging.
7. اختبر webhook الدفع بتوقيع provider صحيح، البريد، FCM إن فُعّل، ورفع/تنزيل ملف.

## النسخ الاحتياطي والاسترجاع

خدمة `backup` تنشئ يومياً:

- PostgreSQL custom dump مع SHA-256.
- manifest بعدد صفوف كل جدول.
- archive للملفات المرفوعة مع SHA-256.

الحفظ الافتراضي 14 يوماً في `laravel-api/backups`. انقل النسخ أيضاً إلى تخزين خارجي مشفر وغير متصل بالمضيف. اختبر الاسترجاع دورياً على قاعدة مؤقتة، ولا تعتبر وجود dump وحده دليلاً على قابلية الاستعادة.

## الرجوع الآمن

- احتفظ بصورة Docker وbuild الواجهة السابقين ونسخة DB/Uploads متزامنة قبل كل إصدار.
- عند خطأ application فقط: فعّل maintenance، أعد image والواجهة السابقين، ثم شغل smoke tests.
- بعد بدء استقبال بيانات متعددة المدارس **لا تعتمد على `migrate:rollback` لإزالة أعمدة العزل**. الرجوع الآمن هو استعادة النسخة المتزامنة ثم إعادة الصورة السابقة؛ حذف `school_id` يفقد سياق الملكية حتى لو بقيت الصفوف.
- لا تعدل قيوداً مالية تاريخية؛ استخدم القيود العكسية التي يتيحها النظام.

## قرارات ومخاطر متبقية

- تصميم اختيار المدرسة للمستخدم متعدد المدارس غير موجود؛ السلوك الحالي fail-closed مقصود.
- لا توجد أسرار SMTP/Stripe/FCM داخل المشروع. التخزين المتوافق مع S3 والبريد المحلي والإشعارات الداخلية والدفع اليدوي اختُبرت، لكن يجب إدخال مفاتيح sandbox الخارجية وإثبات SMTP وStripe webhook وFCM على أجهزة اختبار قبل قرار GO.
- التخزين المحلي يعمل عبر volume ويُنسخ احتياطياً، لكن الإنتاج الجاد يفضل S3 متوافقاً مع versioning وسياسة retention مستقلة.
- نجحت migrations واختبارات Laravel وPostgreSQL concurrency فعلياً في بيئة التأهيل المحلية؛ يجب إعادة البوابة نفسها على بنية الـstaging الخارجية النهائية قبل تحويل المرور.
- تقرير التدقيق الأصلي لم يكن مرفقاً داخل ZIP، لذلك اعتمدت المراجعة على الكود الفعلي وتقرير HR/Payroll P0 الموجود.

## خريطة الملفات المعدلة

التغييرات موزعة على نحو 65 ملفاً، وأهمها:

- العزل: `app/Services/CurrentSchool.php`, `app/Services/SchoolContext.php`, `app/Http/Middleware/ResolveSchoolContext.php`, `app/Providers/AppServiceProvider.php`, `config/tenancy.php`, `routes/api.php`.
- قاعدة البيانات: migration الجديدة و`database/seeders/PermissionSeeder.php`.
- المالية: `LedgerService.php`, `ReceiptService.php`, `PaymentGatewayService.php`, `FinanceController.php`, `InstallmentController.php`, `ProcurementService.php`.
- الوحدات: controllers/services للإدارة، التسجيل، الدرجات، الرسائل، الإشعارات، المخزون، المكتبة، النقل، HR والرواتب.
- التشغيل: ملفات env example، `docker-compose.prod.yml`, `nginx/prod.conf`, `deploy/*.sh`.
- الاختبارات: `tests/Feature/SchoolWideIsolationTest.php`.
- الواجهة: `school-web/package-lock.json` و`school-web/.env.example`؛ مصدر الواجهة نفسه لم يحتج تغييراً في هذه الجولة.
