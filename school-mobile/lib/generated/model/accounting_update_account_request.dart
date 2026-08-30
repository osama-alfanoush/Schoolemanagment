//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting_update_account_request.g.dart';

/// AccountingUpdateAccountRequest
///
/// Properties:
/// * [accountCode] 
/// * [accountName] 
/// * [accountType] 
/// * [description] 
/// * [isActive] 
@BuiltValue()
abstract class AccountingUpdateAccountRequest implements Built<AccountingUpdateAccountRequest, AccountingUpdateAccountRequestBuilder> {
  @BuiltValueField(wireName: r'account_code')
  String? get accountCode;

  @BuiltValueField(wireName: r'account_name')
  String? get accountName;

  @BuiltValueField(wireName: r'account_type')
  AccountingUpdateAccountRequestAccountTypeEnum? get accountType;
  // enum accountTypeEnum {  asset,  liability,  equity,  income,  expense,  };

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'is_active')
  bool? get isActive;

  AccountingUpdateAccountRequest._();

  factory AccountingUpdateAccountRequest([void updates(AccountingUpdateAccountRequestBuilder b)]) = _$AccountingUpdateAccountRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountingUpdateAccountRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountingUpdateAccountRequest> get serializer => _$AccountingUpdateAccountRequestSerializer();
}

class _$AccountingUpdateAccountRequestSerializer implements PrimitiveSerializer<AccountingUpdateAccountRequest> {
  @override
  final Iterable<Type> types = const [AccountingUpdateAccountRequest, _$AccountingUpdateAccountRequest];

  @override
  final String wireName = r'AccountingUpdateAccountRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountingUpdateAccountRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.accountCode != null) {
      yield r'account_code';
      yield serializers.serialize(
        object.accountCode,
        specifiedType: const FullType(String),
      );
    }
    if (object.accountName != null) {
      yield r'account_name';
      yield serializers.serialize(
        object.accountName,
        specifiedType: const FullType(String),
      );
    }
    if (object.accountType != null) {
      yield r'account_type';
      yield serializers.serialize(
        object.accountType,
        specifiedType: const FullType(AccountingUpdateAccountRequestAccountTypeEnum),
      );
    }
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
    AccountingUpdateAccountRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountingUpdateAccountRequestBuilder result,
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
            specifiedType: const FullType(AccountingUpdateAccountRequestAccountTypeEnum),
          ) as AccountingUpdateAccountRequestAccountTypeEnum;
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
  AccountingUpdateAccountRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountingUpdateAccountRequestBuilder();
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

class AccountingUpdateAccountRequestAccountTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'asset')
  static const AccountingUpdateAccountRequestAccountTypeEnum asset = _$accountingUpdateAccountRequestAccountTypeEnum_asset;
  @BuiltValueEnumConst(wireName: r'liability')
  static const AccountingUpdateAccountRequestAccountTypeEnum liability = _$accountingUpdateAccountRequestAccountTypeEnum_liability;
  @BuiltValueEnumConst(wireName: r'equity')
  static const AccountingUpdateAccountRequestAccountTypeEnum equity = _$accountingUpdateAccountRequestAccountTypeEnum_equity;
  @BuiltValueEnumConst(wireName: r'income')
  static const AccountingUpdateAccountRequestAccountTypeEnum income = _$accountingUpdateAccountRequestAccountTypeEnum_income;
  @BuiltValueEnumConst(wireName: r'expense')
  static const AccountingUpdateAccountRequestAccountTypeEnum expense = _$accountingUpdateAccountRequestAccountTypeEnum_expense;

  static Serializer<AccountingUpdateAccountRequestAccountTypeEnum> get serializer => _$accountingUpdateAccountRequestAccountTypeEnumSerializer;

  const AccountingUpdateAccountRequestAccountTypeEnum._(String name): super(name);

  static BuiltSet<AccountingUpdateAccountRequestAccountTypeEnum> get values => _$accountingUpdateAccountRequestAccountTypeEnumValues;
  static AccountingUpdateAccountRequestAccountTypeEnum valueOf(String name) => _$accountingUpdateAccountRequestAccountTypeEnumValueOf(name);
}

