import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Turns the OS screenshot and screen-recording block on and off.
///
/// An interface rather than a direct channel call: `FLAG_SECURE` is an Android
/// platform call that does not exist in a widget test, and a screen whose
/// protection cannot be tested is a screen whose protection quietly stops
/// working.
abstract interface class ScreenCaptureGuard {
  /// Blocks screenshots, screen recording and thumbnails in the task switcher.
  Future<void> block();

  /// Restores the default. Called when the last protected screen leaves, so a
  /// parent can still screenshot their child's timetable.
  Future<void> allow();
}

/// The real guard, over a method channel Android implements with FLAG_SECURE.
///
/// iOS has no equivalent flag; the channel simply answers nothing there, which
/// is the honest outcome rather than a false sense of protection.
class PlatformScreenCaptureGuard implements ScreenCaptureGuard {
  const PlatformScreenCaptureGuard();

  static const MethodChannel _channel =
      MethodChannel('jo.schoolsuite.mobile/secure_screen');

  @override
  Future<void> block() => _set(true);

  @override
  Future<void> allow() => _set(false);

  Future<void> _set(bool secure) async {
    try {
      await _channel.invokeMethod<void>('setSecure', secure);
    } on MissingPluginException {
      // A host that does not implement it. Nothing to do, and nothing worth
      // crashing a family's fee screen over.
    } on PlatformException {
      // Same reasoning: the screen is still usable, and the caller is told by
      // the absence of protection rather than by a crash.
    }
  }
}

/// Counts how many protected screens are on screen at once.
///
/// A stack matters: opening an invoice from the fee list means two protected
/// screens are mounted, and the first one to be popped must not un-protect the
/// one still showing. Only the last one out restores the default.
class ScreenCaptureController {
  ScreenCaptureController({required this.guard});

  final ScreenCaptureGuard guard;

  int _depth = 0;

  /// How many protected screens are currently mounted.
  @visibleForTesting
  int get depth => _depth;

  Future<void> enter() async {
    _depth++;
    if (_depth == 1) await guard.block();
  }

  Future<void> leave() async {
    if (_depth == 0) return;

    _depth--;
    if (_depth == 0) await guard.allow();
  }
}

/// Wraps a screen that must not be screenshotted, recorded or thumbnailed.
///
/// Applied to the screens that put a family's money or a child's record on
/// display: fees, an invoice, a receipt, published marks, attendance, a class
/// roster with guardians' phone numbers. Not applied to a timetable or an
/// announcement, which a parent has every reason to screenshot and send on.
///
/// The protection is per-screen rather than per-app on purpose. Blocking the
/// whole app would stop a parent photographing a notice for their partner, and
/// people who cannot do the ordinary thing find a way around the protection
/// entirely.
class SecureScreen extends StatefulWidget {
  const SecureScreen({
    required this.controller,
    required this.child,
    super.key,
  });

  final ScreenCaptureController controller;
  final Widget child;

  @override
  State<SecureScreen> createState() => _SecureScreenState();
}

class _SecureScreenState extends State<SecureScreen> {
  @override
  void initState() {
    super.initState();
    widget.controller.enter();
  }

  @override
  void dispose() {
    widget.controller.leave();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
