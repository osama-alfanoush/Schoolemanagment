// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_plan.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BudgetPlan extends BudgetPlan {
  @override
  final int id;
  @override
  final int fiscalYear;
  @override
  final String category;
  @override
  final String? subCategory;
  @override
  final String plannedAmount;
  @override
  final String actualAmount;
  @override
  final int createdBy;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;
  @override
  final String variance;
  @override
  final String usagePercent;

  factory _$BudgetPlan([void Function(BudgetPlanBuilder)? updates]) =>
      (BudgetPlanBuilder()..update(updates))._build();

  _$BudgetPlan._({
    required this.id,
    required this.fiscalYear,
    required this.category,
    this.subCategory,
    required this.plannedAmount,
    required this.actualAmount,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
    required this.variance,
    required this.usagePercent,
  }) : super._();
  @override
  BudgetPlan rebuild(void Function(BudgetPlanBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BudgetPlanBuilder toBuilder() => BudgetPlanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BudgetPlan &&
        id == other.id &&
        fiscalYear == other.fiscalYear &&
        category == other.category &&
        subCategory == other.subCategory &&
        plannedAmount == other.plannedAmount &&
        actualAmount == other.actualAmount &&
        createdBy == other.createdBy &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId &&
        variance == other.variance &&
        usagePercent == other.usagePercent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, fiscalYear.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, subCategory.hashCode);
    _$hash = $jc(_$hash, plannedAmount.hashCode);
    _$hash = $jc(_$hash, actualAmount.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, variance.hashCode);
    _$hash = $jc(_$hash, usagePercent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BudgetPlan')
          ..add('id', id)
          ..add('fiscalYear', fiscalYear)
          ..add('category', category)
          ..add('subCategory', subCategory)
          ..add('plannedAmount', plannedAmount)
          ..add('actualAmount', actualAmount)
          ..add('createdBy', createdBy)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId)
          ..add('variance', variance)
          ..add('usagePercent', usagePercent))
        .toString();
  }
}

class BudgetPlanBuilder implements Builder<BudgetPlan, BudgetPlanBuilder> {
  _$BudgetPlan? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _fiscalYear;
  int? get fiscalYear => _$this._fiscalYear;
  set fiscalYear(int? fiscalYear) => _$this._fiscalYear = fiscalYear;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _subCategory;
  String? get subCategory => _$this._subCategory;
  set subCategory(String? subCategory) => _$this._subCategory = subCategory;

  String? _plannedAmount;
  String? get plannedAmount => _$this._plannedAmount;
  set plannedAmount(String? plannedAmount) =>
      _$this._plannedAmount = plannedAmount;

  String? _actualAmount;
  String? get actualAmount => _$this._actualAmount;
  set actualAmount(String? actualAmount) => _$this._actualAmount = actualAmount;

  int? _createdBy;
  int? get createdBy => _$this._createdBy;
  set createdBy(int? createdBy) => _$this._createdBy = createdBy;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  String? _variance;
  String? get variance => _$this._variance;
  set variance(String? variance) => _$this._variance = variance;

  String? _usagePercent;
  String? get usagePercent => _$this._usagePercent;
  set usagePercent(String? usagePercent) => _$this._usagePercent = usagePercent;

  BudgetPlanBuilder() {
    BudgetPlan._defaults(this);
  }

  BudgetPlanBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _fiscalYear = $v.fiscalYear;
      _category = $v.category;
      _subCategory = $v.subCategory;
      _plannedAmount = $v.plannedAmount;
      _actualAmount = $v.actualAmount;
      _createdBy = $v.createdBy;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _variance = $v.variance;
      _usagePercent = $v.usagePercent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BudgetPlan other) {
    _$v = other as _$BudgetPlan;
  }

  @override
  void update(void Function(BudgetPlanBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BudgetPlan build() => _build();

  _$BudgetPlan _build() {
    final _$result =
        _$v ??
        _$BudgetPlan._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'BudgetPlan', 'id'),
          fiscalYear: BuiltValueNullFieldError.checkNotNull(
            fiscalYear,
            r'BudgetPlan',
            'fiscalYear',
          ),
          category: BuiltValueNullFieldError.checkNotNull(
            category,
            r'BudgetPlan',
            'category',
          ),
          subCategory: subCategory,
          plannedAmount: BuiltValueNullFieldError.checkNotNull(
            plannedAmount,
            r'BudgetPlan',
            'plannedAmount',
          ),
          actualAmount: BuiltValueNullFieldError.checkNotNull(
            actualAmount,
            r'BudgetPlan',
            'actualAmount',
          ),
          createdBy: BuiltValueNullFieldError.checkNotNull(
            createdBy,
            r'BudgetPlan',
            'createdBy',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'BudgetPlan',
            'schoolId',
          ),
          variance: BuiltValueNullFieldError.checkNotNull(
            variance,
            r'BudgetPlan',
            'variance',
          ),
          usagePercent: BuiltValueNullFieldError.checkNotNull(
            usagePercent,
            r'BudgetPlan',
            'usagePercent',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
