/*
 * Records the narrated deep-dive into the Warehouse, HR and Finance modules.
 *
 *   node record.cjs --dry   rehearsal: no video, sprint pacing, reports failures
 *   node record.cjs         full take -> out/video/*.webm + out/cues.json
 *
 * Each scene shows its Arabic caption, logs the moment it appeared, then runs
 * its actions while the voice-over plays. The audio track is assembled after
 * the fact from those timestamps (see mux.cjs), which keeps the narration
 * frame-accurate without needing audio inside the browser.
 */
const { chromium } = require("playwright");
const path = require("path");
const fs = require("fs");
const { durationMs } = require("./wav.cjs");
const SCRIPT = require("./script.cjs");

const BASE = "http://127.0.0.1:5173";
const DRY = process.argv.includes("--dry");
const OUT = path.join(__dirname, "out");
const VIDEO_DIR = path.join(OUT, "video");
const AUDIO_DIR = path.join(__dirname, "audio");

const TAIL_MS = 700;              // breath after each line
const S = DRY ? 0.4 : 1;
const ms = (n) => Math.max(DRY ? 150 : 50, Math.round(n * S));

const THEMES = {
  warehouse: ["#d97706", "#f59e0b"],
  hr: ["#0d9488", "#22d3ee"],
  finance: ["#4f46e5", "#a78bfa"],
};

const lines = Object.fromEntries(SCRIPT.ALL.map((l) => [l.id, l]));
const audioMs = {};
for (const l of SCRIPT.ALL) {
  const file = path.join(AUDIO_DIR, `${l.id}.wav`);
  audioMs[l.id] = fs.existsSync(file) ? durationMs(file) : 4000;
}

const problems = [];
const cues = [];
let page, ctx, browser, t0 = 0;

const pause = (n) => page.waitForTimeout(ms(n));

const dv = async (method, ...args) => {
  try {
    await page.evaluate(([m, a]) => { if (window.__dv?.[m]) window.__dv[m](...a); }, [method, args]);
  } catch { /* overlay is absent for a moment during navigation */ }
};

async function step(name, fn) {
  try {
    await fn();
    if (DRY) console.log(`  ok   ${name}`);
  } catch (e) {
    problems.push({ step: name, error: String(e).split("\n")[0].slice(0, 200) });
    console.log(`  FAIL ${name}\n       ${String(e).split("\n")[0].slice(0, 190)}`);
  }
}

const settle = (timeout = 25000) => page.waitForLoadState("networkidle", { timeout }).catch(() => {});

async function go(pathname) {
  await dv("hideCaption");
  await pause(240);
  await page.goto(BASE + pathname, { waitUntil: "domcontentloaded" });
  await settle();
  await pause(350);
}

/** Shows the caption, marks the voice-over cue, runs the actions, then waits out the line. */
async function narrate(id, action) {
  const line = lines[id];
  if (!line) throw new Error(`unknown narration id: ${id}`);
  await dv("caption", line.cap || line.say, line.sub);
  cues.push({ id, atMs: Date.now() - t0 });
  const startedAt = Date.now();
  if (action) await action();
  const remaining = (DRY ? 0 : audioMs[id] + TAIL_MS) - (Date.now() - startedAt);
  if (remaining > 0) await page.waitForTimeout(remaining);
}

async function click(sel, { timeout = 15000 } = {}) {
  const el = page.locator(sel).first();
  await el.waitFor({ state: "visible", timeout });
  await el.scrollIntoViewIfNeeded();
  await pause(220);
  const box = await el.boundingBox();
  if (!box) throw new Error(`no bounding box: ${sel}`);
  await page.mouse.move(box.x + box.width / 2, box.y + box.height / 2, { steps: DRY ? 1 : 22 });
  await pause(280);
  await page.mouse.down();
  await pause(80);
  await page.mouse.up();
  await pause(280);
}

async function type(sel, text) {
  const el = page.locator(sel).first();
  await el.waitFor({ state: "visible", timeout: 15000 });
  await click(sel);
  await el.fill("");
  await el.type(text, { delay: DRY ? 8 : 45 });
  await pause(200);
}

async function pick(sel, value) {
  const el = page.locator(sel).first();
  await el.waitFor({ state: "visible", timeout: 15000 });
  await click(sel);
  await el.selectOption(value);
  await pause(260);
}

