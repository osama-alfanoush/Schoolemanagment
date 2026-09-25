//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/accounting_audit_trail200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_audit_trail200_response.g.dart';

/// AccountingAuditTrail200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class AccountingAuditTrail200Response implements Built<AccountingAuditTrail200Response, AccountingAuditTrail200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  AccountingAuditTrail200ResponseData get data;

  AccountingAuditTrail200Response._();

  factory AccountingAuditTrail200Response([void updates(AccountingAuditTrail200ResponseBuilder b)]) = _$AccountingAuditTrail200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingAuditTrail200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingAuditTrail200Response> get serializer => _$AccountingAuditTrail200ResponseSerializer();
}

class _$AccountingAuditTrail200ResponseSerializer implements PrimitiveSerializer<AccountingAuditTrail200Response> {
  @override
  final Iterable<Type> types = const [AccountingAuditTrail200Response, _$AccountingAuditTrail200Response];

  @override
  final String wireName = r'AccountingAuditTrail200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingAuditTrail200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(AccountingAuditTrail200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingAuditTrail200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingAuditTrail200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountingAuditTrail200ResponseData),
          ) as AccountingAuditTrail200ResponseData;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountingAuditTrail200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingAuditTrail200ResponseBuilder();
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

