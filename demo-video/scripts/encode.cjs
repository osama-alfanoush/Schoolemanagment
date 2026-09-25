/* Transcodes the Playwright VP8/WebM capture into a shareable H.264 MP4. */
const { execFileSync } = require("child_process");
const fs = require("fs");
const path = require("path");

const FFMPEG = path.join(__dirname, "..", "ffmpeg-dl", "node_modules", "ffmpeg-static", "ffmpeg.exe");
const VIDEO_DIR = path.join(__dirname, "out", "video");
const DEST_DIR = process.argv[2] || path.join(__dirname, "out");
const NAME = "School-Management-Suite-Walkthrough-AR";

const clips = fs.readdirSync(VIDEO_DIR).filter((f) => f.endsWith(".webm"))
  .map((f) => path.join(VIDEO_DIR, f))
  .sort((a, b) => fs.statSync(a).mtimeMs - fs.statSync(b).mtimeMs);

if (!clips.length) {
  console.error("no .webm capture found in", VIDEO_DIR);
  process.exit(1);
}
console.log("source clips:");
clips.forEach((c) => console.log(`  ${path.basename(c)}  ${(fs.statSync(c).size / 1e6).toFixed(1)} MB`));

fs.mkdirSync(DEST_DIR, { recursive: true });
const out = path.join(DEST_DIR, `${NAME}.mp4`);

const args = [];
if (clips.length === 1) {
  args.push("-i", clips[0]);
} else {
  const list = path.join(VIDEO_DIR, "concat.txt");
  fs.writeFileSync(list, clips.map((c) => `file '${c.replace(/\\/g, "/")}'`).join("\n"));
  args.push("-f", "concat", "-safe", "0", "-i", list);
}

args.push(
  "-c:v", "libx264",
  "-preset", "slow",
  "-crf", "20",
  "-pix_fmt", "yuv420p",     // required for QuickTime / PowerPoint / phones
  "-r", "30",
  "-fps_mode", "cfr",        // Playwright's capture is variable-rate
  "-vf", "scale=1920:1080:flags=lanczos",
  "-movflags", "+faststart", // starts playing before the whole file downloads
  "-an",
  "-y", out,
);

console.log("\nencoding …");
execFileSync(FFMPEG, args, { stdio: ["ignore", "ignore", "inherit"] });

// `ffmpeg -i <file>` with no output always exits non-zero; it is a probe, not a failure.
let probe = "";
try {
  execFileSync(FFMPEG, ["-hide_banner", "-i", out], { stdio: ["ignore", "pipe", "pipe"] });
} catch (e) {
  probe = String(e.stderr || "");
}
const duration = (probe.match(/Duration: (\d+:\d+:\d+\.\d+)/) || [])[1] || "unknown";
console.log(`\nwrote ${out}`);
console.log(`length ${duration}`);
console.log(`size  ${(fs.statSync(out).size / 1e6).toFixed(1)} MB`);
