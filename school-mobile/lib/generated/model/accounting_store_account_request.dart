//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_store_account_request.g.dart';

/// AccountingStoreAccountRequest
///
/// Properties:
/// * [accountCode] 
/// * [accountName] 
/// * [accountType] 
/// * [description] 
/// * [isActive] 
@BuiltValue()
abstract class AccountingStoreAccountRequest implements Built<AccountingStoreAccountRequest, AccountingStoreAccountRequestBuilder> {
  @BuiltValueField(wireName: r'account_code')
  String get accountCode;

  @BuiltValueField(wireName: r'account_name')
  String get accountName;

  @BuiltValueField(wireName: r'account_type')
  AccountingStoreAccountRequestAccountTypeEnum get accountType;
  // enum accountTypeEnum {  asset,  liability,  equity,  income,  expense,  };

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'is_active')
  bool? get isActive;

  AccountingStoreAccountRequest._();

  factory AccountingStoreAccountRequest([void updates(AccountingStoreAccountRequestBuilder b)]) = _$AccountingStoreAccountRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingStoreAccountRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingStoreAccountRequest> get serializer => _$AccountingStoreAccountRequestSerializer();
}

class _$AccountingStoreAccountRequestSerializer implements PrimitiveSerializer<AccountingStoreAccountRequest> {
  @override
  final Iterable<Type> types = const [AccountingStoreAccountRequest, _$AccountingStoreAccountRequest];

  @override
  final String wireName = r'AccountingStoreAccountRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingStoreAccountRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'account_code';
    yield serializers.serialize(
      object.accountCode,
      specifiedType: const FullType(String),
    );
    yield r'account_name';
    yield serializers.serialize(
      object.accountName,
      specifiedType: const FullType(String),
    );
    yield r'account_type';
    yield serializers.serialize(
      object.accountType,
      specifiedType: const FullType(AccountingStoreAccountRequestAccountTypeEnum),
    );
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.isActive != null) {
      yield r'is_active';
      yield serializers.serialize(
        object.isActive,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountingStoreAccountRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingStoreAccountRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'account_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accountCode = valueDes;
          break;
        case r'account_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accountName = valueDes;
          break;
        case r'account_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountingStoreAccountRequestAccountTypeEnum),
          ) as AccountingStoreAccountRequestAccountTypeEnum;
          result.accountType = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'is_active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountingStoreAccountRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingStoreAccountRequestBuilder();
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

class AccountingStoreAccountRequestAccountTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'asset')
  static const AccountingStoreAccountRequestAccountTypeEnum asset = _$accountingStoreAccountRequestAccountTypeEnum_asset;
  @BuiltValueEnumConst(wireName: r'liability')
  static const AccountingStoreAccountRequestAccountTypeEnum liability = _$accountingStoreAccountRequestAccountTypeEnum_liability;
  @BuiltValueEnumConst(wireName: r'equity')
  static const AccountingStoreAccountRequestAccountTypeEnum equity = _$accountingStoreAccountRequestAccountTypeEnum_equity;
  @BuiltValueEnumConst(wireName: r'income')
  static const AccountingStoreAccountRequestAccountTypeEnum income = _$accountingStoreAccountRequestAccountTypeEnum_income;
  @BuiltValueEnumConst(wireName: r'expense')
  static const AccountingStoreAccountRequestAccountTypeEnum expense = _$accountingStoreAccountRequestAccountTypeEnum_expense;

  static Serializer<AccountingStoreAccountRequestAccountTypeEnum> get serializer => _$accountingStoreAccountRequestAccountTypeEnumSerializer;

  const AccountingStoreAccountRequestAccountTypeEnum._(String name): super(name);

  static BuiltSet<AccountingStoreAccountRequestAccountTypeEnum> get values => _$accountingStoreAccountRequestAccountTypeEnumValues;
  static AccountingStoreAccountRequestAccountTypeEnum valueOf(String name) => _$accountingStoreAccountRequestAccountTypeEnumValueOf(name);
}

