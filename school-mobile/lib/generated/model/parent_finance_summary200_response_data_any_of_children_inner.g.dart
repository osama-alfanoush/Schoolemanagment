// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_finance_summary200_response_data_any_of_children_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentFinanceSummary200ResponseDataAnyOfChildrenInner
    extends ParentFinanceSummary200ResponseDataAnyOfChildrenInner {
  @override
  final int studentUserId;
  @override
  final String name;
  @override
  final ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled billed;
  @override
  final ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid paid;
  @override
  final ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding
  outstanding;
  @override
  final ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid overdue;
  @override
  final String overdueCount;

  factory _$ParentFinanceSummary200ResponseDataAnyOfChildrenInner([
    void Function(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBuilder)?
    updates,
  ]) =>
      (ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBuilder()
            ..update(updates))
          ._build();

  _$ParentFinanceSummary200ResponseDataAnyOfChildrenInner._({
    required this.studentUserId,
    required this.name,
    required this.billed,
    required this.paid,
    required this.outstanding,
    required this.overdue,
    required this.overdueCount,
  }) : super._();
  @override
  ParentFinanceSummary200ResponseDataAnyOfChildrenInner rebuild(
    void Function(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBuilder toBuilder() =>
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentFinanceSummary200ResponseDataAnyOfChildrenInner &&
        studentUserId == other.studentUserId &&
        name == other.name &&
        billed == other.billed &&
        paid == other.paid &&
        outstanding == other.outstanding &&
        overdue == other.overdue &&
        overdueCount == other.overdueCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, billed.hashCode);
    _$hash = $jc(_$hash, paid.hashCode);
    _$hash = $jc(_$hash, outstanding.hashCode);
    _$hash = $jc(_$hash, overdue.hashCode);
    _$hash = $jc(_$hash, overdueCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ParentFinanceSummary200ResponseDataAnyOfChildrenInner',
          )
          ..add('studentUserId', studentUserId)
          ..add('name', name)
          ..add('billed', billed)
          ..add('paid', paid)
          ..add('outstanding', outstanding)
          ..add('overdue', overdue)
          ..add('overdueCount', overdueCount))
        .toString();
  }
}

class ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBuilder
    implements
        Builder<
          ParentFinanceSummary200ResponseDataAnyOfChildrenInner,
          ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBuilder
        > {
  _$ParentFinanceSummary200ResponseDataAnyOfChildrenInner? _$v;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledBuilder? _billed;
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledBuilder
  get billed => _$this._billed ??=
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledBuilder();
  set billed(
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledBuilder? billed,
  ) => _$this._billed = billed;

  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder? _paid;
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder get paid =>
      _$this._paid ??=
          ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder();
  set paid(
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder? paid,
  ) => _$this._paid = paid;

  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingBuilder?
  _outstanding;
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingBuilder
  get outstanding => _$this._outstanding ??=
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingBuilder();
  set outstanding(
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingBuilder?
    outstanding,
  ) => _$this._outstanding = outstanding;

  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder? _overdue;
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder
  get overdue => _$this._overdue ??=
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder();
  set overdue(
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder? overdue,
  ) => _$this._overdue = overdue;

  String? _overdueCount;
  String? get overdueCount => _$this._overdueCount;
  set overdueCount(String? overdueCount) => _$this._overdueCount = overdueCount;

  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBuilder() {
    ParentFinanceSummary200ResponseDataAnyOfChildrenInner._defaults(this);
  }

  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentUserId = $v.studentUserId;
      _name = $v.name;
      _billed = $v.billed.toBuilder();
      _paid = $v.paid.toBuilder();
      _outstanding = $v.outstanding.toBuilder();
      _overdue = $v.overdue.toBuilder();
      _overdueCount = $v.overdueCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentFinanceSummary200ResponseDataAnyOfChildrenInner other) {
    _$v = other as _$ParentFinanceSummary200ResponseDataAnyOfChildrenInner;
  }

  @override
  void update(
    void Function(ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentFinanceSummary200ResponseDataAnyOfChildrenInner build() => _build();

  _$ParentFinanceSummary200ResponseDataAnyOfChildrenInner _build() {
    _$ParentFinanceSummary200ResponseDataAnyOfChildrenInner _$result;
    try {
      _$result =
          _$v ??
          _$ParentFinanceSummary200ResponseDataAnyOfChildrenInner._(
            studentUserId: BuiltValueNullFieldError.checkNotNull(
              studentUserId,
              r'ParentFinanceSummary200ResponseDataAnyOfChildrenInner',
              'studentUserId',
            ),
            name: BuiltValueNullFieldError.checkNotNull(
              name,
              r'ParentFinanceSummary200ResponseDataAnyOfChildrenInner',
              'name',
            ),
            billed: billed.build(),
            paid: paid.build(),
            outstanding: outstanding.build(),
            overdue: overdue.build(),
            overdueCount: BuiltValueNullFieldError.checkNotNull(
              overdueCount,
              r'ParentFinanceSummary200ResponseDataAnyOfChildrenInner',
              'overdueCount',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'billed';
        billed.build();
        _$failedField = 'paid';
        paid.build();
        _$failedField = 'outstanding';
        outstanding.build();
        _$failedField = 'overdue';
        overdue.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentFinanceSummary200ResponseDataAnyOfChildrenInner',
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
