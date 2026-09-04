import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/api/api.dart';
import 'core/auth/secure_store.dart';
import 'core/auth/secure_token_store.dart';
import 'core/auth/session_wipe.dart';
import 'core/db/database_key_provider.dart';
import 'core/i18n/i18n.dart';
import 'core/router/router.dart';
import 'core/session/session.dart';
import 'core/theme/theme.dart';
import 'features/auth/auth.dart';

/// Where the API lives. Injected at build time; there is no default and no
/// host anywhere in the source.
const String apiBaseUrl = String.fromEnvironment('API_BASE_URL');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Date symbols for every locale we ship; without this `ar` dates throw.
  await initializeDateFormatting();
  runApp(const SchoolSuiteApp());
}

class SchoolSuiteApp extends StatefulWidget {
  const SchoolSuiteApp({
    super.key,
    this.secureStore,
    this.httpClientAdapter,
    this.baseUrl,
  });

  /// Credential storage. Defaults to the platform keystore.
  ///
  /// Injectable so the app can be launched end to end in a widget test: the
  /// real store speaks over a platform channel that no test host provides, and
  /// an app that can only be run on a device is an app whose startup path is
  /// never tested.
  final SecureStore? secureStore;

  /// Transport. Defaults to a real socket.
  final HttpClientAdapter? httpClientAdapter;

  /// Overrides [apiBaseUrl]. Only tests pass this.
  final String? baseUrl;

  @override
  State<SchoolSuiteApp> createState() => _SchoolSuiteAppState();
}

class _SchoolSuiteAppState extends State<SchoolSuiteApp> {
  /// User preference. Western is the default; the toggle on the verification
  /// screen switches it and every number on screen follows.
  DigitShape _digitShape = DigitShape.western;

  /// Build version the upgrade gate compares against `min_supported_version`.
  /// Kept as a define so a release build states its own version rather than
  /// inheriting whatever was hard-coded last.
  static const String _appVersion =
      String.fromEnvironment('APP_VERSION', defaultValue: '0.1.0');

  late final SecureStore _secureStore;
  late final SecureTokenStore _tokenStore;
  late final SessionWipe _sessionWipe;
  late final ApiClient _apiClient;
  late final AuthRepository _auth;
  late final LoginController _loginController;
  late final SessionController _session;
  late final GoRouter _router;
  StreamSubscription<void>? _unauthenticated;

  @override
  void initState() {
    super.initState();

    _secureStore = widget.secureStore ?? FlutterSecureStore();
    _tokenStore = SecureTokenStore(store: _secureStore);
    _sessionWipe = SessionWipe(
      tokenStore: _tokenStore,
      databaseKeyProvider: DatabaseKeyProvider(store: _secureStore),
    );

    _session = SessionController(
      currentVersion:
          AppVersion.tryParse(_appVersion) ?? const AppVersion(0, 1, 0),
    );

    final baseUrl = widget.baseUrl ?? apiBaseUrl;
    _apiClient = ApiClient(
      // A build with no API base URL cannot work. Pointing at a reserved
      // hostname makes every call fail as a connection error rather than
      // silently succeeding against nothing.
      baseUrl: baseUrl.isEmpty ? 'https://invalid.invalid' : baseUrl,
      tokenStore: _tokenStore,
      adapter: widget.httpClientAdapter,
    );

    _auth = AuthRepository(
      api: AuthApi(dio: _apiClient.dio, tokenStore: _tokenStore),
      tokenStore: _tokenStore,
      controller: _session,
    );
    _loginController = LoginController(repository: _auth);

    // A refresh that cannot be recovered ends the session everywhere at once:
    // the store is wiped and the router falls back to the sign-in screen.
    _unauthenticated = _sessionWipe.bindTo(_apiClient.onUnauthenticated);
    _apiClient.onUnauthenticated.listen((_) => _session.signedOut());

    _router = buildAppRouter(
      controller: _session,
      screens: const AppScreens().withScreens(<AppRoute, RouteScreenBuilder>{
        AppRoute.signIn: (context, state) =>
            LoginScreen(controller: _loginController),
        // Interim home for the on-device verification screen, so the checks it
        // performs stay reachable once a session exists. The profile orders
        // replace these three entries; nothing under lib/core/ changes when
        // they do.
        AppRoute.parentProfile: _verificationScreen,
        AppRoute.teacherProfile: _verificationScreen,
        AppRoute.studentProfile: _verificationScreen,
      }),
    );

    // Reads the token store and, if a session is still good, restores it.
    // Until this completes the router holds at the splash rather than showing
    // a login screen to someone who is already signed in.
    unawaited(_auth.restore());
  }

