# Walkthrough recordings

Two Arabic-narrated recordings of the suite. Both drive the **real** app — Vite
on `:5173` against the Laravel API on `:8000` — with genuine writes along the
way, so each take doubles as an end-to-end test.

Both `.mp4` files are git-ignored: they are large binaries, and the scripts here
regenerate them.

| File | Length | What it covers |
| --- | --- | --- |
| `School-Suite-Warehouse-HR-Finance-AR.mp4` | 18:04 | **Narrated deep dive** (Arabic voice-over) into Warehouse, HR and Finance/Accounting — every screen, A to Z |
| `School-Management-Suite-Walkthrough-AR.mp4` | ~10 min | Captions-only tour across all six portals (admin, finance, teacher, student, parent, warehouse) |

## The narrated deep dive

`scripts-narrated/` builds the long one. It has an Arabic voice-over generated
offline from the Windows voice **Microsoft Naayf (ar-SA)** — no cloud service and
no audio ever leaves the machine.

Voice and picture stay in sync without playing audio in the browser: each scene
logs the millisecond its caption appeared, and `mux.cjs` copies each clip into a
silent PCM track at exactly that offset before muxing.

### What it demonstrates on camera

- **Warehouse** — category → item (auto-generated SKU) → stock-in 150 → stock-out 40, then movements, counts, purchase requests and reports
- **HR** — employee file, contracts, warnings, an advance raised with its auto-computed instalment schedule, payroll settings, leave, attendance, evaluations, recruitment, requests
- **Finance** — fee structures, invoices, a payment recorded against a real invoice, outstanding, adjustments, **the HR advance approved and disbursed** (which is when its instalment schedule is built: 333.33 / 333.33 / **333.34**, the last one absorbing the rounding), instalments, then a payroll run created → processed → **approval refused by segregation of duties** → approved and paid by a second finance account → chart of accounts, journals, budget, closings, reports and the audit trail

The journals screen at the end is the payoff: four entries, all created during the
recording. The payroll payment posts **$19,579.67** against a **$19,913.00** accrual —
exactly $333.33 less, the advance instalment raised in the HR chapter being
collected from the run. The three modules close the loop on screen.

### Regenerate

```bash
# 1. seed a database and serve the API (MFA off via env var only — no file is edited)
cd ../laravel-api
php artisan migrate:fresh --seed
MFA_ENABLED=false php artisan serve --host=127.0.0.1 --port=8000

# 2. serve the SPA — the login role chips only pre-fill demo accounts in a dev build
cd ../school-web
npm run dev -- --host 127.0.0.1 --port 5173

# 3. generate the voice-over (once, or after editing script.cjs)
cd ../demo-video/scripts-narrated
node -e "const s=require('./script.cjs');require('fs').writeFileSync('lines.json',JSON.stringify(s.ALL.map(l=>({id:l.id,text:l.say})),null,1),'utf8')"
powershell -ExecutionPolicy Bypass -File tts.ps1 -LinesJson lines.json -OutDir audio -Rate 2

# 4. the take starts from a known state, and rehearse first
cd ../../laravel-api
php artisan tinker --execute="require '../demo-video/scripts-narrated/reset.php';"
cd ../demo-video/scripts-narrated
export NODE_PATH=../../school-web/node_modules
node record.cjs --dry          # 57+ scenes, reports any broken step

# 5. reset again, record, then lay the narration on and encode
node record.cjs
node mux.cjs ..                # needs a full ffmpeg (Playwright's build is VP8-only)
```

`record.cjs` prints a summary of failed steps and any API response ≥ 400. A clean
run is `59/59 narrated, 0 failed steps`, with **one expected 422**: the payroll
approval that segregation of duties correctly refuses, which the video narrates
as a feature.

### Files

| File | Role |
| --- | --- |
| `script.cjs` | The narration — `say` (spoken), `cap`/`sub` (on-screen). Edit here to change wording. |
| `record.cjs` | Scenes, navigation and the real actions; paces each scene to its voice clip. |
| `overlay.js` | Injected caption bar, chapter cards, role chip, progress, cursor and click ripples, themed per module. |
| `tts.ps1` | Offline Arabic voice-over. Reaches the OneCore voice through SAPI's token category, since `System.Speech` cannot see it. |
| `wav.cjs` | WAV parsing and sample-accurate placement of clips on a silent track. |
| `mux.cjs` | Builds the narration track and encodes the faststart MP4. |
| `reset.php` | Returns the demo database to the state a take starts from. |