async function look(sel, hold = 1800) {
  const el = page.locator(sel).first();
  if (!(await el.count())) return;
  await el.scrollIntoViewIfNeeded().catch(() => {});
  const box = await el.boundingBox();
  if (!box) return;
  await dv("highlight", box.x, box.y, box.width, box.height);
  await pause(hold);
  await dv("clearHighlights");
}

async function scroll(y, duration = 1400) {
  try {
    await page.evaluate(([top, d]) => window.__dv?.scrollTo(top, d), [y, ms(duration)]);
  } catch { /* ignore */ }
  await pause(duration + 200);
}

const tour = async (depth = 620) => { await scroll(depth, 1600); await pause(700); await scroll(0, 1200); };

async function card(cfg, during) {
  await dv("hideCaption");
  await pause(280);
  await dv("card", cfg);
  await pause(900);
  if (during) await during();
  await pause(cfg.hold ?? 3600);
  await dv("hideCard");
  await pause(800);
}

async function login(roleLabel, emoji, chipText) {
  await go("/login");
  await dv("chip", emoji, chipText);
  await pause(600);
  await click(`[data-testid="role-selector"] button:has-text("${roleLabel}")`);
  await pause(500);
  await click('button[type="submit"]');
  await page.waitForURL((u) => !u.pathname.endsWith("/login"), { timeout: 30000 });
  await settle();
  await pause(700);
}

/** Types credentials directly — used for accounts the role chips do not fill. */
async function loginWith(email, emoji, chipText) {
  await go("/login");
  await dv("chip", emoji, chipText);
  await pause(500);
  await type("#login-email", email);
  await type("#login-password", "password");
  await click('button[type="submit"]');
  await page.waitForURL((u) => !u.pathname.endsWith("/login"), { timeout: 30000 });
  await settle();
  await pause(700);
}

async function logout() {
  await dv("hideCaption");
  await page.evaluate(() => { localStorage.clear(); sessionStorage.removeItem("__dv_state"); });
  await pause(250);
}

const dialog = '[role="dialog"]';

/**
 * Clicks a row action by its label. DataTable renders up to two actions inline
 * (as buttons carrying a `title`) and collapses three or more into an overflow
 * menu, so the label alone is not always on the page until the menu is opened.
 */
