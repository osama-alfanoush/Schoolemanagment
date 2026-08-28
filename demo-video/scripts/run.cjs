/*
 * Records a narrated walkthrough of the School Management Suite.
 *
 *   node run.cjs --dry     rehearsal: no video, sprint timings, reports broken steps
 *   node run.cjs           full recording -> out/<session>/*.webm
 *
 * Everything runs against the real Laravel API on :8000 through the Vite dev
 * server on :5173, so the tour doubles as an end-to-end test.
 */
const { chromium } = require("playwright");
const path = require("path");
const fs = require("fs");

const BASE = "http://127.0.0.1:5173";
const DRY = process.argv.includes("--dry");
const OUT = path.join(__dirname, "out");
const VIDEO_DIR = path.join(OUT, "video");

// Rehearsals sprint; the real take breathes.
const S = DRY ? 0.1 : 1;
const ms = (n) => Math.max(DRY ? 20 : 60, Math.round(n * S));

const problems = [];
let page, ctx, browser;
let stepNo = 0;
const TOTAL_CHAPTERS = 7;

const pause = (n) => page.waitForTimeout(ms(n));

const dv = async (method, ...args) => {
  try {
    await page.evaluate(
      ([m, a]) => { if (window.__dv && window.__dv[m]) window.__dv[m](...a); },
      [method, args],
    );
  } catch { /* overlay missing mid-navigation is harmless */ }
};

/** Runs a scene, records the failure and keeps going instead of aborting the take. */
async function step(name, fn) {
  stepNo += 1;
  try {
    await fn();
    if (DRY) console.log(`  ok   ${name}`);
  } catch (e) {
    problems.push({ step: name, error: String(e).split("\n")[0].slice(0, 220) });
    console.log(`  FAIL ${name}\n       ${String(e).split("\n")[0].slice(0, 200)}`);
  }
}

async function settle(timeout = 25000) {
  await page.waitForLoadState("networkidle", { timeout }).catch(() => {});
}

async function go(pathname) {
  // Drop the previous screen's caption before navigating. The overlay restores
  // its last state on load, so leaving it up would describe the old page for
  // the whole of the next page's load.
  await dv("hideCaption");
  await pause(260);
  await page.goto(BASE + pathname, { waitUntil: "domcontentloaded" });
  await settle();
  await pause(400);
}

async function say(text, sub, hold = 3800) {
  await dv("caption", text, sub);
  await pause(hold);
}

async function progress(p) { await dv("progress", p); }

async function click(sel, { timeout = 15000 } = {}) {
  const el = page.locator(sel).first();
  await el.waitFor({ state: "visible", timeout });
  await el.scrollIntoViewIfNeeded();
  await pause(260);
  const box = await el.boundingBox();
  if (!box) throw new Error(`no bounding box: ${sel}`);
  await page.mouse.move(box.x + box.width / 2, box.y + box.height / 2, { steps: DRY ? 1 : 24 });
  await pause(340);
  await page.mouse.down();
  await pause(90);
  await page.mouse.up();
  await pause(320);
}

async function type(sel, text) {
  const el = page.locator(sel).first();
  await el.waitFor({ state: "visible", timeout: 15000 });
  await click(sel);
  await el.fill("");
  await el.type(text, { delay: DRY ? 0 : 55 });
  await pause(260);
}

async function pick(sel, value) {
  const el = page.locator(sel).first();
  await el.waitFor({ state: "visible", timeout: 15000 });
  await click(sel);
  await el.selectOption(value);
  await pause(320);
}

/** Draws an animated frame around an element to direct the eye. */
async function look(sel, hold = 2200) {
  const el = page.locator(sel).first();
  if (!(await el.count())) return;
  await el.scrollIntoViewIfNeeded().catch(() => {});
  await pause(200);
  const box = await el.boundingBox();
  if (!box) return;
  await dv("highlight", box.x, box.y, box.width, box.height);
  await pause(hold);
  await dv("clearHighlights");
  await pause(260);
}

async function scroll(y, duration = 1500) {
  try {
    await page.evaluate(([top, d]) => window.__dv && window.__dv.scrollTo(top, d), [y, ms(duration)]);
  } catch { /* ignore */ }
  await pause(duration + 260);
}

/** Slow pan down the page and back — reads as a deliberate camera move. */
async function tour(depth = 700) {
  await scroll(depth, 1700);
  await pause(900);
  await scroll(0, 1200);
}

