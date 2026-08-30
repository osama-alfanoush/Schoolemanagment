//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_change_password_request.g.dart';

/// AuthChangePasswordRequest
///
/// Properties:
/// * [currentPassword] 
/// * [newPassword] 
/// * [newPasswordConfirmation] 
@BuiltValue()
abstract class AuthChangePasswordRequest implements Built<AuthChangePasswordRequest, AuthChangePasswordRequestBuilder> {
  @BuiltValueField(wireName: r'current_password')
  String get currentPassword;

  @BuiltValueField(wireName: r'new_password')
  String get newPassword;

  @BuiltValueField(wireName: r'new_password_confirmation')
  String get newPasswordConfirmation;

  AuthChangePasswordRequest._();

  factory AuthChangePasswordRequest([void updates(AuthChangePasswordRequestBuilder b)]) = _$AuthChangePasswordRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthChangePasswordRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthChangePasswordRequest> get serializer => _$AuthChangePasswordRequestSerializer();
}

class _$AuthChangePasswordRequestSerializer implements PrimitiveSerializer<AuthChangePasswordRequest> {
  @override
  final Iterable<Type> types = const [AuthChangePasswordRequest, _$AuthChangePasswordRequest];

  @override
  final String wireName = r'AuthChangePasswordRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthChangePasswordRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'current_password';
    yield serializers.serialize(
      object.currentPassword,
      specifiedType: const FullType(String),
    );
    yield r'new_password';
    yield serializers.serialize(
      object.newPassword,
      specifiedType: const FullType(String),
    );
    yield r'new_password_confirmation';
    yield serializers.serialize(
      object.newPasswordConfirmation,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthChangePasswordRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AuthChangePasswordRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'current_password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.currentPassword = valueDes;
          break;
        case r'new_password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.newPassword = valueDes;
          break;
        case r'new_password_confirmation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.newPasswordConfirmation = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AuthChangePasswordRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthChangePasswordRequestBuilder();
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

