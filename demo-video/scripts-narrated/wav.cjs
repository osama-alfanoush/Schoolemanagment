/*
 * Minimal WAV read/mix helpers.
 *
 * The narration is assembled by copying each clip's PCM into a silent track at
 * the exact millisecond the caption appeared on screen. Doing it on raw samples
 * keeps the voice frame-accurate against the recording, which chaining ffmpeg
 * adelay/amix filters over ~60 inputs would not.
 */
const fs = require("fs");

/** Reads a PCM WAV and returns its format plus the raw sample bytes. */
function readWav(file) {
  const buf = fs.readFileSync(file);
  if (buf.toString("ascii", 0, 4) !== "RIFF" || buf.toString("ascii", 8, 12) !== "WAVE") {
    throw new Error(`not a RIFF/WAVE file: ${file}`);
  }

  let offset = 12;
  let fmt = null;
  let data = null;
  while (offset + 8 <= buf.length) {
    const id = buf.toString("ascii", offset, offset + 4);
    const size = buf.readUInt32LE(offset + 4);
    const body = offset + 8;
    if (id === "fmt ") {
      fmt = {
        channels: buf.readUInt16LE(body + 2),
        sampleRate: buf.readUInt32LE(body + 4),
        bitsPerSample: buf.readUInt16LE(body + 14),
      };
    } else if (id === "data") {
      data = buf.subarray(body, Math.min(body + size, buf.length));
    }
    offset = body + size + (size % 2); // chunks are word-aligned
  }
  if (!fmt || !data) throw new Error(`missing fmt/data chunk: ${file}`);

  const blockAlign = (fmt.bitsPerSample / 8) * fmt.channels;
  return { ...fmt, blockAlign, data, durationMs: (data.length / blockAlign / fmt.sampleRate) * 1000 };
}

/** Duration only — used while pacing the scenes. */
function durationMs(file) {
  return readWav(file).durationMs;
}

/**
 * Places each clip at its recorded offset on a silent track.
 * clips: [{ file, atMs }]
 */
function buildTrack(clips, totalMs, outFile) {
  if (!clips.length) throw new Error("no clips to place");
  const first = readWav(clips[0].file);
  const { sampleRate, channels, bitsPerSample, blockAlign } = first;

  const totalFrames = Math.ceil((totalMs / 1000) * sampleRate);
  const pcm = Buffer.alloc(totalFrames * blockAlign); // silence

  for (const clip of clips) {
    const wav = readWav(clip.file);
    if (wav.sampleRate !== sampleRate || wav.channels !== channels) {
      throw new Error(`format mismatch in ${clip.file}`);
    }
    const startByte = Math.round((clip.atMs / 1000) * sampleRate) * blockAlign;
    if (startByte >= pcm.length) continue;
    const copyLength = Math.min(wav.data.length, pcm.length - startByte);
    wav.data.copy(pcm, startByte, 0, copyLength);
  }

  const header = Buffer.alloc(44);
  header.write("RIFF", 0, "ascii");
  header.writeUInt32LE(36 + pcm.length, 4);
  header.write("WAVE", 8, "ascii");
  header.write("fmt ", 12, "ascii");
  header.writeUInt32LE(16, 16);
  header.writeUInt16LE(1, 20);                                   // PCM
  header.writeUInt16LE(channels, 22);
  header.writeUInt32LE(sampleRate, 24);
  header.writeUInt32LE(sampleRate * blockAlign, 28);
  header.writeUInt16LE(blockAlign, 32);
  header.writeUInt16LE(bitsPerSample, 34);
  header.write("data", 36, "ascii");
  header.writeUInt32LE(pcm.length, 40);

  fs.writeFileSync(outFile, Buffer.concat([header, pcm]));
  return { outFile, totalMs, clips: clips.length };
}

module.exports = { readWav, durationMs, buildTrack };