async function card(cfg, during) {
  await dv("hideCaption");
  await pause(320);
  await dv("card", cfg);
  await pause(1100);
  if (during) await during();          // navigate/login hidden behind the card
  await pause(cfg.hold ?? 4200);
  await dv("hideCard");
  await pause(900);
}

async function login(roleLabel, chipEmoji, chipText) {
  await go("/login");
  await dv("chip", chipEmoji, chipText);
  await pause(700);
  // The role chips pre-fill that role's demo credentials in dev builds.
  await click(`[data-testid="role-selector"] button:has-text("${roleLabel}")`);
  await pause(600);
  await click('button[type="submit"]');
  await page.waitForURL((u) => !u.pathname.endsWith("/login"), { timeout: 30000 });
  await settle();
  await pause(900);
}

async function logout() {
  await dv("hideCaption");
  await page.evaluate(() => {
    // Deterministic sign-out between chapters; the UI path is shown once, in
    // the admin chapter, where it belongs on camera.
    localStorage.clear();
    sessionStorage.removeItem("__dv_state");
  });
  await pause(300);
}

// ─────────────────────────────────────────────────────────────────────────────

async function main() {
  fs.rmSync(VIDEO_DIR, { recursive: true, force: true });
  fs.mkdirSync(VIDEO_DIR, { recursive: true });

  browser = await chromium.launch({ headless: true, args: ["--force-device-scale-factor=1", "--hide-scrollbars"] });
  ctx = await browser.newContext({
    viewport: { width: 1920, height: 1080 },
    deviceScaleFactor: 1,
    locale: "ar",
    ...(DRY ? {} : { recordVideo: { dir: VIDEO_DIR, size: { width: 1920, height: 1080 } } }),
  });
  // Arabic UI + RTL, and the overlay on every document.
  await ctx.addInitScript(() => localStorage.setItem("sm_locale", "ar"));
  await ctx.addInitScript({ path: path.join(__dirname, "overlay.js") });

  page = await ctx.newPage();
  page.setDefaultTimeout(20000);

  const apiErrors = [];
  page.on("response", (r) => {
    if (r.url().includes("/api/") && r.status() >= 400) {
      apiErrors.push(`${r.status()} ${r.request().method()} ${new URL(r.url()).pathname}`);
    }
  });

  await page.goto(BASE + "/login", { waitUntil: "domcontentloaded" });
  await settle();

  // ══ INTRO ══════════════════════════════════════════════════════════
  await progress(0);
  await card({
    kicker: "جولة شاملة",
    emoji: "🏫",
    title: "نظام إدارة المدارس",
    subtitle: "منصّة واحدة تجمع الإدارة والشؤون المالية والتدريس وأولياء الأمور والمستودع",
    chips: ["الإدارة", "المالية", "المعلمون", "الطلاب", "أولياء الأمور", "المستودع"],
    hold: 5200,
  });

  // ══ 1 · ADMIN ══════════════════════════════════════════════════════
  await progress(1 / TOTAL_CHAPTERS);
  await card({
    kicker: "الفصل الأول",
    emoji: "⚙️",
    title: "بوابة الإدارة",
    subtitle: "إدارة المستخدمين والصفوف والمواد والعام الدراسي مع سجل تدقيق كامل",
    hold: 3800,
  });

  await step("admin · login", async () => {
    await login("مدير", "⚙️", "مدير النظام");
    await say("سجّلنا الدخول بحساب مدير النظام", "لكل دور صلاحياته الخاصة، وتُفرض على الخادم لا في الواجهة فقط", 4200);
  });

  await step("admin · dashboard", async () => {
    await say("لوحة تحكم الإدارة تعرض مؤشرات المدرسة الرئيسية", "أعداد الطلاب والمعلمين والصفوف ونسب الحضور", 4200);
    await tour(620);
  });

  await step("admin · users", async () => {
    await go("/admin/users");
    await say("شاشة المستخدمين", "إنشاء الحسابات وإسناد الأدوار وتفعيل أو تعطيل أي مستخدم", 4400);
    await tour(560);
  });

  await step("admin · classes", async () => {
    await go("/admin/classes");
    await say("الصفوف الدراسية", "كل صف مرتبط بمعلّم رئيسي وسعة استيعابية وعام دراسي", 4200);
  });

  await step("admin · subjects", async () => {
    await go("/admin/subjects");
    await say("المواد الدراسية المعتمدة في الخطة الدراسية", null, 3600);
  });

  await step("admin · academic years", async () => {
    await go("/admin/academic-years");
    await say("الأعوام والفصول الدراسية", "تحديد العام الحالي الذي تُنسب إليه كل العمليات", 3800);
  });

  await step("admin · audit", async () => {
    await go("/admin/audit");
    await say("سجل التدقيق", "يوثّق كل عملية حساسة: من نفّذها ومتى ومن أي جهاز", 4400);
    await tour(520);
  });

  await step("admin · settings", async () => {
    await go("/admin/settings");
    await say("إعدادات المدرسة والهوية البصرية", "الاسم والشعار والألوان تنعكس على كل البوابات", 4000);
  });

  // ══ 2 · FINANCE ════════════════════════════════════════════════════
  await progress(2 / TOTAL_CHAPTERS);
  await card({
    kicker: "الفصل الثاني",
    emoji: "💰",
    title: "بوابة المالية والمحاسبة",
    subtitle: "الفواتير والمدفوعات والمتأخرات ومسيّرات الرواتب والقيود المحاسبية",
    hold: 3800,
  }, async () => { await logout(); });

  await step("finance · login", async () => {
    await login("المالية والمحاسبة", "💰", "المالية والمحاسبة");
    await say("ننتقل إلى بوابة المالية", "نفس النظام، لكن الشاشات والصلاحيات مختلفة تماماً", 4000);
  });

  await step("finance · dashboard", async () => {
    await say("لوحة المالية", "الإيرادات المحصّلة والمبالغ المستحقة ونسب التحصيل", 4200);
    await tour(620);
  });

  await step("finance · invoices", async () => {
    await go("/finance/invoices");
    await say("الفواتير", "إصدار ومتابعة فواتير الرسوم لكل طالب مع حالة السداد", 4400);
    await tour(520);
  });

  await step("finance · payments", async () => {
    await go("/finance/payments");
    await say("سندات القبض والدفع", "تُسجَّل الدفعة هنا فتُرحَّل محاسبياً تلقائياً — لا سندات في بيانات العرض بعد", 4600);
  });

  await step("finance · outstanding", async () => {
    await go("/finance/outstanding");
    await say("المتأخرات المالية", "تقرير بالطلاب الذين عليهم رسوم غير مسددة", 4000);
  });

  await step("finance · fee structures", async () => {
    await go("/finance/fee-structures");
    await say("هياكل الرسوم", "الرسوم الدراسية والنقل والأنشطة بدورات فوترة مختلفة", 4000);
  });

  await step("finance · payroll runs", async () => {
    await go("/finance/payroll-runs");
    await say("مسيّرات الرواتب", "دورة كاملة: مسودة ← معالجة ← اعتماد ← صرف", 4400);
  });

  await step("finance · chart of accounts", async () => {
    await go("/accounting/chart-of-accounts");
    await say("شجرة الحسابات المحاسبية", "أساس كل القيود: الأصول والالتزامات والإيرادات والمصروفات", 4200);
  });

  await step("finance · journal entries", async () => {
    await go("/accounting/journal-entries");
    await say("القيود اليومية", "تُنشأ تلقائياً من عمليات المالية بقيود متوازنة", 4200);
  });

  // ══ 3 · TEACHER ════════════════════════════════════════════════════
  await progress(3 / TOTAL_CHAPTERS);
  await card({
    kicker: "الفصل الثالث",
    emoji: "📖",
    title: "بوابة المعلم",
    subtitle: "الصفوف والجدول وتسجيل الحضور ورصد الدرجات والواجبات والسلوك",
    hold: 3800,
  }, async () => { await logout(); });

  await step("teacher · login", async () => {
    await login("معلم", "📖", "المعلم");
    await say("بوابة المعلم", "تعرض صفوفه وحصصه ومهامه اليومية فقط", 4000);
  });

  await step("teacher · dashboard", async () => {
    await tour(600);
  });

  await step("teacher · classes", async () => {
    await go("/teacher/classes");
    await say("صفوف المعلم والمواد المسندة إليه", null, 3800);
  });

  await step("teacher · timetable", async () => {
    await go("/teacher/timetable");
    await say("الجدول الأسبوعي للحصص", "موزّع على أيام الأسبوع مع أرقام القاعات", 4000);
  });

  await step("teacher · attendance (real action)", async () => {
    await go("/teacher/attendance");
    await say("تسجيل الحضور والغياب", "نختار الصف أولاً ثم نرصد حالة كل طالب", 4200);
    await click('[class*="cursor-pointer"]:has-text("Grade 5")');
    await settle();
    await pause(900);
    await say("بضغطة واحدة نعلّم جميع الطلاب حاضرين", "ثم نعدّل الاستثناءات يدوياً قبل الحفظ", 3800);
    await click('button:has-text("الكل حاضر")');
    await pause(900);
    await click('button:has-text("حفظ")');
    await settle();
    await pause(1400);
    await say("تم حفظ الحضور وترحيله مباشرة إلى سجل الطالب وولي الأمر", null, 4000);
  });

  await step("teacher · grades", async () => {
    await go("/teacher/grades");
    await say("رصد الدرجات", "اختبارات وواجبات بأوزان محددة تُجمع في المعدل النهائي", 4200);
  });

  await step("teacher · assignments", async () => {
    await go("/teacher/assignments");
    await say("الواجبات وتسليمات الطلاب", null, 3800);
  });

  await step("teacher · conduct", async () => {
    await go("/teacher/conduct");
    await say("سجل السلوك", "ملاحظات إيجابية وتنبيهات تصل إلى ولي الأمر", 4000);
  });

  // ══ 4 · STUDENT ════════════════════════════════════════════════════
  await progress(4 / TOTAL_CHAPTERS);
  await card({
    kicker: "الفصل الرابع",
    emoji: "🎓",
    title: "بوابة الطالب",
    subtitle: "الجدول والواجبات والدرجات والحضور والإعلانات والمكتبة",
    hold: 3800,
  }, async () => { await logout(); });

  await step("student · login", async () => {
    await login("طالب", "🎓", "الطالب");
    await say("بوابة الطالب", "واجهة مبسّطة تعرض ما يخصّ الطالب وحده", 4000);
    await tour(600);
  });

  await step("student · timetable", async () => {
    await go("/student/timetable");
    await say("جدول الحصص الأسبوعي", null, 3600);
  });

  await step("student · assignments", async () => {
    await go("/student/assignments");
    await say("الواجبات المطلوبة ومواعيد تسليمها", null, 3800);
  });

  await step("student · grades", async () => {
    await go("/student/grades");
    await say("الدرجات", "تفصيل درجات كل مادة حسب مكوّنات التقييم", 4000);
  });

  await step("student · attendance", async () => {
    await go("/student/attendance");
    await say("سجل الحضور والغياب", "ويشمل ما سجّله المعلم قبل قليل", 4000);
  });

  await step("student · announcements", async () => {
    await go("/student/announcements");
    await say("إعلانات المدرسة", null, 3400);
  });

  await step("student · library", async () => {
    await go("/student/library");
    await say("المكتبة المدرسية وإعارة الكتب", "تصفّح الكتب ومتابعة الإعارات — لم تُضَف كتب إلى بيانات العرض بعد", 4400);
  });

  // ══ 5 · PARENT ═════════════════════════════════════════════════════
  await progress(5 / TOTAL_CHAPTERS);
  await card({
    kicker: "الفصل الخامس",
    emoji: "👨‍👩‍👧",
    title: "بوابة ولي الأمر",
    subtitle: "متابعة الأبناء دراسياً ومالياً من مكان واحد",
    hold: 3800,
  }, async () => { await logout(); });

  await step("parent · login", async () => {
    await login("ولي أمر", "👨‍👩‍👧", "ولي الأمر");
    await say("بوابة ولي الأمر", "يتابع جميع أبنائه من حساب واحد", 4000);
    await tour(560);
  });

  await step("parent · children", async () => {
    await go("/parent/children");
    await say("قائمة الأبناء المرتبطين بالحساب", null, 3800);
  });

  await step("parent · grades", async () => {
    await go("/parent/grades");
    await say("درجات الأبناء", null, 3600);
  });

  await step("parent · attendance", async () => {
    await go("/parent/attendance");
    await say("سجل حضور الأبناء", "يظهر فيه ما رصده المعلم مباشرة", 4000);
  });

  await step("parent · invoices", async () => {
    await go("/parent/invoices");
    await say("الفواتير والمدفوعات", "نفس الفواتير التي أصدرتها إدارة المالية", 4200);
  });

  // ══ 6 · WAREHOUSE ══════════════════════════════════════════════════
  await progress(6 / TOTAL_CHAPTERS);
  await card({
    kicker: "الفصل السادس",
    emoji: "📦",
    title: "بوابة المستودع",
    subtitle: "الأصناف والتصنيفات وحركات المخزون وطلبات الشراء",
    hold: 3800,
  }, async () => { await logout(); });

  await step("warehouse · login", async () => {
    await login("المستودع", "📦", "أمين المستودع");
    await say("بوابة المستودع", "سنبني الآن دورة مخزنية كاملة من الصفر أمامك", 4200);
  });

  await step("warehouse · create category (real action)", async () => {
    await go("/warehouse/categories");
    await say("الخطوة الأولى: إنشاء تصنيف للمخزون", null, 3600);
    await click('button:has-text("إضافة تصنيف")');
    await pause(700);
    await type('[role="dialog"] input >> nth=0', "قرطاسية ومستلزمات مكتبية");
    await type('[role="dialog"] input >> nth=1', "أوراق وأقلام ومواد مكتبية");
    await click('button:has-text("حفظ التصنيف")');
    await settle();
    await pause(1400);
    await say("تم إنشاء التصنيف وظهر مباشرة في القائمة", null, 3600);
  });

  await step("warehouse · create item (real action)", async () => {
    await go("/warehouse/items");
    await say("الخطوة الثانية: إضافة صنف داخل التصنيف", "يبدأ رصيده من صفر ويتغيّر بالحركات فقط", 4200);
    await click('button:has-text("إضافة صنف")');
    await pause(700);
    await type('[role="dialog"] input >> nth=0', "ورق طباعة A4");
    await pick('[role="dialog"] select', { label: "قرطاسية ومستلزمات مكتبية" });
    await type('[role="dialog"] input >> nth=2', "رزمة");
    await type('[role="dialog"] input[type="number"]', "20");
    await click('button:has-text("حفظ الصنف")');
    await settle();
    await pause(1400);
    await say("أُضيف الصنف برصيد صفر وحدّ أدنى ٢٠ رزمة", null, 3800);
  });

  await step("warehouse · stock movement (real action)", async () => {
    await say("الخطوة الثالثة: تسجيل حركة إدخال للمخزون", null, 3600);
    await click('button[title="تسجيل حركة"]');
    await pause(800);
    await type('[role="dialog"] input[type="number"]', "150");
    await type('[role="dialog"] input >> nth=1', "PO-2026-118");
    await type('[role="dialog"] input >> nth=2', "توريد بداية الفصل الدراسي");
    await click('button:has-text("تسجيل")');
    await settle();
    await pause(1600);
    await say("ارتفع الرصيد إلى ١٥٠ رزمة وتغيّرت حالة الصنف تلقائياً", "من «نفد المخزون» إلى «متوفر»", 4600);
    await tour(420);
  });

  await step("warehouse · movements", async () => {
    await go("/warehouse/movements");
    await say("سجل حركات المخزون", "كل حركة موثّقة بالكمية والمرجع والمستخدم والتاريخ", 4400);
  });

  await step("warehouse · reports", async () => {
    await go("/warehouse/reports");
    await say("تقارير المستودع", "قيمة المخزون والأصناف التي تحتاج إعادة طلب", 4200);
  });

  await step("warehouse · purchase requests", async () => {
    await go("/warehouse/purchase-requests");
    await say("طلبات الشراء", "تُرفع من المستودع إلى المشتريات ثم إلى المالية", 4200);
  });

  // ══ OUTRO ══════════════════════════════════════════════════════════
  await progress(1);
  await dv("hideChip");
  await card({
    kicker: "انتهت الجولة",
    emoji: "✅",
    title: "منظومة واحدة مترابطة",
    subtitle: "ما يسجّله المعلم يظهر للطالب ولولي أمره، وما تصدره المالية ينعكس في المحاسبة والمستودع",
    chips: ["٦ بوابات", "صلاحيات دقيقة", "سجل تدقيق", "تقارير فورية"],
    hold: 6000,
  });

  await pause(1200);

  // ── wrap up ──
  const videoPath = DRY ? null : await page.video().path();
  await ctx.close();
  await browser.close();

  fs.writeFileSync(path.join(OUT, "problems.json"), JSON.stringify({ problems, apiErrors }, null, 2));

  console.log("\n──────── summary ────────");
  console.log(`steps run   : ${stepNo}`);
  console.log(`failed steps: ${problems.length}`);
  problems.forEach((p) => console.log(`   • ${p.step} → ${p.error}`));
  const uniqueApi = [...new Set(apiErrors)];
  console.log(`API >=400   : ${uniqueApi.length}`);
  uniqueApi.forEach((e) => console.log(`   • ${e}`));
  if (videoPath) console.log(`\nvideo: ${videoPath}`);
}

main().catch(async (e) => {
  console.error("FATAL", e);
  try { await ctx?.close(); await browser?.close(); } catch { /* ignore */ }
  process.exit(1);
});
