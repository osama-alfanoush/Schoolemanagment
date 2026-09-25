import 'dart:math';
import 'dart:typed_data';

/// Cryptographically strong byte source.
final Random _secureRandom = Random.secure();

/// [length] bytes from the platform CSPRNG.
Uint8List randomBytes(int length) {
  final bytes = Uint8List(length);
  for (var i = 0; i < length; i++) {
    bytes[i] = _secureRandom.nextInt(256);
  }
  return bytes;
}

/// A random (version 4) UUID, per RFC 9562.
///
/// Deliberately derived from the CSPRNG rather than from any hardware
/// identifier: `ANDROID_ID`, the advertising id and IMEI-style values are
/// privacy liabilities, are shared across apps or reset outside our control,
/// and their semantics have changed repeatedly across Android versions.
String randomUuidV4() {
  final bytes = randomBytes(16);
  // Version 4 in the high nibble of byte 6.
  bytes[6] = (bytes[6] & 0x0f) | 0x40;
  // RFC variant (10xx) in the two high bits of byte 8.
  bytes[8] = (bytes[8] & 0x3f) | 0x80;

  final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
      '${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
}
