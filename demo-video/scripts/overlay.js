/*
 * Presentation layer injected into every document of the demo recording.
 * Draws the Arabic caption bar, chapter cards, role chip, progress bar,
 * a visible cursor and click ripples — all on top of the real application,
 * so nothing here changes how the app itself behaves.
 *
 * State is mirrored into sessionStorage so a full page navigation restores
 * the caption/chip/progress instantly instead of flashing an empty bar.
 */
(() => {
  if (window.__dv) return;

  const NS = "__dv_state";
  const read = () => {
    try { return JSON.parse(sessionStorage.getItem(NS) || "{}"); } catch { return {}; }
  };
  const write = (patch) => {
    const next = { ...read(), ...patch };
    try { sessionStorage.setItem(NS, JSON.stringify(next)); } catch { /* ignore */ }
    return next;
  };

  const FONT = '"Segoe UI", "Tahoma", "Arial", sans-serif';

  const style = document.createElement("style");
  style.textContent = `
  #dv-root, #dv-root * { box-sizing: border-box; }
  #dv-root {
    position: fixed; inset: 0; z-index: 2147483600; pointer-events: none;
    font-family: ${FONT}; -webkit-font-smoothing: antialiased;
  }

  /* ── top progress ── */
  #dv-progress {
    position: absolute; top: 0; left: 0; right: 0; height: 4px;
    background: rgba(15,23,42,.18);
  }
  #dv-progress > i {
    display: block; height: 100%; width: 0%;
    background: linear-gradient(90deg, #6366f1, #8b5cf6 45%, #d4a12e);
    box-shadow: 0 0 12px rgba(139,92,246,.7);
    transition: width .7s cubic-bezier(.4,0,.2,1);
  }

  /* ── role chip (top-right, RTL) ── */
  #dv-chip {
    position: absolute; top: 20px; right: 26px;
    display: flex; align-items: center; gap: 10px; direction: rtl;
    padding: 9px 18px 9px 14px; border-radius: 999px;
    background: rgba(17,24,39,.86); backdrop-filter: blur(14px);
    border: 1px solid rgba(255,255,255,.14);
    box-shadow: 0 10px 34px rgba(0,0,0,.32);
    color: #fff; font-size: 16px; font-weight: 600; letter-spacing: .1px;
    opacity: 0; transform: translateY(-14px) scale(.96);
    transition: opacity .45s ease, transform .45s cubic-bezier(.34,1.56,.64,1);
  }
  #dv-chip.on { opacity: 1; transform: none; }
  #dv-chip .dot {
    width: 9px; height: 9px; border-radius: 50%; background: #34d399;
    box-shadow: 0 0 0 0 rgba(52,211,153,.75); animation: dv-pulse 2s infinite;
  }
  @keyframes dv-pulse {
    0%   { box-shadow: 0 0 0 0 rgba(52,211,153,.7); }
    70%  { box-shadow: 0 0 0 11px rgba(52,211,153,0); }
    100% { box-shadow: 0 0 0 0 rgba(52,211,153,0); }
  }
  #dv-chip .emo { font-size: 19px; }

  /* ── caption (bottom) ── */
  #dv-cap {
    position: absolute; bottom: 46px; left: 50%; transform: translate(-50%, 26px);
    max-width: min(1180px, 84vw); direction: rtl; text-align: right;
    padding: 20px 26px 20px 26px; border-radius: 20px;
    background: linear-gradient(135deg, rgba(15,23,42,.93), rgba(30,27,75,.93));
    backdrop-filter: blur(18px) saturate(140%);
    border: 1px solid rgba(255,255,255,.13);
    box-shadow: 0 26px 70px rgba(0,0,0,.45);
    opacity: 0; transition: opacity .5s ease, transform .55s cubic-bezier(.22,1,.36,1);
  }
  #dv-cap.on { opacity: 1; transform: translate(-50%, 0); }
  #dv-cap::before {
    content: ""; position: absolute; top: 18px; bottom: 18px; right: 0;
    width: 5px; border-radius: 999px;
    background: linear-gradient(180deg, #8b5cf6, #d4a12e);
  }
  #dv-cap .t {
    color: #fff; font-size: 30px; font-weight: 700; line-height: 1.62;
    margin: 0; padding-right: 18px;
  }
  #dv-cap .s {
    color: rgba(226,232,240,.82); font-size: 19px; font-weight: 500;
    line-height: 1.6; margin: 9px 0 0; padding-right: 18px;
  }

  /* ── full-screen chapter card ── */
  #dv-card {
    position: absolute; inset: 0; display: flex; flex-direction: column;
    align-items: center; justify-content: center; gap: 4px; direction: rtl;
    background: radial-gradient(1200px 700px at 22% 18%, #312e81 0%, transparent 60%),
                radial-gradient(1000px 640px at 82% 82%, #4c1d95 0%, transparent 58%),
                linear-gradient(140deg, #0b1120 0%, #14163a 52%, #1e1b4b 100%);
    opacity: 0; visibility: hidden; transition: opacity .75s ease, visibility .75s;
  }
  #dv-card.on { opacity: 1; visibility: visible; }
  #dv-card .blob {
    position: absolute; border-radius: 50%; filter: blur(70px); opacity: .5;
    animation: dv-float 13s ease-in-out infinite;
  }
  @keyframes dv-float {
    0%,100% { transform: translate(0,0) scale(1); }
    50%     { transform: translate(46px,-40px) scale(1.16); }
  }
  #dv-card .grid {
    position: absolute; inset: 0; opacity: .16;
    background-image: linear-gradient(rgba(255,255,255,.09) 1px, transparent 1px),
                      linear-gradient(90deg, rgba(255,255,255,.09) 1px, transparent 1px);
    background-size: 62px 62px;
    mask-image: radial-gradient(circle at 50% 50%, #000 12%, transparent 74%);
  }
  #dv-card .inner { position: relative; text-align: center; padding: 0 60px; }
  #dv-card .kicker {
    color: #c4b5fd; font-size: 22px; font-weight: 700; letter-spacing: 5px;
    margin-bottom: 22px; opacity: 0; animation: dv-up .8s .1s forwards;
  }
  #dv-card .emo {
    font-size: 92px; line-height: 1; margin-bottom: 20px;
    opacity: 0; animation: dv-pop .9s .22s forwards;
  }
  #dv-card .title {
    color: #fff; font-size: 82px; font-weight: 800; line-height: 1.22; margin: 0;
    text-shadow: 0 8px 40px rgba(0,0,0,.5);
    opacity: 0; animation: dv-up .9s .34s forwards;
  }
  #dv-card .rule {
    height: 5px; width: 0; margin: 30px auto 26px; border-radius: 999px;
    background: linear-gradient(90deg, #8b5cf6, #d4a12e);
    animation: dv-rule .95s .62s forwards;
  }
  #dv-card .sub {
    color: rgba(226,232,240,.9); font-size: 31px; font-weight: 500; line-height: 1.6;
    margin: 0 auto; max-width: 1000px;
    opacity: 0; animation: dv-up .9s .74s forwards;
  }
  #dv-card .chips {
    display: flex; gap: 14px; justify-content: center; flex-wrap: wrap; margin-top: 38px;
    opacity: 0; animation: dv-up .9s .92s forwards;
  }
  #dv-card .chips span {
    padding: 11px 22px; border-radius: 999px; color: #e9d5ff; font-size: 21px; font-weight: 600;
    background: rgba(139,92,246,.17); border: 1px solid rgba(167,139,250,.34);
  }
  @keyframes dv-up  { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: none; } }
  @keyframes dv-pop { from { opacity: 0; transform: scale(.55); } to { opacity: 1; transform: none; } }
  @keyframes dv-rule { to { width: 190px; } }

  /* ── cursor + ripples ── */
  #dv-cursor {
    position: absolute; width: 26px; height: 26px; margin: -13px 0 0 -13px;
    border-radius: 50%; border: 2.5px solid rgba(139,92,246,.95);
    background: rgba(139,92,246,.22); box-shadow: 0 0 18px rgba(139,92,246,.65);
    opacity: 0; transition: opacity .3s ease; will-change: transform;
  }
  #dv-cursor.on { opacity: 1; }
  .dv-rip {
    position: absolute; width: 22px; height: 22px; margin: -11px 0 0 -11px;
    border-radius: 50%; border: 3px solid rgba(212,161,46,.95);
    animation: dv-rip .75s cubic-bezier(.22,1,.36,1) forwards;
  }
  @keyframes dv-rip {
    to { transform: scale(4.6); opacity: 0; border-width: 1px; }
  }

  /* ── element highlight ── */
  .dv-hl {
    position: absolute; border-radius: 16px; border: 3px solid rgba(139,92,246,.95);
    box-shadow: 0 0 0 6px rgba(139,92,246,.18), 0 0 34px rgba(139,92,246,.6);
    opacity: 0; transition: opacity .4s ease, transform .5s cubic-bezier(.22,1,.36,1);
    transform: scale(1.035);
  }
  .dv-hl.on { opacity: 1; transform: scale(1); }
  `;

  const mount = () => {
    if (document.getElementById("dv-root")) return;
    document.documentElement.appendChild(style);

    const root = document.createElement("div");
    root.id = "dv-root";
    root.innerHTML = `
      <div id="dv-progress"><i></i></div>
      <div id="dv-chip"><span class="dot"></span><span class="emo"></span><span class="txt"></span></div>
      <div id="dv-cap"><p class="t"></p><p class="s"></p></div>
      <div id="dv-card">
        <div class="grid"></div>
        <div class="blob" style="width:520px;height:520px;background:#7c3aed;top:6%;left:8%"></div>
        <div class="blob" style="width:460px;height:460px;background:#d4a12e;bottom:8%;right:10%;animation-delay:-6s"></div>
        <div class="inner">
          <div class="kicker"></div>
          <div class="emo"></div>
          <h1 class="title"></h1>
          <div class="rule"></div>
          <p class="sub"></p>
          <div class="chips"></div>
        </div>
      </div>
      <div id="dv-cursor"></div>
    `;
    document.documentElement.appendChild(root);

    const $ = (s) => root.querySelector(s);
    const cursor = $("#dv-cursor");

    // The real Playwright mouse drives the drawn cursor.
    document.addEventListener("mousemove", (e) => {
      cursor.classList.add("on");
      cursor.style.transform = `translate(${e.clientX}px, ${e.clientY}px)`;
    }, true);

    document.addEventListener("mousedown", (e) => {
      const r = document.createElement("div");
      r.className = "dv-rip";
      r.style.transform = `translate(${e.clientX}px, ${e.clientY}px)`;
      r.style.left = "0"; r.style.top = "0";
      root.appendChild(r);
      setTimeout(() => r.remove(), 800);
    }, true);

    // ── public API ────────────────────────────────────────────────
    window.__dv = {
      caption(text, sub) {
        const cap = $("#dv-cap");
        cap.querySelector(".t").textContent = text || "";
        const s = cap.querySelector(".s");
        s.textContent = sub || "";
        s.style.display = sub ? "" : "none";
        cap.classList.add("on");
        write({ cap: { text, sub } });
      },
      hideCaption() {
        $("#dv-cap").classList.remove("on");
        write({ cap: null });
      },
      chip(emoji, text) {
        const c = $("#dv-chip");
        c.querySelector(".emo").textContent = emoji || "";
        c.querySelector(".txt").textContent = text || "";
        c.classList.add("on");
        write({ chip: { emoji, text } });
      },
      hideChip() {
        $("#dv-chip").classList.remove("on");
        write({ chip: null });
      },
      progress(p) {
        $("#dv-progress > i").style.width = `${Math.max(0, Math.min(1, p)) * 100}%`;
        write({ prog: p });
      },
      card({ kicker = "", emoji = "", title = "", subtitle = "", chips = [] } = {}) {
        const c = $("#dv-card");
        c.querySelector(".kicker").textContent = kicker;
        c.querySelector(".emo").textContent = emoji;
        c.querySelector(".title").textContent = title;
        c.querySelector(".sub").textContent = subtitle;
        c.querySelector(".chips").innerHTML = chips.map((x) => `<span>${x}</span>`).join("");
        // Re-trigger the entry animations on every show.
        c.querySelectorAll(".kicker,.emo,.title,.rule,.sub,.chips").forEach((el) => {
          const a = el.style.animation;
          el.style.animation = "none";
          void el.offsetWidth;
          el.style.animation = a || "";
        });
        c.classList.add("on");
      },
      hideCard() { $("#dv-card").classList.remove("on"); },
      highlight(x, y, w, h) {
        const el = document.createElement("div");
        el.className = "dv-hl";
        Object.assign(el.style, { left: `${x - 8}px`, top: `${y - 8}px`, width: `${w + 16}px`, height: `${h + 16}px` });
        root.appendChild(el);
        requestAnimationFrame(() => el.classList.add("on"));
        return (window.__dvHl = el), true;
      },
      clearHighlights() {
        root.querySelectorAll(".dv-hl").forEach((el) => {
          el.classList.remove("on");
          setTimeout(() => el.remove(), 420);
        });
      },
      /** Cinematic eased scroll — nicer on camera than instant jumps. */
      scrollTo(top, ms = 1400) {
        return new Promise((resolve) => {
          const start = window.scrollY;
          const delta = top - start;
          const t0 = performance.now();
          const ease = (t) => (t < .5 ? 4 * t * t * t : 1 - Math.pow(-2 * t + 2, 3) / 2);
          const step = (now) => {
            const t = Math.min(1, (now - t0) / ms);
            window.scrollTo(0, start + delta * ease(t));
            t < 1 ? requestAnimationFrame(step) : resolve();
          };
          requestAnimationFrame(step);
        });
      },
    };

    // Restore state after a navigation so nothing flickers.
    const st = read();
    if (st.chip) window.__dv.chip(st.chip.emoji, st.chip.text);
    if (st.cap) window.__dv.caption(st.cap.text, st.cap.sub);
    if (typeof st.prog === "number") window.__dv.progress(st.prog);
  };

  if (document.documentElement) mount();
  else document.addEventListener("DOMContentLoaded", mount);
})();
