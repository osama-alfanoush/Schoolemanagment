//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'payroll_store_run_request.g.dart';

/// PayrollStoreRunRequest
///
/// Properties:
/// * [year] 
/// * [month] 
@BuiltValue()
abstract class PayrollStoreRunRequest implements Built<PayrollStoreRunRequest, PayrollStoreRunRequestBuilder> {
  @BuiltValueField(wireName: r'year')
  int get year;

  @BuiltValueField(wireName: r'month')
  int get month;

  PayrollStoreRunRequest._();

  factory PayrollStoreRunRequest([void updates(PayrollStoreRunRequestBuilder b)]) = _$PayrollStoreRunRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PayrollStoreRunRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PayrollStoreRunRequest> get serializer => _$PayrollStoreRunRequestSerializer();
}

class _$PayrollStoreRunRequestSerializer implements PrimitiveSerializer<PayrollStoreRunRequest> {
  @override
  final Iterable<Type> types = const [PayrollStoreRunRequest, _$PayrollStoreRunRequest];

  @override
  final String wireName = r'PayrollStoreRunRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PayrollStoreRunRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'year';
    yield serializers.serialize(
      object.year,
      specifiedType: const FullType(int),
    );
    yield r'month';
    yield serializers.serialize(
      object.month,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PayrollStoreRunRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PayrollStoreRunRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'year':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.year = valueDes;
          break;
        case r'month':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.month = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PayrollStoreRunRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PayrollStoreRunRequestBuilder();
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

