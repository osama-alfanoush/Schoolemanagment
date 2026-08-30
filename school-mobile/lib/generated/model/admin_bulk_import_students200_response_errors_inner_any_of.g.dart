// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_bulk_import_students200_response_errors_inner_any_of.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum
_$adminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum_number1 =
    const AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum._(
      'number1',
    );

AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum
_$adminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnumValueOf(
  String name,
) {
  switch (name) {
    case 'number1':
      return _$adminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum_number1;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum>
_$adminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnumValues =
    BuiltSet<AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum>(
      const <AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum>[
        _$adminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum_number1,
      ],
    );

const AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum
_$adminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum_importLimitIs5Comma000DataRowsPeriod =
    const AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum._(
      'importLimitIs5Comma000DataRowsPeriod',
    );

AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum
_$adminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnumValueOf(
  String name,
) {
  switch (name) {
    case 'importLimitIs5Comma000DataRowsPeriod':
      return _$adminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum_importLimitIs5Comma000DataRowsPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum>
_$adminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnumValues =
    BuiltSet<
      AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum
    >(const <AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum>[
      _$adminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum_importLimitIs5Comma000DataRowsPeriod,
    ]);

Serializer<AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum>
_$adminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnumSerializer =
    _$AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnumSerializer();
Serializer<AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum>
_$adminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnumSerializer =
    _$AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnumSerializer();

class _$AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnumSerializer
    implements
        PrimitiveSerializer<
          AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum
        > {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number1': 1,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    1: 'number1',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum,
  ];
  @override
  final String wireName =
      'AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnumSerializer
    implements
        PrimitiveSerializer<
          AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum
        > {
  static const Map<String, Object> _toWire = const <String, Object>{
    'importLimitIs5Comma000DataRowsPeriod': 'Import limit is 5,000 data rows.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Import limit is 5,000 data rows.': 'importLimitIs5Comma000DataRowsPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum,
  ];
  @override
  final String wireName =
      'AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf
    extends AdminBulkImportStudents200ResponseErrorsInnerAnyOf {
  @override
  final AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum row;
  @override
  final AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum error;

  factory _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf([
    void Function(AdminBulkImportStudents200ResponseErrorsInnerAnyOfBuilder)?
    updates,
  ]) =>
      (AdminBulkImportStudents200ResponseErrorsInnerAnyOfBuilder()
            ..update(updates))
          ._build();

  _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf._({
    required this.row,
    required this.error,
  }) : super._();
  @override
  AdminBulkImportStudents200ResponseErrorsInnerAnyOf rebuild(
    void Function(AdminBulkImportStudents200ResponseErrorsInnerAnyOfBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminBulkImportStudents200ResponseErrorsInnerAnyOfBuilder toBuilder() =>
      AdminBulkImportStudents200ResponseErrorsInnerAnyOfBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminBulkImportStudents200ResponseErrorsInnerAnyOf &&
        row == other.row &&
        error == other.error;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, row.hashCode);
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'AdminBulkImportStudents200ResponseErrorsInnerAnyOf',
          )
          ..add('row', row)
          ..add('error', error))
        .toString();
  }
}

class AdminBulkImportStudents200ResponseErrorsInnerAnyOfBuilder
    implements
        Builder<
          AdminBulkImportStudents200ResponseErrorsInnerAnyOf,
          AdminBulkImportStudents200ResponseErrorsInnerAnyOfBuilder
        > {
  _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf? _$v;

  AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum? _row;
  AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum? get row =>
      _$this._row;
  set row(AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum? row) =>
      _$this._row = row;

  AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum? _error;
  AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum? get error =>
      _$this._error;
  set error(
    AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum? error,
  ) => _$this._error = error;

  AdminBulkImportStudents200ResponseErrorsInnerAnyOfBuilder() {
    AdminBulkImportStudents200ResponseErrorsInnerAnyOf._defaults(this);
  }

  AdminBulkImportStudents200ResponseErrorsInnerAnyOfBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _row = $v.row;
      _error = $v.error;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminBulkImportStudents200ResponseErrorsInnerAnyOf other) {
    _$v = other as _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf;
  }

  @override
  void update(
    void Function(AdminBulkImportStudents200ResponseErrorsInnerAnyOfBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminBulkImportStudents200ResponseErrorsInnerAnyOf build() => _build();

  _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf _build() {
    final _$result =
        _$v ??
        _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf._(
          row: BuiltValueNullFieldError.checkNotNull(
            row,
            r'AdminBulkImportStudents200ResponseErrorsInnerAnyOf',
            'row',
          ),
          error: BuiltValueNullFieldError.checkNotNull(
            error,
            r'AdminBulkImportStudents200ResponseErrorsInnerAnyOf',
            'error',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