  @override
  void dispose() {
    unawaited(_unauthenticated?.cancel());
    _router.dispose();
    _loginController.dispose();
    _session.dispose();
    unawaited(_apiClient.close());
    super.dispose();
  }

  Widget _verificationScreen(BuildContext context, GoRouterState state) =>
      VerificationScreen(onToggleDigitShape: _toggleDigitShape);

  void _toggleDigitShape() {
    setState(() {
      _digitShape = _digitShape == DigitShape.western
          ? DigitShape.arabicIndic
          : DigitShape.western;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      supportedLocales: AppLocales.supported,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      // Anything that is not a language we ship resolves to Arabic.
      localeResolutionCallback: AppLocales.resolve,
      routerConfig: _router,
      builder: (context, child) {
        final locale = Localizations.localeOf(context);
        return AppI18nScope(
          formats: AppFormats(
            locale: locale.languageCode,
            digitShape: _digitShape,
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}

/// Proves on a real device that theming, localization, money and dates are all
/// wired up: every value below is produced by the layers those orders built.
///
/// Reachable from the profile tab once a session exists. It grants nothing and
/// reads nothing from the server.
class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key, this.onToggleDigitShape});

  final VoidCallback? onToggleDigitShape;

  /// 12500 fils = 12.500 JOD. A three-decimal currency, shown with three.
  static const Money sampleAmount = Money.jod(12500);

  /// Fixed so the screen renders the same on every run.
  static final DateTime sampleDate = DateTime(2026, 9, 3);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final formats = AppI18nScope.of(context);
    final locale = Localizations.localeOf(context);
    final direction = Directionality.of(context);

    final flavor = appFlavor ?? l10n.notConfigured;
    final baseUrl = apiBaseUrl.isEmpty ? l10n.notConfigured : apiBaseUrl;
    final digitShapeName = formats.digitShape == DigitShape.western
        ? l10n.digitShapeWestern
        : l10n.digitShapeArabicIndic;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: SafeArea(
        // Scrollable so the content still fits when text is scaled to 200%.
        child: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                l10n.appTitle,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),
              _VerificationValue(label: l10n.activeFlavor, value: flavor),
              _VerificationValue(label: l10n.apiBaseUrl, value: baseUrl),
              _VerificationValue(
                label: l10n.currentLocale,
                value: locale.languageCode,
              ),
              _VerificationValue(
                label: l10n.textDirection,
                value: direction == TextDirection.rtl ? 'RTL' : 'LTR',
              ),
              _VerificationValue(
                key: const Key('verification-amount'),
                label: l10n.sampleAmount,
                value: formats.money(sampleAmount),
              ),
              _VerificationValue(
                key: const Key('verification-date'),
                label: l10n.sampleDate,
                value: formats.date(sampleDate),
              ),
              _VerificationValue(
                key: const Key('verification-digit-shape'),
                label: l10n.digitShape,
                value: digitShapeName,
              ),
              const SizedBox(height: 24),
              FilledButton(
                key: const Key('toggle-digit-shape'),
                onPressed: onToggleDigitShape,
                child: Text(l10n.digitShape),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A labelled value, stacked rather than laid out in a row so that neither
/// half is squeezed when the text scale grows.
class _VerificationValue extends StatelessWidget {
  const _VerificationValue({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            textAlign: TextAlign.start,
            style: theme.textTheme.labelMedium,
          ),
          Text(
            value,
            textAlign: TextAlign.start,
            style: theme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
