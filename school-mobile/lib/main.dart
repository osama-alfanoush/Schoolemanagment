import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart' show LazyDatabase;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/api/api.dart';
import 'core/auth/secure_store.dart';
import 'core/auth/secure_token_store.dart';
import 'core/auth/session_wipe.dart';
import 'core/db/app_database.dart';
import 'core/db/database_key_provider.dart';
import 'core/db/encrypted_database.dart';
import 'core/i18n/i18n.dart';
import 'core/lock/lock.dart';
import 'core/router/router.dart';
import 'core/session/session.dart';
import 'core/theme/theme.dart';
import 'features/auth/auth.dart';
import 'features/diagnostics/verification_screen.dart';
import 'features/onboarding/onboarding.dart';
import 'features/parent/parent.dart';
import 'features/security/security.dart';
import 'features/student/student.dart';
import 'features/teacher/teacher.dart';

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
    this.biometricGate,
    this.database,
    this.guardianDialer,
    this.filePicker,
    this.studentFilePicker,
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

  /// The OS unlock prompt. Defaults to `local_auth`; injectable so the lock's
  /// rules can be exercised without a fingerprint reader.
  final BiometricGate? biometricGate;

  /// Local storage. Defaults to the encrypted file in the app's documents
  /// directory, which is reached through a platform channel no test host
  /// provides — hence the seam.
  final AppDatabase? database;

  /// Places the call behind "contact guardian". Defaults to the platform
  /// dialer, which is an intent and therefore another channel a test host
  /// does not have.
  final GuardianDialer? guardianDialer;

  /// Chooses a file to attach to homework. Null by default, which hides the
  /// attach action rather than offering a button that cannot do anything --
  /// no file picker is wired into the build yet.
  final FilePicker? filePicker;

  /// The same seam on the student side, for handing work in.
  final StudentFilePicker? studentFilePicker;

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
  late final DatabaseKeyProvider _databaseKeyProvider;
  late final SessionWipe _sessionWipe;
  late final ApiClient _apiClient;
  late final AuthRepository _auth;
  late final ChangePasswordController _changePassword;
  late final AppLockController _appLock;
  late final DeviceListController _devices;
  late final ActivationController _activation;
  late final AppDatabase _database;
  late final ParentHomeController _parentHome;
  late final ParentFeesController _parentFees;
  late final ParentInboxController _parentInbox;
  late final StudentRepository _studentRepository;
  late final StudentHomeController _studentHome;
  late final StudentAssignmentsController _studentAssignments;
  late final TeacherRepository _teacherRepository;
  late final TeacherDayController _teacherDay;
  late final SessionController _session;
  late final GoRouter _router;
  StreamSubscription<void>? _unauthenticated;

  @override
  void initState() {
    super.initState();

    _secureStore = widget.secureStore ?? FlutterSecureStore();
    _tokenStore = SecureTokenStore(store: _secureStore);
    _databaseKeyProvider = DatabaseKeyProvider(store: _secureStore);
    _sessionWipe = SessionWipe(
      tokenStore: _tokenStore,
      databaseKeyProvider: _databaseKeyProvider,
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
    _changePassword = ChangePasswordController(repository: _auth);

    _appLock = AppLockController(
      gate: widget.biometricGate ?? LocalAuthGate(),
      store: _secureStore,
    )..bind();

    _activation = ActivationController(
      api: ActivationApi(dio: _apiClient.dio, tokenStore: _tokenStore),
      session: _session,
      lock: _appLock,
    );

    // One encrypted database for every cache-first screen.
    //
    // Opened lazily: the key comes from the keystore, which is asynchronous,
    // and initState is not. LazyDatabase defers the open to the first query,
    // so the controllers below can be constructed synchronously and the router
    // can name their screens before any of it has touched the disk.
    _database = widget.database ??
        AppDatabase(LazyDatabase(() async => encryptedExecutor(
          file: File(
            '${(await getApplicationDocumentsDirectory()).path}/school_mobile.db',
          ),
          key: await _databaseKeyProvider.key(),
        )));
    _parentHome = ParentHomeController(
      repository: ParentHomeRepository(
        dio: _apiClient.dio,
        database: _database,
      ),
    );
    _parentFees = ParentFeesController(
      repository: ParentFinanceRepository(
        dio: _apiClient.dio,
        database: _database,
      ),
    );

    _parentInbox = ParentInboxController(
      repository: ParentInboxRepository(dio: _apiClient.dio),
    );

    // One repository and one day controller shared by the two teacher tabs.
    // They read the same payload, and two of each would eventually disagree
    // about which classes exist.
    // The student surface. One repository, and note what it does not have:
    // no method here takes a student id, because the server accepts none.
    _studentRepository = StudentRepository(
      dio: _apiClient.dio,
      database: _database,
    );
    _studentHome = StudentHomeController(repository: _studentRepository);
    _studentAssignments =
        StudentAssignmentsController(repository: _studentRepository);

    _teacherRepository = TeacherRepository(
      dio: _apiClient.dio,
      database: _database,
    );
    _teacherDay = TeacherDayController(repository: _teacherRepository);

    _devices = DeviceListController(
      api: DeviceApi(dio: _apiClient.dio),
      tokenStore: _tokenStore,
      // Ending the session on the device you are holding revokes the tokens
      // server-side, so every later call would 401. Signing out at once is the
      // honest response.
      onOwnDeviceRevoked: _auth.signOut,
    );

    // A refresh that cannot be recovered ends the session everywhere at once:
    // the store is wiped and the router falls back to the sign-in screen.
    _unauthenticated = _sessionWipe.bindTo(_apiClient.onUnauthenticated);
    _apiClient.onUnauthenticated.listen((_) => _session.signedOut());

    _router = buildAppRouter(
      controller: _session,
      screens: const AppScreens().withScreens(<AppRoute, RouteScreenBuilder>{
        AppRoute.signIn: (context, state) => AuthGateway(
              repository: _auth,
              activationBuilder: (onCancel) => ActivationScreen(
                controller: _activation,
                onCancel: onCancel,
              ),
            ),
        AppRoute.parentHome: (context, state) =>
            ParentHomeScreen(controller: _parentHome),
        AppRoute.parentFinance: (context, state) =>
            ParentFeesScreen(controller: _parentFees),
        AppRoute.parentMessages: (context, state) =>
            ParentInboxScreen(controller: _parentInbox),
        // Reached by deep link from a fee notification. The controller is
        // built per invoice rather than held, so opening a second invoice
        // cannot show the first one's numbers while it loads.
        AppRoute.parentInvoice: (context, state) => InvoiceDetailScreen(
              controller: InvoiceDetailController(
                repository: ParentFinanceRepository(
                  dio: _apiClient.dio,
                  database: _database,
                ),
                invoiceId:
                    int.tryParse(state.pathParameters['invoiceId'] ?? '') ?? 0,
              ),
            ),
        AppRoute.teacherToday: (context, state) => TeacherTodayScreen(
              controller: _teacherDay,
              // Straight to the register: the day screen exists so a teacher
              // can see which period is outstanding and go and mark it.
              onOpenAttendance: (period) => context.goNamed(
                AppRoute.teacherAttendance.routeName,
                pathParameters: <String, String>{
                  'classId': '${period.classRoomId}',
                },
              ),
            ),
        // Built per class, so opening a second register cannot show the first
        // class's marks while it loads.
        AppRoute.teacherAttendance: (context, state) => AttendanceScreen(
              controller: AttendanceController(
                repository: _teacherRepository,
                classRoomId:
                    int.tryParse(state.pathParameters['classId'] ?? '') ?? 0,
                date: _teacherDay.date,
              ),
              // The day screen re-reads the queue, so the period it sent from
              // starts saying "waiting to send" straight away.
              onSubmitted: () => unawaited(_teacherDay.refreshPending()),
            ),
        AppRoute.teacherClasses: (context, state) => TeacherClassesScreen(
              controller: _teacherDay,
              onOpenClass: (classRoom) => context.goNamed(
                AppRoute.teacherClassRoster.routeName,
                pathParameters: <String, String>{'classId': '${classRoom.id}'},
              ),
            ),
        // Built per class rather than held, so opening a second roster cannot
        // show the first class's students while it loads.
        AppRoute.teacherClassRoster: (context, state) => ClassRosterScreen(
              controller: ClassRosterController(
                repository: _teacherRepository,
                classRoomId:
                    int.tryParse(state.pathParameters['classId'] ?? '') ?? 0,
                date: _teacherDay.date,
              ),
              dialer: widget.guardianDialer ?? const PhoneDialer(),
              photoUrlFor: (studentUserId) =>
                  '${widget.baseUrl ?? apiBaseUrl}/files/profile-photo/$studentUserId',
            ),
        // Keyed on class and subject: a teacher who teaches two subjects to
        // one class marks two separate sheets, and a route that named only
        // the class would silently pick one of them.
        AppRoute.teacherGrades: (context, state) => GradeEntryScreen(
              controller: GradeEntryController(
                repository: _teacherRepository,
                classRoomId:
                    int.tryParse(state.pathParameters['classId'] ?? '') ?? 0,
                subjectId: int.tryParse(
                      state.uri.queryParameters['subjectId'] ?? '',
                    ) ??
                    0,
              ),
            ),
        // Homework for one class. Built per class so opening a second class's
        // list cannot show the first one's drafts while it loads.
        AppRoute.teacherAssignments: (context, state) => AssignmentsScreen(
              controller: AssignmentsController(repository: _teacherRepository),
              classRoomId:
                  int.tryParse(state.pathParameters['classId'] ?? '') ?? 0,
              subjectId:
                  int.tryParse(state.uri.queryParameters['subjectId'] ?? '') ?? 0,
              // No file picker is wired yet, so the attach action is absent
              // rather than present and inert. Passing one here is the only
              // change needed when the picker lands.
              picker: widget.filePicker,
              onOpenHandIns: (assignment) => context.goNamed(
                AppRoute.teacherHandIns.routeName,
                pathParameters: <String, String>{
                  'classId': '${assignment.classRoomId}',
                  'assignmentId': '${assignment.id}',
                },
              ),
            ),
        AppRoute.teacherHandIns: (context, state) => HandInsScreen(
              controller: HandInsController(
                repository: _teacherRepository,
                assignmentId:
                    int.tryParse(state.pathParameters['assignmentId'] ?? '') ?? 0,
              ),
            ),
        AppRoute.teacherAnnounce: (context, state) => AnnounceScreen(
              controller: AnnounceController(
                repository: _teacherRepository,
                classRoomId:
                    int.tryParse(state.uri.queryParameters['classId'] ?? '') ?? 0,
                guardianUserId:
                    int.tryParse(state.uri.queryParameters['guardianId'] ?? ''),
              ),
            ),
        AppRoute.studentHome: (context, state) => StudentHomeScreen(
              controller: _studentHome,
              onOpenAssignment: (_) =>
                  context.goNamed(AppRoute.studentAssignments.routeName),
            ),
        AppRoute.studentTimetable: (context, state) => StudentTimetableScreen(
              controller: StudentRecordControllers.timetable(_studentRepository),
            ),
        AppRoute.studentAssignments: (context, state) =>
            StudentAssignmentsScreen(
              controller: _studentAssignments,
              // No file picker is wired into the build, so the attach action
              // is absent rather than present and inert.
              picker: widget.studentFilePicker,
            ),
        AppRoute.studentGrades: (context, state) => StudentGradesScreen(
              controller: StudentRecordControllers.grades(_studentRepository),
            ),
        AppRoute.studentAttendance: (context, state) =>
            StudentAttendanceScreen(
              controller:
                  StudentRecordControllers.attendance(_studentRepository),
            ),
        AppRoute.devices: (context, state) =>
            DeviceListScreen(controller: _devices),
        AppRoute.diagnostics: (context, state) => VerificationScreen(
              baseUrl: widget.baseUrl ?? apiBaseUrl,
              onToggleDigitShape: _toggleDigitShape,
            ),
        AppRoute.changePassword: (context, state) => ChangePasswordScreen(
              controller: _changePassword,
              onSignOut: () => unawaited(_auth.signOut()),
            ),
        // Interim home for the on-device verification screen, so the checks it
        // performs stay reachable once a session exists. The profile orders
        // replace these three entries; nothing under lib/core/ changes when
        // they do.
        // Interim home for the security settings, so the app-lock and the
        // device list are reachable. The profile orders replace these three
        // entries; nothing under lib/core/ changes when they do.
        AppRoute.parentProfile: _securityScreen,
        AppRoute.teacherProfile: _securityScreen,
        AppRoute.studentProfile: _securityScreen,
      }),
    );

    // Reads the token store and, if a session is still good, restores it.
    // Until this completes the router holds at the splash rather than showing
    // a login screen to someone who is already signed in.
    unawaited(_appLock.load());
    unawaited(_auth.restore());
  }

  @override
  void dispose() {
    unawaited(_unauthenticated?.cancel());
    _router.dispose();
    _changePassword.dispose();
    _studentAssignments.dispose();
    _studentHome.dispose();
    _teacherDay.dispose();
    _parentInbox.dispose();
    _parentFees.dispose();
    _parentHome.dispose();
    unawaited(_database.close());
    _activation.dispose();
    _devices.dispose();
    _appLock.dispose();
    _session.dispose();
    unawaited(_apiClient.close());
    super.dispose();
  }

  Widget _securityScreen(BuildContext context, GoRouterState state) =>
      SecurityScreen(
        lock: _appLock,
        onOpenDevices: () => context.goNamed(AppRoute.devices.routeName),
        onOpenDiagnostics: () =>
            context.goNamed(AppRoute.diagnostics.routeName),
        onSignOut: () => unawaited(_auth.signOut()),
      );

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
          // Above the router on purpose: while the lock is engaged the app's
          // screens are not in the tree at all, so there is no navigation
          // state anyone could manipulate to get behind it.
          child: AppLockOverlay(
            controller: _appLock,
            onSignOut: () => unawaited(_auth.signOut()),
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
