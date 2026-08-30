// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_bulk_import_students200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminBulkImportStudents200Response
    extends AdminBulkImportStudents200Response {
  @override
  final int created;
  @override
  final BuiltList<AdminBulkImportStudents200ResponseErrorsInner> errors;

  factory _$AdminBulkImportStudents200Response([
    void Function(AdminBulkImportStudents200ResponseBuilder)? updates,
  ]) => (AdminBulkImportStudents200ResponseBuilder()..update(updates))._build();

  _$AdminBulkImportStudents200Response._({
    required this.created,
    required this.errors,
  }) : super._();
  @override
  AdminBulkImportStudents200Response rebuild(
    void Function(AdminBulkImportStudents200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminBulkImportStudents200ResponseBuilder toBuilder() =>
      AdminBulkImportStudents200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminBulkImportStudents200Response &&
        created == other.created &&
        errors == other.errors;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, created.hashCode);
    _$hash = $jc(_$hash, errors.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminBulkImportStudents200Response')
          ..add('created', created)
          ..add('errors', errors))
        .toString();
  }
}

class AdminBulkImportStudents200ResponseBuilder
    implements
        Builder<
          AdminBulkImportStudents200Response,
          AdminBulkImportStudents200ResponseBuilder
        > {
  _$AdminBulkImportStudents200Response? _$v;

  int? _created;
  int? get created => _$this._created;
  set created(int? created) => _$this._created = created;

  ListBuilder<AdminBulkImportStudents200ResponseErrorsInner>? _errors;
  ListBuilder<AdminBulkImportStudents200ResponseErrorsInner> get errors =>
      _$this._errors ??=
          ListBuilder<AdminBulkImportStudents200ResponseErrorsInner>();
  set errors(
    ListBuilder<AdminBulkImportStudents200ResponseErrorsInner>? errors,
  ) => _$this._errors = errors;

  AdminBulkImportStudents200ResponseBuilder() {
    AdminBulkImportStudents200Response._defaults(this);
  }

  AdminBulkImportStudents200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _created = $v.created;
      _errors = $v.errors.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminBulkImportStudents200Response other) {
    _$v = other as _$AdminBulkImportStudents200Response;
  }

  @override
  void update(
    void Function(AdminBulkImportStudents200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminBulkImportStudents200Response build() => _build();

  _$AdminBulkImportStudents200Response _build() {
    _$AdminBulkImportStudents200Response _$result;
    try {
      _$result =
          _$v ??
          _$AdminBulkImportStudents200Response._(
            created: BuiltValueNullFieldError.checkNotNull(
              created,
              r'AdminBulkImportStudents200Response',
              'created',
            ),
            errors: errors.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'errors';
        errors.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminBulkImportStudents200Response',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
