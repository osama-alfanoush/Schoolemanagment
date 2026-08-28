/*
 * Lays the narration onto the capture and encodes the final MP4.
 *
 *   node mux.cjs [destDir]
 *
 * Each voice clip is copied into a silent track at the millisecond its caption
 * appeared during recording (cues.json), then muxed with the video.
 */
const { execFileSync } = require("child_process");
const fs = require("fs");
const path = require("path");
const { buildTrack, readWav } = require("./wav.cjs");

const FFMPEG = path.join(__dirname, "..", "ffmpeg-dl", "node_modules", "ffmpeg-static", "ffmpeg.exe");
const OUT = path.join(__dirname, "out");
const VIDEO_DIR = path.join(OUT, "video");
const AUDIO_DIR = path.join(__dirname, "audio");
const DEST = process.argv[2] || OUT;
const NAME = "School-Suite-Warehouse-HR-Finance-AR";

function probeDurationMs(file) {
  let stderr = "";
  try {
    execFileSync(FFMPEG, ["-hide_banner", "-i", file], { stdio: ["ignore", "pipe", "pipe"] });
  } catch (e) {
    stderr = String(e.stderr || "");
  }
  const m = stderr.match(/Duration: (\d+):(\d+):(\d+\.\d+)/);
  if (!m) throw new Error(`could not read duration of ${file}`);
  return ((+m[1]) * 3600 + (+m[2]) * 60 + parseFloat(m[3])) * 1000;
}

const clips = fs.readdirSync(VIDEO_DIR).filter((f) => f.endsWith(".webm"));
if (clips.length !== 1) throw new Error(`expected exactly one capture, found ${clips.length}`);
const video = path.join(VIDEO_DIR, clips[0]);

const { cues } = JSON.parse(fs.readFileSync(path.join(OUT, "cues.json"), "utf8"));
const videoMs = probeDurationMs(video);
console.log(`capture : ${(videoMs / 60000).toFixed(1)} min`);
console.log(`cues    : ${cues.length}`);

// Playwright's capture starts a moment before the script's own clock, so the
// audio would otherwise run slightly ahead of the picture.
const OFFSET_MS = Number(process.env.AUDIO_OFFSET_MS ?? 350);

const placed = cues
  .map((c) => ({ file: path.join(AUDIO_DIR, `${c.id}.wav`), atMs: c.atMs + OFFSET_MS, id: c.id }))
  .filter((c) => {
    if (fs.existsSync(c.file)) return true;
    console.warn(`  ! missing audio for ${c.id}`);
    return false;
  });

// Warn if a line would still be talking over the next one.
for (let i = 0; i < placed.length - 1; i++) {
  const end = placed[i].atMs + readWav(placed[i].file).durationMs;
  if (end > placed[i + 1].atMs + 250) {
    console.warn(`  ! ${placed[i].id} overruns ${placed[i + 1].id} by ${Math.round(end - placed[i + 1].atMs)}ms`);
  }
}

const narration = path.join(OUT, "narration.wav");
buildTrack(placed, videoMs + 1500, narration);
console.log(`track   : ${(fs.statSync(narration).size / 1e6).toFixed(1)} MB`);

fs.mkdirSync(DEST, { recursive: true });
const out = path.join(DEST, `${NAME}.mp4`);

console.log("encoding …");
execFileSync(FFMPEG, [
  "-i", video,
  "-i", narration,
  "-c:v", "libx264",
  "-preset", "slow",
  "-crf", "20",
  "-pix_fmt", "yuv420p",
  "-r", "30",
  "-fps_mode", "cfr",
  "-vf", "scale=1920:1080:flags=lanczos",
  "-c:a", "aac",
  "-b:a", "160k",
  "-ac", "2",
  "-shortest",
  "-movflags", "+faststart",
  "-y", out,
], { stdio: ["ignore", "ignore", "inherit"] });

console.log(`\nwrote ${out}`);
console.log(`size  ${(fs.statSync(out).size / 1e6).toFixed(1)} MB`);
