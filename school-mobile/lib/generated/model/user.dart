//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user.g.dart';

/// User
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [email] 
/// * [emailVerifiedAt] 
/// * [role] 
/// * [phone] 
/// * [photoPath] 
/// * [locale] 
/// * [isActive] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [mustChangePassword] 
/// * [lastLoginAt] 
/// * [loginAttempts] 
/// * [lockedUntil] 
/// * [deactivatedAt] 
/// * [deactivatedBy] 
/// * [deactivationReason] 
/// * [mfaConfirmedAt] 
/// * [mfaLastUsedTimestep] 
/// * [mfaRecoveryUsedAt] 
@BuiltValue()
abstract class User implements Built<User, UserBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'email')
  String get email;

  @BuiltValueField(wireName: r'email_verified_at')
  DateTime? get emailVerifiedAt;

  @BuiltValueField(wireName: r'role')
  String get role;

  @BuiltValueField(wireName: r'phone')
  String? get phone;

  @BuiltValueField(wireName: r'photo_path')
  String? get photoPath;

  @BuiltValueField(wireName: r'locale')
  String get locale;

  @BuiltValueField(wireName: r'is_active')
  bool get isActive;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'must_change_password')
  bool get mustChangePassword;

  @BuiltValueField(wireName: r'last_login_at')
  DateTime? get lastLoginAt;

  @BuiltValueField(wireName: r'login_attempts')
  int get loginAttempts;

  @BuiltValueField(wireName: r'locked_until')
  DateTime? get lockedUntil;

  @BuiltValueField(wireName: r'deactivated_at')
  DateTime? get deactivatedAt;

  @BuiltValueField(wireName: r'deactivated_by')
  int? get deactivatedBy;

  @BuiltValueField(wireName: r'deactivation_reason')
  String? get deactivationReason;

  @BuiltValueField(wireName: r'mfa_confirmed_at')
  DateTime? get mfaConfirmedAt;

  @BuiltValueField(wireName: r'mfa_last_used_timestep')
  int? get mfaLastUsedTimestep;

  @BuiltValueField(wireName: r'mfa_recovery_used_at')
  DateTime? get mfaRecoveryUsedAt;

  User._();

  factory User([void updates(UserBuilder b)]) = _$User;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<User> get serializer => _$UserSerializer();
}

class _$UserSerializer implements PrimitiveSerializer<User> {
  @override
  final Iterable<Type> types = const [User, _$User];

  @override
  final String wireName = r'User';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    User object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'email_verified_at';
    yield object.emailVerifiedAt == null ? null : serializers.serialize(
      object.emailVerifiedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(String),
    );
    yield r'phone';
    yield object.phone == null ? null : serializers.serialize(
      object.phone,
      specifiedType: const FullType.nullable(String),
    );
    yield r'photo_path';
    yield object.photoPath == null ? null : serializers.serialize(
      object.photoPath,
      specifiedType: const FullType.nullable(String),
    );
    yield r'locale';
    yield serializers.serialize(
      object.locale,
      specifiedType: const FullType(String),
    );
    yield r'is_active';
    yield serializers.serialize(
      object.isActive,
      specifiedType: const FullType(bool),
    );
    yield r'created_at';
    yield object.createdAt == null ? null : serializers.serialize(
      object.createdAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'updated_at';
    yield object.updatedAt == null ? null : serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'must_change_password';
    yield serializers.serialize(
      object.mustChangePassword,
      specifiedType: const FullType(bool),
    );
    yield r'last_login_at';
    yield object.lastLoginAt == null ? null : serializers.serialize(
      object.lastLoginAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'login_attempts';
    yield serializers.serialize(
      object.loginAttempts,
      specifiedType: const FullType(int),
    );
    yield r'locked_until';
    yield object.lockedUntil == null ? null : serializers.serialize(
      object.lockedUntil,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'deactivated_at';
    yield object.deactivatedAt == null ? null : serializers.serialize(
      object.deactivatedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'deactivated_by';
    yield object.deactivatedBy == null ? null : serializers.serialize(
      object.deactivatedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'deactivation_reason';
    yield object.deactivationReason == null ? null : serializers.serialize(
      object.deactivationReason,
      specifiedType: const FullType.nullable(String),
    );
    yield r'mfa_confirmed_at';
    yield object.mfaConfirmedAt == null ? null : serializers.serialize(
      object.mfaConfirmedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'mfa_last_used_timestep';
    yield object.mfaLastUsedTimestep == null ? null : serializers.serialize(
      object.mfaLastUsedTimestep,
      specifiedType: const FullType.nullable(int),
    );
    yield r'mfa_recovery_used_at';
    yield object.mfaRecoveryUsedAt == null ? null : serializers.serialize(
      object.mfaRecoveryUsedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    User object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'email_verified_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.emailVerifiedAt = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.role = valueDes;
          break;
        case r'phone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.phone = valueDes;
          break;
        case r'photo_path':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.photoPath = valueDes;
          break;
        case r'locale':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.locale = valueDes;
          break;
        case r'is_active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.updatedAt = valueDes;
          break;
        case r'must_change_password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.mustChangePassword = valueDes;
          break;
        case r'last_login_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lastLoginAt = valueDes;
          break;
        case r'login_attempts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.loginAttempts = valueDes;
          break;
        case r'locked_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lockedUntil = valueDes;
          break;
        case r'deactivated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.deactivatedAt = valueDes;
          break;
        case r'deactivated_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.deactivatedBy = valueDes;
          break;
        case r'deactivation_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.deactivationReason = valueDes;
          break;
        case r'mfa_confirmed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.mfaConfirmedAt = valueDes;
          break;
        case r'mfa_last_used_timestep':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.mfaLastUsedTimestep = valueDes;
          break;
        case r'mfa_recovery_used_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.mfaRecoveryUsedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  User deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserBuilder();
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

