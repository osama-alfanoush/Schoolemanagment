import 'package:local_auth/local_auth.dart';

/// What the OS said about an unlock attempt.
enum UnlockOutcome {
  /// The user proved they are the person holding the phone.
  succeeded,

  /// They tried and did not match. Trying again may work.
  failed,

  /// They dismissed the prompt.
  cancelled,

  /// This device cannot do it at all: no enrolled biometric, no screen lock,
  /// or the hardware is missing. The app-lock cannot be offered here.
  unavailable,

  /// Too many failures; the OS has locked the prompt out for now.
  temporarilyLockedOut,
}

/// The OS unlock prompt, behind an interface.
///
/// An interface rather than a direct `local_auth` call so the lock's rules —
/// when it engages, what a failure means — can be tested without a fingerprint
/// reader. The production implementation is the only thing here that touches a
/// platform channel.
abstract class BiometricGate {
  /// Whether this device can present a prompt at all.
  Future<bool> isAvailable();

  /// Prompts, with [reason] shown by the OS. The reason is passed in because
  /// only the UI layer knows the user's language.
  Future<UnlockOutcome> unlock({required String reason});
}

/// [BiometricGate] over `local_auth`.
class LocalAuthGate implements BiometricGate {
  LocalAuthGate({LocalAuthentication? auth})
      : _auth = auth ?? LocalAuthentication();

  final LocalAuthentication _auth;

  @override
  Future<bool> isAvailable() async {
    try {
      // `isDeviceSupported` is true when the device can check a biometric *or*
      // fall back to the screen-lock credential, so a phone with a PIN but no
      // fingerprint still counts. Requiring a biometric specifically would
      // strand those users with no lock at all.
      return await _auth.isDeviceSupported();
    } on LocalAuthException {
      return false;
    }
  }

  @override
  Future<UnlockOutcome> unlock({required String reason}) async {
    try {
      final ok = await _auth.authenticate(
        localizedReason: reason,
        // The device PIN or pattern is an acceptable second way in: it is the
        // same secret that protects the lock screen. Biometric-only would
        // strand anyone whose sensor stops recognising a wet thumb.
        biometricOnly: false,
        sensitiveTransaction: true,
        // The prompt survives the app going to the background, so an incoming
        // call does not read as a failed unlock.
        persistAcrossBackgrounding: true,
      );

      return ok ? UnlockOutcome.succeeded : UnlockOutcome.failed;
    } on LocalAuthException catch (error) {
      return switch (error.code) {
        LocalAuthExceptionCode.noCredentialsSet ||
        LocalAuthExceptionCode.noBiometricsEnrolled ||
        LocalAuthExceptionCode.noBiometricHardware ||
        LocalAuthExceptionCode.biometricHardwareTemporarilyUnavailable =>
          UnlockOutcome.unavailable,
        LocalAuthExceptionCode.temporaryLockout ||
        LocalAuthExceptionCode.biometricLockout =>
          UnlockOutcome.temporarilyLockedOut,
        LocalAuthExceptionCode.userCanceled ||
        LocalAuthExceptionCode.systemCanceled ||
        LocalAuthExceptionCode.timeout ||
        LocalAuthExceptionCode.authInProgress ||
        LocalAuthExceptionCode.uiUnavailable ||
        LocalAuthExceptionCode.userRequestedFallback =>
          UnlockOutcome.cancelled,
        // Anything else is a device or platform fault. It is reported as a
        // failure, never as a success: an unrecognised error code must not be
        // a way into the app.
        _ => UnlockOutcome.failed,
      };
    }
  }
}
