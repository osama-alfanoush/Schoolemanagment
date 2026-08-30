//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/payroll_run.dart';
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/employee_contract.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_payroll_dashboard200_response.g.dart';

/// HrPayrollDashboard200Response
///
/// Properties:
/// * [activeStaff] 
/// * [terminatedStaff] 
/// * [contractsExpiringSoon] 
/// * [expiredContracts] 
/// * [uninsuredStaff] 
/// * [pendingAdvances] 
/// * [pendingWarnings] 
/// * [currentPayrollRun] 
/// * [expiringContracts] 
@BuiltValue()
abstract class HrPayrollDashboard200Response implements Built<HrPayrollDashboard200Response, HrPayrollDashboard200ResponseBuilder> {
  @BuiltValueField(wireName: r'active_staff')
  int get activeStaff;

  @BuiltValueField(wireName: r'terminated_staff')
  int get terminatedStaff;

  @BuiltValueField(wireName: r'contracts_expiring_soon')
  int get contractsExpiringSoon;

  @BuiltValueField(wireName: r'expired_contracts')
  int get expiredContracts;

  @BuiltValueField(wireName: r'uninsured_staff')
  int get uninsuredStaff;

  @BuiltValueField(wireName: r'pending_advances')
  int get pendingAdvances;

  @BuiltValueField(wireName: r'pending_warnings')
  int get pendingWarnings;

  @BuiltValueField(wireName: r'current_payroll_run')
  PayrollRun? get currentPayrollRun;

  @BuiltValueField(wireName: r'expiring_contracts')
  BuiltList<EmployeeContract> get expiringContracts;

  HrPayrollDashboard200Response._();

  factory HrPayrollDashboard200Response([void updates(HrPayrollDashboard200ResponseBuilder b)]) = _$HrPayrollDashboard200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrPayrollDashboard200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrPayrollDashboard200Response> get serializer => _$HrPayrollDashboard200ResponseSerializer();
}

class _$HrPayrollDashboard200ResponseSerializer implements PrimitiveSerializer<HrPayrollDashboard200Response> {
  @override
  final Iterable<Type> types = const [HrPayrollDashboard200Response, _$HrPayrollDashboard200Response];

  @override
  final String wireName = r'HrPayrollDashboard200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrPayrollDashboard200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'active_staff';
    yield serializers.serialize(
      object.activeStaff,
      specifiedType: const FullType(int),
    );
    yield r'terminated_staff';
    yield serializers.serialize(
      object.terminatedStaff,
      specifiedType: const FullType(int),
    );
    yield r'contracts_expiring_soon';
    yield serializers.serialize(
      object.contractsExpiringSoon,
      specifiedType: const FullType(int),
    );
    yield r'expired_contracts';
    yield serializers.serialize(
      object.expiredContracts,
      specifiedType: const FullType(int),
    );
    yield r'uninsured_staff';
    yield serializers.serialize(
      object.uninsuredStaff,
      specifiedType: const FullType(int),
    );
    yield r'pending_advances';
    yield serializers.serialize(
      object.pendingAdvances,
      specifiedType: const FullType(int),
    );
    yield r'pending_warnings';
    yield serializers.serialize(
      object.pendingWarnings,
      specifiedType: const FullType(int),
    );
    yield r'current_payroll_run';
    yield object.currentPayrollRun == null ? null : serializers.serialize(
      object.currentPayrollRun,
      specifiedType: const FullType.nullable(PayrollRun),
    );
    yield r'expiring_contracts';
    yield serializers.serialize(
      object.expiringContracts,
      specifiedType: const FullType(BuiltList, [FullType(EmployeeContract)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrPayrollDashboard200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrPayrollDashboard200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'active_staff':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.activeStaff = valueDes;
          break;
        case r'terminated_staff':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.terminatedStaff = valueDes;
          break;
        case r'contracts_expiring_soon':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.contractsExpiringSoon = valueDes;
          break;
        case r'expired_contracts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.expiredContracts = valueDes;
          break;
        case r'uninsured_staff':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.uninsuredStaff = valueDes;
          break;
        case r'pending_advances':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pendingAdvances = valueDes;
          break;
        case r'pending_warnings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pendingWarnings = valueDes;
          break;
        case r'current_payroll_run':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PayrollRun),
          ) as PayrollRun?;
          if (valueDes == null) continue;
          result.currentPayrollRun.replace(valueDes);
          break;
        case r'expiring_contracts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(EmployeeContract)]),
          ) as BuiltList<EmployeeContract>;
          result.expiringContracts.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HrPayrollDashboard200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrPayrollDashboard200ResponseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

