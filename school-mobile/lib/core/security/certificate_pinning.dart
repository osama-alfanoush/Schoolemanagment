import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

/// Decides whether a server certificate is one this build will talk to.
///
/// ## Why SPKI, not the certificate
///
/// The pin is a SHA-256 of the certificate's **subject public key info**, not
/// of the certificate itself. A certificate is renewed every ninety days on a
/// modern issuer; the key underneath it usually is not. Pinning the
/// certificate would brick every installed app on the first renewal, which is
/// the failure mode that makes people abandon pinning altogether.
///
/// ## The rotation plan
///
/// Two pins are configured at all times: the key in use, and the key that will
/// replace it. Rotation is therefore:
///
/// 1. Generate the next key pair and publish its pin in an app release,
///    **alongside** the current one. Both are accepted.
/// 2. Wait until that release is the floor — `mobile.min_supported_version`
///    already forces an upgrade, so this step has a mechanism and a deadline
///    rather than a hope.
/// 3. Switch the server to the new key. Installed apps keep working, because
///    they have been accepting that pin since step 1.
/// 4. In the following release, drop the retired pin and add the next one.
///
/// A build that skips step 1 and ships a single pin cannot rotate without
/// bricking installs, which is why [CertificatePinner.fromPins] refuses a
/// single-pin configuration in release mode.
///
/// ## When there are no pins
///
/// An empty pin list means "not pinned", and every certificate the platform
/// itself trusts is accepted. That is the honest default for a build with no
/// production certificate yet: pinning against a placeholder would either
/// accept everything anyway or refuse everything, and both are worse than
/// saying plainly that pinning is off.
@immutable
class CertificatePinner {
  const CertificatePinner._(this.pins);

  /// Builds a pinner, refusing a configuration that cannot be rotated.
  ///
  /// [allowSinglePin] exists for tests and for a deliberate, documented
  /// exception; it is never set in a shipped build.
  factory CertificatePinner.fromPins(
    List<String> pins, {
    bool isRelease = kReleaseMode,
    bool allowSinglePin = false,
  }) {
    final normalised = pins
        .map((pin) => pin.trim())
        .where((pin) => pin.isNotEmpty)
        .toList(growable: false);

    if (isRelease && normalised.length == 1 && !allowSinglePin) {
      throw const SinglePinConfiguration();
    }

    return CertificatePinner._(normalised);
  }

  /// The accepted SPKI hashes, base64, as `sha256/AAAA...` without the prefix.
  final List<String> pins;

  /// True when this build pins at all.
  bool get isPinned => pins.isNotEmpty;

  /// Whether a certificate whose SPKI hashes to [spkiSha256Base64] is accepted.
  bool acceptsSpki(String spkiSha256Base64) =>
      !isPinned || pins.contains(spkiSha256Base64.trim());

  /// Hashes a DER-encoded subject public key info into a pin.
  static String pinOf(List<int> derSubjectPublicKeyInfo) =>
      base64.encode(sha256.convert(derSubjectPublicKeyInfo).bytes);
}

/// A pinned build that ships one pin cannot rotate its key without bricking
/// every installed app. Refused at construction rather than discovered on the
/// day the certificate is replaced.
class SinglePinConfiguration implements Exception {
  const SinglePinConfiguration();

  @override
  String toString() => 'SinglePinConfiguration: a pinned release must carry '
      'the current pin and its planned replacement, so the key can be rotated '
      'without bricking installed apps.';
}
