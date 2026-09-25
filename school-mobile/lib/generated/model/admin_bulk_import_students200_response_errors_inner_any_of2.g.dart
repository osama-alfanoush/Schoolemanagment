// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_bulk_import_students200_response_errors_inner_any_of2.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum
_$adminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum_number1 =
    const AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum._(
      'number1',
    );

AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum
_$adminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnumValueOf(
  String name,
) {
  switch (name) {
    case 'number1':
      return _$adminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum_number1;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum>
_$adminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnumValues =
    BuiltSet<AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum>(
      const <AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum>[
        _$adminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum_number1,
      ],
    );

Serializer<AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum>
_$adminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnumSerializer =
    _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnumSerializer();

class _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnumSerializer
    implements
        PrimitiveSerializer<
          AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum
        > {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number1': 1,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    1: 'number1',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum,
  ];
  @override
  final String wireName =
      'AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf2
    extends AdminBulkImportStudents200ResponseErrorsInnerAnyOf2 {
  @override
  final AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum row;
  @override
  final String error;

  factory _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf2([
    void Function(AdminBulkImportStudents200ResponseErrorsInnerAnyOf2Builder)?
    updates,
  ]) =>
      (AdminBulkImportStudents200ResponseErrorsInnerAnyOf2Builder()
            ..update(updates))
          ._build();

  _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf2._({
    required this.row,
    required this.error,
  }) : super._();
  @override
  AdminBulkImportStudents200ResponseErrorsInnerAnyOf2 rebuild(
    void Function(AdminBulkImportStudents200ResponseErrorsInnerAnyOf2Builder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminBulkImportStudents200ResponseErrorsInnerAnyOf2Builder toBuilder() =>
      AdminBulkImportStudents200ResponseErrorsInnerAnyOf2Builder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminBulkImportStudents200ResponseErrorsInnerAnyOf2 &&
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
            r'AdminBulkImportStudents200ResponseErrorsInnerAnyOf2',
          )
          ..add('row', row)
          ..add('error', error))
        .toString();
  }
}

class AdminBulkImportStudents200ResponseErrorsInnerAnyOf2Builder
    implements
        Builder<
          AdminBulkImportStudents200ResponseErrorsInnerAnyOf2,
          AdminBulkImportStudents200ResponseErrorsInnerAnyOf2Builder
        > {
  _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf2? _$v;

  AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum? _row;
  AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum? get row =>
      _$this._row;
  set row(AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum? row) =>
      _$this._row = row;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  AdminBulkImportStudents200ResponseErrorsInnerAnyOf2Builder() {
    AdminBulkImportStudents200ResponseErrorsInnerAnyOf2._defaults(this);
  }

  AdminBulkImportStudents200ResponseErrorsInnerAnyOf2Builder get _$this {
    final $v = _$v;
    if ($v != null) {
      _row = $v.row;
      _error = $v.error;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminBulkImportStudents200ResponseErrorsInnerAnyOf2 other) {
    _$v = other as _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf2;
  }

  @override
  void update(
    void Function(AdminBulkImportStudents200ResponseErrorsInnerAnyOf2Builder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminBulkImportStudents200ResponseErrorsInnerAnyOf2 build() => _build();

  _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf2 _build() {
    final _$result =
        _$v ??
        _$AdminBulkImportStudents200ResponseErrorsInnerAnyOf2._(
          row: BuiltValueNullFieldError.checkNotNull(
            row,
            r'AdminBulkImportStudents200ResponseErrorsInnerAnyOf2',
            'row',
          ),
          error: BuiltValueNullFieldError.checkNotNull(
            error,
            r'AdminBulkImportStudents200ResponseErrorsInnerAnyOf2',
            'error',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
