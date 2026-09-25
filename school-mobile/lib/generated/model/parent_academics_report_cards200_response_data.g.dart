// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_academics_report_cards200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentAcademicsReportCards200ResponseData
    extends ParentAcademicsReportCards200ResponseData {
  @override
  final int studentUserId;
  @override
  final BuiltList<JsonObject?> reportCards;

  factory _$ParentAcademicsReportCards200ResponseData([
    void Function(ParentAcademicsReportCards200ResponseDataBuilder)? updates,
  ]) => (ParentAcademicsReportCards200ResponseDataBuilder()..update(updates))
      ._build();

  _$ParentAcademicsReportCards200ResponseData._({
    required this.studentUserId,
    required this.reportCards,
  }) : super._();
  @override
  ParentAcademicsReportCards200ResponseData rebuild(
    void Function(ParentAcademicsReportCards200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentAcademicsReportCards200ResponseDataBuilder toBuilder() =>
      ParentAcademicsReportCards200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentAcademicsReportCards200ResponseData &&
        studentUserId == other.studentUserId &&
        reportCards == other.reportCards;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, reportCards.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ParentAcademicsReportCards200ResponseData',
          )
          ..add('studentUserId', studentUserId)
          ..add('reportCards', reportCards))
        .toString();
  }
}

class ParentAcademicsReportCards200ResponseDataBuilder
    implements
        Builder<
          ParentAcademicsReportCards200ResponseData,
          ParentAcademicsReportCards200ResponseDataBuilder
        > {
  _$ParentAcademicsReportCards200ResponseData? _$v;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  ListBuilder<JsonObject?>? _reportCards;
  ListBuilder<JsonObject?> get reportCards =>
      _$this._reportCards ??= ListBuilder<JsonObject?>();
  set reportCards(ListBuilder<JsonObject?>? reportCards) =>
      _$this._reportCards = reportCards;

  ParentAcademicsReportCards200ResponseDataBuilder() {
    ParentAcademicsReportCards200ResponseData._defaults(this);
  }

  ParentAcademicsReportCards200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentUserId = $v.studentUserId;
      _reportCards = $v.reportCards.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentAcademicsReportCards200ResponseData other) {
    _$v = other as _$ParentAcademicsReportCards200ResponseData;
  }

  @override
  void update(
    void Function(ParentAcademicsReportCards200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentAcademicsReportCards200ResponseData build() => _build();

  _$ParentAcademicsReportCards200ResponseData _build() {
    _$ParentAcademicsReportCards200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$ParentAcademicsReportCards200ResponseData._(
            studentUserId: BuiltValueNullFieldError.checkNotNull(
              studentUserId,
              r'ParentAcademicsReportCards200ResponseData',
              'studentUserId',
            ),
            reportCards: reportCards.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'reportCards';
        reportCards.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentAcademicsReportCards200ResponseData',
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
