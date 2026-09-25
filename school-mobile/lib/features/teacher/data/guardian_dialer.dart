import 'package:url_launcher/url_launcher.dart';

/// Starts a phone call to a guardian.
///
/// An interface rather than a direct `url_launcher` call because launching an
/// intent is a platform channel, which does not exist in a widget test. Every
/// screen that offers "call the guardian" would otherwise be untestable, and
/// the branch that matters most — the launcher refusing, on a tablet with no
/// SIM — would never be exercised.
abstract interface class GuardianDialer {
  /// Returns false when the device cannot place the call.
  ///
  /// False is a real answer, not an error: a school tablet has no dialer, and
  /// the screen has to say so rather than appear to do nothing.
  Future<bool> call(String phone);
}

/// The real dialer.
class PhoneDialer implements GuardianDialer {
  const PhoneDialer();

  @override
  Future<bool> call(String phone) async {
    // Whitespace and the separators people type into a school record would
    // otherwise produce a URI the platform rejects.
    final digits = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    if (digits.isEmpty) return false;

    try {
      return await launchUrl(Uri(scheme: 'tel', path: digits));
    } on Exception {
      // A platform that has no handler throws rather than returning false.
      return false;
    }
  }
}
