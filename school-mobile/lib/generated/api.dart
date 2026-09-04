//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:dio/dio.dart';
import 'package:built_value/serializer.dart';
import 'package:school_mobile/generated/serializers.dart';
import 'package:school_mobile/generated/auth/api_key_auth.dart';
import 'package:school_mobile/generated/auth/basic_auth.dart';
import 'package:school_mobile/generated/auth/bearer_auth.dart';
import 'package:school_mobile/generated/auth/oauth.dart';
import 'package:school_mobile/generated/api/accounting_api.dart';
import 'package:school_mobile/generated/api/admin_api.dart';
import 'package:school_mobile/generated/api/auth_api.dart';
import 'package:school_mobile/generated/api/default_api.dart';
import 'package:school_mobile/generated/api/enrollment_api.dart';
import 'package:school_mobile/generated/api/file_api.dart';
import 'package:school_mobile/generated/api/finance_api.dart';
import 'package:school_mobile/generated/api/financial_workspace_api.dart';
import 'package:school_mobile/generated/api/gradebook_api.dart';
import 'package:school_mobile/generated/api/health_api.dart';
import 'package:school_mobile/generated/api/hr_api.dart';
import 'package:school_mobile/generated/api/hr_payroll_api.dart';
import 'package:school_mobile/generated/api/installment_api.dart';
import 'package:school_mobile/generated/api/library_api.dart';
import 'package:school_mobile/generated/api/messaging_api.dart';
import 'package:school_mobile/generated/api/mfa_api.dart';
import 'package:school_mobile/generated/api/notification_api.dart';
import 'package:school_mobile/generated/api/parent_api.dart';
import 'package:school_mobile/generated/api/parent_academics_api.dart';
import 'package:school_mobile/generated/api/parent_finance_api.dart';
import 'package:school_mobile/generated/api/parent_home_api.dart';
import 'package:school_mobile/generated/api/parent_invite_api.dart';
import 'package:school_mobile/generated/api/payment_api.dart';
import 'package:school_mobile/generated/api/payroll_api.dart';
import 'package:school_mobile/generated/api/payroll_settings_api.dart';
import 'package:school_mobile/generated/api/procurement_api.dart';
import 'package:school_mobile/generated/api/procurement_finance_api.dart';
import 'package:school_mobile/generated/api/student_api.dart';
import 'package:school_mobile/generated/api/sync_api.dart';
import 'package:school_mobile/generated/api/teacher_api.dart';
import 'package:school_mobile/generated/api/transport_api.dart';
import 'package:school_mobile/generated/api/warehouse_api.dart';

class SchoolMobile {
  static const String basePath = r'/api';

  final Dio dio;
  final Serializers serializers;

  SchoolMobile({
    Dio? dio,
    Serializers? serializers,
    String? basePathOverride,
    List<Interceptor>? interceptors,
  })  : this.serializers = serializers ?? standardSerializers,
        this.dio = dio ??
            Dio(BaseOptions(
              baseUrl: basePathOverride ?? basePath,
              connectTimeout: const Duration(milliseconds: 5000),
              receiveTimeout: const Duration(milliseconds: 3000),
            )) {
    if (interceptors == null) {
      this.dio.interceptors.addAll([
        OAuthInterceptor(),
        BasicAuthInterceptor(),
        BearerAuthInterceptor(),
        ApiKeyAuthInterceptor(),
      ]);
    } else {
      this.dio.interceptors.addAll(interceptors);
    }
  }

