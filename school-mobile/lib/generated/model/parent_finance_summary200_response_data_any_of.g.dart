// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_finance_summary200_response_data_any_of.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentFinanceSummary200ResponseDataAnyOf
    extends ParentFinanceSummary200ResponseDataAnyOf {
  @override
  final BuiltList<ParentFinanceSummary200ResponseDataAnyOfChildrenInner>
  children;
  @override
  final ParentFinanceSummary200ResponseDataAnyOfTotal total;
  @override
  final ParentFinanceSummary200ResponseDataAnyOfTotal totalOutstanding;
  @override
  final int overdueCount;

  factory _$ParentFinanceSummary200ResponseDataAnyOf([
    void Function(ParentFinanceSummary200ResponseDataAnyOfBuilder)? updates,
  ]) => (ParentFinanceSummary200ResponseDataAnyOfBuilder()..update(updates))
      ._build();

  _$ParentFinanceSummary200ResponseDataAnyOf._({
    required this.children,
    required this.total,
    required this.totalOutstanding,
    required this.overdueCount,
  }) : super._();
  @override
  ParentFinanceSummary200ResponseDataAnyOf rebuild(
    void Function(ParentFinanceSummary200ResponseDataAnyOfBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentFinanceSummary200ResponseDataAnyOfBuilder toBuilder() =>
      ParentFinanceSummary200ResponseDataAnyOfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentFinanceSummary200ResponseDataAnyOf &&
        children == other.children &&
        total == other.total &&
        totalOutstanding == other.totalOutstanding &&
        overdueCount == other.overdueCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, children.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, totalOutstanding.hashCode);
    _$hash = $jc(_$hash, overdueCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ParentFinanceSummary200ResponseDataAnyOf',
          )
          ..add('children', children)
          ..add('total', total)
          ..add('totalOutstanding', totalOutstanding)
          ..add('overdueCount', overdueCount))
        .toString();
  }
}

class ParentFinanceSummary200ResponseDataAnyOfBuilder
    implements
        Builder<
          ParentFinanceSummary200ResponseDataAnyOf,
          ParentFinanceSummary200ResponseDataAnyOfBuilder
        > {
  _$ParentFinanceSummary200ResponseDataAnyOf? _$v;

  ListBuilder<ParentFinanceSummary200ResponseDataAnyOfChildrenInner>? _children;
  ListBuilder<ParentFinanceSummary200ResponseDataAnyOfChildrenInner>
  get children => _$this._children ??=
      ListBuilder<ParentFinanceSummary200ResponseDataAnyOfChildrenInner>();
  set children(
    ListBuilder<ParentFinanceSummary200ResponseDataAnyOfChildrenInner>?
    children,
  ) => _$this._children = children;

  ParentFinanceSummary200ResponseDataAnyOfTotalBuilder? _total;
  ParentFinanceSummary200ResponseDataAnyOfTotalBuilder get total =>
      _$this._total ??= ParentFinanceSummary200ResponseDataAnyOfTotalBuilder();
  set total(ParentFinanceSummary200ResponseDataAnyOfTotalBuilder? total) =>
      _$this._total = total;

  ParentFinanceSummary200ResponseDataAnyOfTotalBuilder? _totalOutstanding;
  ParentFinanceSummary200ResponseDataAnyOfTotalBuilder get totalOutstanding =>
      _$this._totalOutstanding ??=
          ParentFinanceSummary200ResponseDataAnyOfTotalBuilder();
  set totalOutstanding(
    ParentFinanceSummary200ResponseDataAnyOfTotalBuilder? totalOutstanding,
  ) => _$this._totalOutstanding = totalOutstanding;

  int? _overdueCount;
  int? get overdueCount => _$this._overdueCount;
  set overdueCount(int? overdueCount) => _$this._overdueCount = overdueCount;

  ParentFinanceSummary200ResponseDataAnyOfBuilder() {
    ParentFinanceSummary200ResponseDataAnyOf._defaults(this);
  }

  ParentFinanceSummary200ResponseDataAnyOfBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _children = $v.children.toBuilder();
      _total = $v.total.toBuilder();
      _totalOutstanding = $v.totalOutstanding.toBuilder();
      _overdueCount = $v.overdueCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentFinanceSummary200ResponseDataAnyOf other) {
    _$v = other as _$ParentFinanceSummary200ResponseDataAnyOf;
  }

  @override
  void update(
    void Function(ParentFinanceSummary200ResponseDataAnyOfBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentFinanceSummary200ResponseDataAnyOf build() => _build();

  _$ParentFinanceSummary200ResponseDataAnyOf _build() {
    _$ParentFinanceSummary200ResponseDataAnyOf _$result;
    try {
      _$result =
          _$v ??
          _$ParentFinanceSummary200ResponseDataAnyOf._(
            children: children.build(),
            total: total.build(),
            totalOutstanding: totalOutstanding.build(),
            overdueCount: BuiltValueNullFieldError.checkNotNull(
              overdueCount,
              r'ParentFinanceSummary200ResponseDataAnyOf',
              'overdueCount',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'children';
        children.build();
        _$failedField = 'total';
        total.build();
        _$failedField = 'totalOutstanding';
        totalOutstanding.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentFinanceSummary200ResponseDataAnyOf',
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
