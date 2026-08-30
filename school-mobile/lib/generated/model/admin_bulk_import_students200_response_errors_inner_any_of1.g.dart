// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_bulk_import_students200_response_errors_inner_any_of1.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum
_$adminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum_number1 =
    const AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum._(
      'number1',
    );

AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum
_$adminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnumValueOf(
  String name,
) {
  switch (name) {
    case 'number1':
      return _$adminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum_number1;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum>
_$adminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnumValues =
    BuiltSet<AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum>(
      const <AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum>[
        _$adminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum_number1,
      ],
    );

const AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum
_$adminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum_columnCountDoesNotMatchTheCSVHeaderPeriod =
    const AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum._(
      'columnCountDoesNotMatchTheCSVHeaderPeriod',
    );

AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum
_$adminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnumValueOf(
  String name,
) {
  switch (name) {
    case 'columnCountDoesNotMatchTheCSVHeaderPeriod':
      return _$adminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum_columnCountDoesNotMatchTheCSVHeaderPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum>
_$adminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnumValues =
    BuiltSet<
      AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum
    >(const <AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum>[
      _$adminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum_columnCountDoesNotMatchTheCSVHeaderPeriod,
    ]);

Serializer<AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum>
_$adminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnumSerializer =
    _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnumSerializer();
Serializer<AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum>
_$adminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnumSerializer =
    _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnumSerializer();

class _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnumSerializer
    implements
        PrimitiveSerializer<
          AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum
        > {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number1': 1,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    1: 'number1',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum,
  ];
  @override
  final String wireName =
      'AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnumSerializer
    implements
        PrimitiveSerializer<
          AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum
        > {
  static const Map<String, Object> _toWire = const <String, Object>{
    'columnCountDoesNotMatchTheCSVHeaderPeriod':
        'Column count does not match the CSV header.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Column count does not match the CSV header.':
        'columnCountDoesNotMatchTheCSVHeaderPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum,
  ];
  @override
  final String wireName =
      'AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf1
    extends AdminBulkImportStudents200ResponseErrorsInnerAnyOf1 {
  @override
  final AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum row;
  @override
  final AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum error;

  factory _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf1([
    void Function(AdminBulkImportStudents200ResponseErrorsInnerAnyOf1Builder)?
    updates,
  ]) =>
      (AdminBulkImportStudents200ResponseErrorsInnerAnyOf1Builder()
            ..update(updates))
          ._build();

  _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf1._({
    required this.row,
    required this.error,
  }) : super._();
  @override
  AdminBulkImportStudents200ResponseErrorsInnerAnyOf1 rebuild(
    void Function(AdminBulkImportStudents200ResponseErrorsInnerAnyOf1Builder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminBulkImportStudents200ResponseErrorsInnerAnyOf1Builder toBuilder() =>
      AdminBulkImportStudents200ResponseErrorsInnerAnyOf1Builder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminBulkImportStudents200ResponseErrorsInnerAnyOf1 &&
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
            r'AdminBulkImportStudents200ResponseErrorsInnerAnyOf1',
          )
          ..add('row', row)
          ..add('error', error))
        .toString();
  }
}

class AdminBulkImportStudents200ResponseErrorsInnerAnyOf1Builder
    implements
        Builder<
          AdminBulkImportStudents200ResponseErrorsInnerAnyOf1,
          AdminBulkImportStudents200ResponseErrorsInnerAnyOf1Builder
        > {
  _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf1? _$v;

  AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum? _row;
  AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum? get row =>
      _$this._row;
  set row(AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum? row) =>
      _$this._row = row;

  AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum? _error;
  AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum? get error =>
      _$this._error;
  set error(
    AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum? error,
  ) => _$this._error = error;

  AdminBulkImportStudents200ResponseErrorsInnerAnyOf1Builder() {
    AdminBulkImportStudents200ResponseErrorsInnerAnyOf1._defaults(this);
  }

  AdminBulkImportStudents200ResponseErrorsInnerAnyOf1Builder get _$this {
    final $v = _$v;
    if ($v != null) {
      _row = $v.row;
      _error = $v.error;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminBulkImportStudents200ResponseErrorsInnerAnyOf1 other) {
    _$v = other as _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf1;
  }

  @override
  void update(
    void Function(AdminBulkImportStudents200ResponseErrorsInnerAnyOf1Builder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminBulkImportStudents200ResponseErrorsInnerAnyOf1 build() => _build();

  _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf1 _build() {
    final _$result =
        _$v ??
        _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf1._(
          row: BuiltValueNullFieldError.checkNotNull(
            row,
            r'AdminBulkImportStudents200ResponseErrorsInnerAnyOf1',
            'row',
          ),
          error: BuiltValueNullFieldError.checkNotNull(
            error,
            r'AdminBulkImportStudents200ResponseErrorsInnerAnyOf1',
            'error',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