  void setOAuthToken(String name, String token) {
    if (this.dio.interceptors.any((i) => i is OAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is OAuthInterceptor) as OAuthInterceptor).tokens[name] = token;
    }
  }

  void setBearerAuth(String name, String token) {
    if (this.dio.interceptors.any((i) => i is BearerAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BearerAuthInterceptor) as BearerAuthInterceptor).tokens[name] = token;
    }
  }

  void setBasicAuth(String name, String username, String password) {
    if (this.dio.interceptors.any((i) => i is BasicAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BasicAuthInterceptor) as BasicAuthInterceptor).authInfo[name] = BasicAuthInfo(username, password);
    }
  }

  void setApiKey(String name, String apiKey) {
    if (this.dio.interceptors.any((i) => i is ApiKeyAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((element) => element is ApiKeyAuthInterceptor) as ApiKeyAuthInterceptor).apiKeys[name] = apiKey;
    }
  }

  /// Get AccountingApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AccountingApi getAccountingApi() {
    return AccountingApi(dio, serializers);
  }

  /// Get AdminApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AdminApi getAdminApi() {
    return AdminApi(dio, serializers);
  }

  /// Get AuthApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AuthApi getAuthApi() {
    return AuthApi(dio, serializers);
  }

  /// Get DefaultApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  DefaultApi getDefaultApi() {
    return DefaultApi(dio, serializers);
  }

  /// Get EnrollmentApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  EnrollmentApi getEnrollmentApi() {
    return EnrollmentApi(dio, serializers);
  }

  /// Get FileApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  FileApi getFileApi() {
    return FileApi(dio, serializers);
  }

  /// Get FinanceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  FinanceApi getFinanceApi() {
    return FinanceApi(dio, serializers);
  }

  /// Get FinancialWorkspaceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  FinancialWorkspaceApi getFinancialWorkspaceApi() {
    return FinancialWorkspaceApi(dio, serializers);
  }

  /// Get GradebookApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  GradebookApi getGradebookApi() {
    return GradebookApi(dio, serializers);
  }

  /// Get HealthApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  HealthApi getHealthApi() {
    return HealthApi(dio, serializers);
  }

  /// Get HrApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  HrApi getHrApi() {
    return HrApi(dio, serializers);
  }

  /// Get HrPayrollApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  HrPayrollApi getHrPayrollApi() {
    return HrPayrollApi(dio, serializers);
  }

  /// Get InstallmentApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  InstallmentApi getInstallmentApi() {
    return InstallmentApi(dio, serializers);
  }

  /// Get LibraryApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  LibraryApi getLibraryApi() {
    return LibraryApi(dio, serializers);
  }

  /// Get MessagingApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MessagingApi getMessagingApi() {
    return MessagingApi(dio, serializers);
  }

  /// Get MfaApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MfaApi getMfaApi() {
    return MfaApi(dio, serializers);
  }

  /// Get NotificationApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  NotificationApi getNotificationApi() {
    return NotificationApi(dio, serializers);
  }

  /// Get ParentApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ParentApi getParentApi() {
    return ParentApi(dio, serializers);
  }

  /// Get ParentAcademicsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ParentAcademicsApi getParentAcademicsApi() {
    return ParentAcademicsApi(dio, serializers);
  }

  /// Get ParentFinanceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ParentFinanceApi getParentFinanceApi() {
    return ParentFinanceApi(dio, serializers);
  }

  /// Get ParentHomeApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ParentHomeApi getParentHomeApi() {
    return ParentHomeApi(dio, serializers);
  }

  /// Get ParentInviteApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ParentInviteApi getParentInviteApi() {
    return ParentInviteApi(dio, serializers);
  }

  /// Get PaymentApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  PaymentApi getPaymentApi() {
    return PaymentApi(dio, serializers);
  }

  /// Get PayrollApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  PayrollApi getPayrollApi() {
    return PayrollApi(dio, serializers);
  }

  /// Get PayrollSettingsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  PayrollSettingsApi getPayrollSettingsApi() {
    return PayrollSettingsApi(dio, serializers);
  }

  /// Get ProcurementApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ProcurementApi getProcurementApi() {
    return ProcurementApi(dio, serializers);
  }

  /// Get ProcurementFinanceApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ProcurementFinanceApi getProcurementFinanceApi() {
    return ProcurementFinanceApi(dio, serializers);
  }

  /// Get StudentApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  StudentApi getStudentApi() {
    return StudentApi(dio, serializers);
  }

  /// Get SyncApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  SyncApi getSyncApi() {
    return SyncApi(dio, serializers);
  }

  /// Get TeacherApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TeacherApi getTeacherApi() {
    return TeacherApi(dio, serializers);
  }

  /// Get TransportApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  TransportApi getTransportApi() {
    return TransportApi(dio, serializers);
  }

  /// Get WarehouseApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  WarehouseApi getWarehouseApi() {
    return WarehouseApi(dio, serializers);
  }
}
