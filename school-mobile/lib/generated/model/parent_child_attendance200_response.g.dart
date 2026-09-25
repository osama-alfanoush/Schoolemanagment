// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_child_attendance200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentChildAttendance200Response
    extends ParentChildAttendance200Response {
  @override
  final ParentChildAttendance200ResponseRecords records;
  @override
  final BuiltList<JsonObject?> monthlySummary;

  factory _$ParentChildAttendance200Response([
    void Function(ParentChildAttendance200ResponseBuilder)? updates,
  ]) => (ParentChildAttendance200ResponseBuilder()..update(updates))._build();

  _$ParentChildAttendance200Response._({
    required this.records,
    required this.monthlySummary,
  }) : super._();
  @override
  ParentChildAttendance200Response rebuild(
    void Function(ParentChildAttendance200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentChildAttendance200ResponseBuilder toBuilder() =>
      ParentChildAttendance200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentChildAttendance200Response &&
        records == other.records &&
        monthlySummary == other.monthlySummary;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, records.hashCode);
    _$hash = $jc(_$hash, monthlySummary.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParentChildAttendance200Response')
          ..add('records', records)
          ..add('monthlySummary', monthlySummary))
        .toString();
  }
}

class ParentChildAttendance200ResponseBuilder
    implements
        Builder<
          ParentChildAttendance200Response,
          ParentChildAttendance200ResponseBuilder
        > {
  _$ParentChildAttendance200Response? _$v;

  ParentChildAttendance200ResponseRecordsBuilder? _records;
  ParentChildAttendance200ResponseRecordsBuilder get records =>
      _$this._records ??= ParentChildAttendance200ResponseRecordsBuilder();
  set records(ParentChildAttendance200ResponseRecordsBuilder? records) =>
      _$this._records = records;

  ListBuilder<JsonObject?>? _monthlySummary;
  ListBuilder<JsonObject?> get monthlySummary =>
      _$this._monthlySummary ??= ListBuilder<JsonObject?>();
  set monthlySummary(ListBuilder<JsonObject?>? monthlySummary) =>
      _$this._monthlySummary = monthlySummary;

  ParentChildAttendance200ResponseBuilder() {
    ParentChildAttendance200Response._defaults(this);
  }

  ParentChildAttendance200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _records = $v.records.toBuilder();
      _monthlySummary = $v.monthlySummary.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentChildAttendance200Response other) {
    _$v = other as _$ParentChildAttendance200Response;
  }

  @override
  void update(void Function(ParentChildAttendance200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentChildAttendance200Response build() => _build();

  _$ParentChildAttendance200Response _build() {
    _$ParentChildAttendance200Response _$result;
    try {
      _$result =
          _$v ??
          _$ParentChildAttendance200Response._(
            records: records.build(),
            monthlySummary: monthlySummary.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'records';
        records.build();
        _$failedField = 'monthlySummary';
        monthlySummary.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentChildAttendance200Response',
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
