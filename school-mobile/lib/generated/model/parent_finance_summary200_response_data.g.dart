// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_finance_summary200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentFinanceSummary200ResponseData
    extends ParentFinanceSummary200ResponseData {
  @override
  final AnyOf anyOf;

  factory _$ParentFinanceSummary200ResponseData([
    void Function(ParentFinanceSummary200ResponseDataBuilder)? updates,
  ]) =>
      (ParentFinanceSummary200ResponseDataBuilder()..update(updates))._build();

  _$ParentFinanceSummary200ResponseData._({required this.anyOf}) : super._();
  @override
  ParentFinanceSummary200ResponseData rebuild(
    void Function(ParentFinanceSummary200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentFinanceSummary200ResponseDataBuilder toBuilder() =>
      ParentFinanceSummary200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentFinanceSummary200ResponseData && anyOf == other.anyOf;
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
      r'ParentFinanceSummary200ResponseData',
    )..add('anyOf', anyOf)).toString();
  }
}

class ParentFinanceSummary200ResponseDataBuilder
    implements
        Builder<
          ParentFinanceSummary200ResponseData,
          ParentFinanceSummary200ResponseDataBuilder
        > {
  _$ParentFinanceSummary200ResponseData? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  ParentFinanceSummary200ResponseDataBuilder() {
    ParentFinanceSummary200ResponseData._defaults(this);
  }

  ParentFinanceSummary200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentFinanceSummary200ResponseData other) {
    _$v = other as _$ParentFinanceSummary200ResponseData;
  }

  @override
  void update(
    void Function(ParentFinanceSummary200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentFinanceSummary200ResponseData build() => _build();

  _$ParentFinanceSummary200ResponseData _build() {
    final _$result =
        _$v ??
        _$ParentFinanceSummary200ResponseData._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'ParentFinanceSummary200ResponseData',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