async function rowAction(label, { row = 0 } = {}) {
  // Wait for the row itself first: right after a mutation the table is
  // re-fetching, and probing for the button before it exists would wrongly
  // conclude the action had been collapsed into the menu.
  await page.locator("tbody tr").nth(row).waitFor({ state: "visible", timeout: 20000 });

  const inline = page.locator(`tbody button[title="${label}"]`).first();
  try {
    await inline.waitFor({ state: "visible", timeout: 3000 });
    return await click(`tbody button[title="${label}"]`);
  } catch { /* three or more actions — it lives in the overflow menu */ }

  const overflow = page.locator("tbody tr").nth(row).locator("button").last();
  await overflow.waitFor({ state: "visible", timeout: 15000 });
  const box = await overflow.boundingBox();
  await page.mouse.move(box.x + box.width / 2, box.y + box.height / 2, { steps: DRY ? 1 : 18 });
  await pause(260);
  await overflow.click();
  await pause(500);
  // Scope to the open menu; the label may also exist elsewhere on the page.
  await click(`[class*="z-50"] button:has-text("${label}")`);
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
  await ctx.addInitScript(() => localStorage.setItem("sm_locale", "ar"));
  await ctx.addInitScript({ path: path.join(__dirname, "overlay.js") });

  page = await ctx.newPage();
  page.setDefaultTimeout(20000);
  t0 = Date.now();

  const apiErrors = [];
  page.on("response", (r) => {
    if (r.url().includes("/api/") && r.status() >= 400) {
      apiErrors.push(`${r.status()} ${r.request().method()} ${new URL(r.url()).pathname}`);
    }
  });

  await page.goto(`${BASE}/login`, { waitUntil: "domcontentloaded" });
  await settle();

  // ══ INTRO ═══════════════════════════════════════════════════════════
  await dv("progress", 0);
  await dv("theme", "#6366f1", "#d4a12e");
  await dv("card", {
    kicker: "شرح تفصيلي",
    emoji: "🏫",
    title: "نظام إدارة المدارس",
    subtitle: "ثلاث بوابات كاملة: المستودع، الموارد البشرية، المالية والمحاسبة",
    chips: ["المستودع", "الموارد البشرية", "المالية والمحاسبة"],
  });
  await pause(900);
  await narrate("card-intro");
  await dv("hideCard");
  await pause(700);

  // ══ 1 · WAREHOUSE ═══════════════════════════════════════════════════
  await dv("progress", 0.02);
  await dv("theme", ...THEMES.warehouse);
  await card({ kicker: "الفصل الأول", emoji: "📦", title: "بوابة المستودع",
    subtitle: "التصنيفات والأصناف وحركات المخزون والجرد وطلبات الشراء والتقارير", hold: 3200 });

  await step("wh · login", async () => {
    await narrate("wh-01");
    await login("المستودع", "📦", "أمين المستودع");
    await narrate("wh-02", async () => { await look("aside", 2200); });
  });

  await step("wh · dashboard", async () => {
    await narrate("wh-03", async () => { await tour(560); });
  });

  await step("wh · categories", async () => {
    await go("/warehouse/categories");
    await narrate("wh-04");
    await narrate("wh-05", async () => {
      await click('button:has-text("إضافة تصنيف")');
      await pause(500);
      await type(`${dialog} input >> nth=0`, "قرطاسية ومستلزمات مكتبية");
      await type(`${dialog} input >> nth=1`, "أوراق وأقلام ومواد مكتبية");
      await click(`${dialog} button:has-text("حفظ التصنيف")`);
      await settle();
    });
    await narrate("wh-06", async () => { await look("table", 2000); });
  });

  await step("wh · items", async () => {
    await go("/warehouse/items");
    await narrate("wh-07");
    await narrate("wh-08", async () => {
      await click('button:has-text("إضافة صنف")');
      await pause(500);
      await type(`${dialog} input >> nth=0`, "ورق طباعة A4");
      await pick(`${dialog} select`, { label: "قرطاسية ومستلزمات مكتبية" });
      await type(`${dialog} input >> nth=2`, "رزمة");
      await type(`${dialog} input[type="number"]`, "20");
    });
    await narrate("wh-09", async () => {
      await look(`${dialog} input >> nth=1`, 2200);
      await click(`${dialog} button:has-text("حفظ الصنف")`);
      await settle();
    });
    await narrate("wh-10", async () => { await look("table", 2400); });
  });

  await step("wh · stock in", async () => {
    await narrate("wh-11", async () => {
      await rowAction("تسجيل حركة");
      await pause(600);
      await type(`${dialog} input[type="number"]`, "150");
      await type(`${dialog} input >> nth=1`, "PO-2026-118");
      await type(`${dialog} input >> nth=2`, "توريد بداية الفصل الدراسي");
      await click(`${dialog} button:has-text("تسجيل")`);
      await settle();
    });
    await narrate("wh-12", async () => { await look("table", 2600); });
  });

  await step("wh · stock out", async () => {
    await narrate("wh-13", async () => {
      await rowAction("تسجيل حركة");
      await pause(600);
      await pick(`${dialog} select`, "out");
      await type(`${dialog} input[type="number"]`, "40");
      await type(`${dialog} input >> nth=2`, "صرف لقسم الإدارة");
      await click(`${dialog} button:has-text("تسجيل")`);
      await settle();
      await pause(700);
    });
  });

  await step("wh · movements", async () => {
    await go("/warehouse/movements");
    await narrate("wh-14", async () => { await look("table", 3000); });
  });

  await step("wh · counts", async () => {
    await go("/warehouse/inventory-counts");
    await narrate("wh-15");
  });

  await step("wh · purchase requests", async () => {
    await go("/warehouse/purchase-requests");
    await narrate("wh-16");
  });

  await step("wh · reports", async () => {
    await go("/warehouse/reports");
    await narrate("wh-17", async () => { await tour(420); });
  });

  // ══ 2 · HR ══════════════════════════════════════════════════════════
  await dv("progress", 0.34);
  await dv("theme", ...THEMES.hr);
  await card({ kicker: "الفصل الثاني", emoji: "👥", title: "بوابة الموارد البشرية",
    subtitle: "الموظفون والعقود والسلف وإعدادات الرواتب والإجازات والتقييم والتوظيف", hold: 3200 },
    async () => { await logout(); });

  await step("hr · login", async () => {
    await narrate("hr-01");
    await login("الموارد البشرية", "👥", "الموارد البشرية");
    await narrate("hr-02", async () => { await tour(520); });
  });

  await step("hr · staff", async () => {
    await go("/hr/staff");
    await narrate("hr-03", async () => { await look("table", 2400); });
    await narrate("hr-04", async () => {
      await click('button:has-text("عرض الملف")').catch(() => {});
      await pause(900);
      await click(`${dialog} button:has-text("الوظيفة والعقد")`).catch(() => {});
      await pause(1200);
      await click(`${dialog} button:has-text("الضمان الاجتماعي")`).catch(() => {});
      await pause(1200);
      await click(`${dialog} button:has-text("إغلاق")`).catch(() => {});
    });
  });

  await step("hr · contracts", async () => {
    await go("/hr/contracts");
    await narrate("hr-05", async () => { await look("table", 2200); });
  });

  await step("hr · warnings", async () => {
    await go("/hr/warnings");
    await narrate("hr-06");
  });

  await step("hr · advances", async () => {
    await go("/hr/advances");
    await narrate("hr-07");
    await narrate("hr-08", async () => {
      await click('button:has-text("طلب سلفة")');
      await pause(600);
      await pick(`${dialog} select`, { index: 1 });
      await type(`${dialog} input[type="number"] >> nth=0`, "1000");
      await type(`${dialog} input[type="number"] >> nth=1`, "3");
      await type(`${dialog} textarea`, "ظرف عائلي طارئ");
      await click(`${dialog} button:has-text("حفظ المسودة")`);
      await settle();
    });
    await narrate("hr-09", async () => {
      await look("table", 2400);
      // HR may raise and submit an advance but not approve or disburse it —
      // the schedule is built on disbursement, which happens in Finance.
      await rowAction("إرسال").catch(() => {});
      await settle();
      await pause(900);
    });
  });

  await step("hr · payroll settings", async () => {
    await go("/hr/payroll-settings");
    await narrate("hr-10", async () => { await tour(420); });
  });

  await step("hr · leave", async () => {
    await go("/hr/leave");
    await narrate("hr-11");
  });

  await step("hr · attendance", async () => {
    await go("/hr/attendance");
    await narrate("hr-12", async () => {
      await click('button:has-text("حفظ الحضور")').catch(() => {});
      await settle();
    });
  });

  await step("hr · evaluations", async () => {
    await go("/hr/evaluations");
    await narrate("hr-13", async () => { await tour(380); });
  });

  await step("hr · recruitment", async () => {
    await go("/hr/recruitment");
    await narrate("hr-14", async () => { await tour(380); });
  });

  await step("hr · requests", async () => {
    await go("/hr/requests");
    await narrate("hr-15");
  });

  // ══ 3 · FINANCE ═════════════════════════════════════════════════════
  await dv("progress", 0.66);
  await dv("theme", ...THEMES.finance);
  await card({ kicker: "الفصل الثالث", emoji: "💰", title: "بوابة المالية والمحاسبة",
    subtitle: "الرسوم والفواتير والتحصيل والأقساط والرواتب والقيود والإقفال", hold: 3200 },
    async () => { await logout(); });

  await step("fi · login", async () => {
    await narrate("fi-01");
    await login("المالية والمحاسبة", "💰", "المالية والمحاسبة");
    await narrate("fi-02", async () => { await tour(560); });
  });

  await step("fi · fee structures", async () => {
    await go("/finance/fee-structures");
    await narrate("fi-03", async () => { await look("table", 2600); });
  });

  await step("fi · invoices", async () => {
    await go("/finance/invoices");
    await narrate("fi-04", async () => { await look("table", 2800); });
    await narrate("fi-05", async () => {
      await click('button:has-text("إصدار دفعة فواتير")').catch(() => {});
      await pause(1500);
      await click(`${dialog} button:has-text("إلغاء")`).catch(() => {});
    });
    await narrate("fi-06", async () => {
      await rowAction("تسجيل دفعة").catch(() => {});
      await pause(700);
      await type(`${dialog} input#amt`, "200").catch(() => {});
      await pause(600);
    });
    await narrate("fi-07", async () => {
      await click(`${dialog} button:has-text("تسجيل")`).catch(() => {});
      await settle();
      await look("table", 2200);
    });
  });

  await step("fi · outstanding", async () => {
    await go("/finance/outstanding");
    await narrate("fi-08", async () => { await look("table", 2400); });
  });

  await step("fi · student file", async () => {
    await go("/finance/students");
    await narrate("fi-09");
  });

  await step("fi · adjustments", async () => {
    await go("/finance/adjustments");
    await narrate("fi-10");
  });

  await step("fi · approve and disburse the HR advance", async () => {
    await go("/finance/hr-advances");
    await narrate("fi-10b", async () => {
      await rowAction("اعتماد").catch(() => {});
      await settle();
      await pause(1100);
      await rowAction("صرف").catch(() => {});
      await settle();
      await pause(1200);
      await rowAction("الأقساط").catch(() => {});
      await pause(2600);
      await click(`${dialog} button:has-text("إغلاق")`).catch(() => {});
    });
  });

  await step("fi · installments", async () => {
    await go("/finance/installments");
    await narrate("fi-11", async () => { await tour(380); });
  });

  await step("fi · payroll runs", async () => {
    await go("/finance/payroll-runs");
    await narrate("fi-12", async () => { await look("table", 2400); });
    await narrate("fi-12b", async () => {
      await click('button:has-text("دورة جديدة")');
      await pause(700);
      await click(`${dialog} button:has-text("إنشاء مسودة")`);
      await settle();
      await pause(600);
    });
    await narrate("fi-13", async () => {
      await rowAction("معالجة").catch(() => {});
      await settle();
      await pause(1200);
      await look("table", 2000);
    });
    // The server refuses approval by whoever drafted the run, so the demo shows
    // the refusal and then switches to a second finance account to continue.
    await narrate("fi-13b", async () => {
      await rowAction("اعتماد").catch(() => {});
      await settle();
      await pause(2600);
    });
    await narrate("fi-13c", async () => {
      await logout();
      await loginWith("accounting@school.test", "💰", "المحاسبة");
      await go("/finance/payroll-runs");
      await rowAction("اعتماد");
      await settle();
      await pause(1400);
      await rowAction("دفع");
      await settle();
      await pause(900);
    });
    await narrate("fi-14", async () => {
      await rowAction("فتح").catch(() => {});
      await pause(1800);
      await scroll(300, 1200);
    });
    await narrate("fi-15", async () => {
      await pause(1500);
      await click(`${dialog} button:has-text("إغلاق")`).catch(() => {});
    });
  });

  await step("fi · chart of accounts", async () => {
    await go("/accounting/chart-of-accounts");
    await narrate("fi-16", async () => { await look("table", 2600); });
  });

  await step("fi · journal entries", async () => {
    await go("/accounting/journal-entries");
    await narrate("fi-17", async () => { await look("table", 2600); });
    await narrate("fi-18");
  });

  await step("fi · budget", async () => {
    await go("/accounting/budget");
    await narrate("fi-19");
  });

  await step("fi · closings", async () => {
    await go("/accounting/closings");
    await narrate("fi-20");
  });

  await step("fi · reports", async () => {
    await go("/accounting/reports");
    await narrate("fi-21", async () => { await tour(400); });
  });

  await step("fi · audit trail", async () => {
    await go("/accounting/audit");
    await narrate("fi-22", async () => { await look("table", 2600); });
  });

  // ══ OUTRO ═══════════════════════════════════════════════════════════
  await dv("progress", 1);
  await dv("hideChip");
  await dv("theme", "#6366f1", "#d4a12e");
  await dv("card", {
    kicker: "انتهت الجولة",
    emoji: "✅",
    title: "ثلاث بوابات مترابطة",
    subtitle: "سلفة تُصرف في الموارد البشرية تُستقطع في الرواتب وتظهر قيداً في المحاسبة",
    chips: ["المستودع", "الموارد البشرية", "المالية والمحاسبة"],
  });
  await pause(900);
  await narrate("card-outro");
  await pause(1200);

  const videoPath = DRY ? null : await page.video().path();
  const totalMs = Date.now() - t0;
  await ctx.close();
  await browser.close();

  fs.mkdirSync(OUT, { recursive: true });
  fs.writeFileSync(path.join(OUT, "cues.json"), JSON.stringify({ totalMs, cues, problems, apiErrors }, null, 2));

  console.log("\n──────── summary ────────");
  console.log(`narrated lines : ${cues.length} / ${SCRIPT.ALL.length}`);
  console.log(`failed steps   : ${problems.length}`);
  problems.forEach((p) => console.log(`   • ${p.step} → ${p.error}`));
  const uniq = [...new Set(apiErrors)];
  console.log(`API >=400      : ${uniq.length}`);
  uniq.forEach((e) => console.log(`   • ${e}`));
  console.log(`duration       : ${(totalMs / 60000).toFixed(1)} min`);
  if (videoPath) console.log(`video          : ${videoPath}`);
}

main().catch(async (e) => {
  console.error("FATAL", e);
  try { await ctx?.close(); await browser?.close(); } catch { /* ignore */ }
  process.exit(1);
});
