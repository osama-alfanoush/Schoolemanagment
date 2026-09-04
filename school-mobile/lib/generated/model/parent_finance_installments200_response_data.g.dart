// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_finance_installments200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentFinanceInstallments200ResponseData
    extends ParentFinanceInstallments200ResponseData {
  @override
  final int studentUserId;
  @override
  final BuiltList<JsonObject?> plans;

  factory _$ParentFinanceInstallments200ResponseData([
    void Function(ParentFinanceInstallments200ResponseDataBuilder)? updates,
  ]) => (ParentFinanceInstallments200ResponseDataBuilder()..update(updates))
      ._build();

  _$ParentFinanceInstallments200ResponseData._({
    required this.studentUserId,
    required this.plans,
  }) : super._();
  @override
  ParentFinanceInstallments200ResponseData rebuild(
    void Function(ParentFinanceInstallments200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentFinanceInstallments200ResponseDataBuilder toBuilder() =>
      ParentFinanceInstallments200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentFinanceInstallments200ResponseData &&
        studentUserId == other.studentUserId &&
        plans == other.plans;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, plans.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ParentFinanceInstallments200ResponseData',
          )
          ..add('studentUserId', studentUserId)
          ..add('plans', plans))
        .toString();
  }
}

class ParentFinanceInstallments200ResponseDataBuilder
    implements
        Builder<
          ParentFinanceInstallments200ResponseData,
          ParentFinanceInstallments200ResponseDataBuilder
        > {
  _$ParentFinanceInstallments200ResponseData? _$v;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  ListBuilder<JsonObject?>? _plans;
  ListBuilder<JsonObject?> get plans =>
      _$this._plans ??= ListBuilder<JsonObject?>();
  set plans(ListBuilder<JsonObject?>? plans) => _$this._plans = plans;

  ParentFinanceInstallments200ResponseDataBuilder() {
    ParentFinanceInstallments200ResponseData._defaults(this);
  }

  ParentFinanceInstallments200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentUserId = $v.studentUserId;
      _plans = $v.plans.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentFinanceInstallments200ResponseData other) {
    _$v = other as _$ParentFinanceInstallments200ResponseData;
  }

  @override
  void update(
    void Function(ParentFinanceInstallments200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentFinanceInstallments200ResponseData build() => _build();

  _$ParentFinanceInstallments200ResponseData _build() {
    _$ParentFinanceInstallments200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$ParentFinanceInstallments200ResponseData._(
            studentUserId: BuiltValueNullFieldError.checkNotNull(
              studentUserId,
              r'ParentFinanceInstallments200ResponseData',
              'studentUserId',
            ),
            plans: plans.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'plans';
        plans.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentFinanceInstallments200ResponseData',
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
