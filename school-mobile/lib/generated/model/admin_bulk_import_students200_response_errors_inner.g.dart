// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_bulk_import_students200_response_errors_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AdminBulkImportStudents200ResponseErrorsInnerRowEnum
_$adminBulkImportStudents200ResponseErrorsInnerRowEnum_number1 =
    const AdminBulkImportStudents200ResponseErrorsInnerRowEnum._('number1');

AdminBulkImportStudents200ResponseErrorsInnerRowEnum
_$adminBulkImportStudents200ResponseErrorsInnerRowEnumValueOf(String name) {
  switch (name) {
    case 'number1':
      return _$adminBulkImportStudents200ResponseErrorsInnerRowEnum_number1;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AdminBulkImportStudents200ResponseErrorsInnerRowEnum>
_$adminBulkImportStudents200ResponseErrorsInnerRowEnumValues =
    BuiltSet<AdminBulkImportStudents200ResponseErrorsInnerRowEnum>(
      const <AdminBulkImportStudents200ResponseErrorsInnerRowEnum>[
        _$adminBulkImportStudents200ResponseErrorsInnerRowEnum_number1,
      ],
    );

Serializer<AdminBulkImportStudents200ResponseErrorsInnerRowEnum>
_$adminBulkImportStudents200ResponseErrorsInnerRowEnumSerializer =
    _$AdminBulkImportStudents200ResponseErrorsInnerRowEnumSerializer();

class _$AdminBulkImportStudents200ResponseErrorsInnerRowEnumSerializer
    implements
        PrimitiveSerializer<
          AdminBulkImportStudents200ResponseErrorsInnerRowEnum
        > {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number1': 1,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    1: 'number1',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AdminBulkImportStudents200ResponseErrorsInnerRowEnum,
  ];
  @override
  final String wireName =
      'AdminBulkImportStudents200ResponseErrorsInnerRowEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminBulkImportStudents200ResponseErrorsInnerRowEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminBulkImportStudents200ResponseErrorsInnerRowEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminBulkImportStudents200ResponseErrorsInnerRowEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminBulkImportStudents200ResponseErrorsInner
    extends AdminBulkImportStudents200ResponseErrorsInner {
  @override
  final AnyOf anyOf;

  factory _$AdminBulkImportStudents200ResponseErrorsInner([
    void Function(AdminBulkImportStudents200ResponseErrorsInnerBuilder)?
    updates,
  ]) =>
      (AdminBulkImportStudents200ResponseErrorsInnerBuilder()..update(updates))
          ._build();

  _$AdminBulkImportStudents200ResponseErrorsInner._({required this.anyOf})
    : super._();
  @override
  AdminBulkImportStudents200ResponseErrorsInner rebuild(
    void Function(AdminBulkImportStudents200ResponseErrorsInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminBulkImportStudents200ResponseErrorsInnerBuilder toBuilder() =>
      AdminBulkImportStudents200ResponseErrorsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminBulkImportStudents200ResponseErrorsInner &&
        anyOf == other.anyOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, anyOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AdminBulkImportStudents200ResponseErrorsInner',
    )..add('anyOf', anyOf)).toString();
  }
}

class AdminBulkImportStudents200ResponseErrorsInnerBuilder
    implements
        Builder<
          AdminBulkImportStudents200ResponseErrorsInner,
          AdminBulkImportStudents200ResponseErrorsInnerBuilder
        > {
  _$AdminBulkImportStudents200ResponseErrorsInner? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  AdminBulkImportStudents200ResponseErrorsInnerBuilder() {
    AdminBulkImportStudents200ResponseErrorsInner._defaults(this);
  }

  AdminBulkImportStudents200ResponseErrorsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminBulkImportStudents200ResponseErrorsInner other) {
    _$v = other as _$AdminBulkImportStudents200ResponseErrorsInner;
  }

  @override
  void update(
    void Function(AdminBulkImportStudents200ResponseErrorsInnerBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminBulkImportStudents200ResponseErrorsInner build() => _build();

  _$AdminBulkImportStudents200ResponseErrorsInner _build() {
    final _$result =
        _$v ??
        _$AdminBulkImportStudents200ResponseErrorsInner._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'AdminBulkImportStudents200ResponseErrorsInner',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
