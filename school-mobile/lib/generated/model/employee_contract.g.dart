// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_contract.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EmployeeContract extends EmployeeContract {
  @override
  final int id;
  @override
  final int staffProfileId;
  @override
  final int schoolId;
  @override
  final String contractNo;
  @override
  final String contractType;
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  final int? probationDays;
  @override
  final DateTime? probationEnd;
  @override
  final String baseSalary;
  @override
  final String? paymentMethod;
  @override
  final String? bankName;
  @override
  final String? bankAccount;
  @override
  final String status;
  @override
  final bool isCurrent;
  @override
  final int? renewedFromId;
  @override
  final BuiltList<JsonObject?>? attachments;
  @override
  final String? notes;
  @override
  final int? createdBy;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String daysRemaining;
  @override
  final String durationDays;
  @override
  final String displayStatus;

  factory _$EmployeeContract([
    void Function(EmployeeContractBuilder)? updates,
  ]) => (EmployeeContractBuilder()..update(updates))._build();

  _$EmployeeContract._({
    required this.id,
    required this.staffProfileId,
    required this.schoolId,
    required this.contractNo,
    required this.contractType,
    required this.startDate,
    this.endDate,
    this.probationDays,
    this.probationEnd,
    required this.baseSalary,
    this.paymentMethod,
    this.bankName,
    this.bankAccount,
    required this.status,
    required this.isCurrent,
    this.renewedFromId,
    this.attachments,
    this.notes,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    required this.daysRemaining,
    required this.durationDays,
    required this.displayStatus,
  }) : super._();
  @override
  EmployeeContract rebuild(void Function(EmployeeContractBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EmployeeContractBuilder toBuilder() =>
      EmployeeContractBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EmployeeContract &&
        id == other.id &&
        staffProfileId == other.staffProfileId &&
        schoolId == other.schoolId &&
        contractNo == other.contractNo &&
        contractType == other.contractType &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        probationDays == other.probationDays &&
        probationEnd == other.probationEnd &&
        baseSalary == other.baseSalary &&
        paymentMethod == other.paymentMethod &&
        bankName == other.bankName &&
        bankAccount == other.bankAccount &&
        status == other.status &&
        isCurrent == other.isCurrent &&
        renewedFromId == other.renewedFromId &&
        attachments == other.attachments &&
        notes == other.notes &&
        createdBy == other.createdBy &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        daysRemaining == other.daysRemaining &&
        durationDays == other.durationDays &&
        displayStatus == other.displayStatus;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, staffProfileId.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, contractNo.hashCode);
    _$hash = $jc(_$hash, contractType.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jc(_$hash, probationDays.hashCode);
    _$hash = $jc(_$hash, probationEnd.hashCode);
    _$hash = $jc(_$hash, baseSalary.hashCode);
    _$hash = $jc(_$hash, paymentMethod.hashCode);
    _$hash = $jc(_$hash, bankName.hashCode);
    _$hash = $jc(_$hash, bankAccount.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, isCurrent.hashCode);
    _$hash = $jc(_$hash, renewedFromId.hashCode);
    _$hash = $jc(_$hash, attachments.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, daysRemaining.hashCode);
    _$hash = $jc(_$hash, durationDays.hashCode);
    _$hash = $jc(_$hash, displayStatus.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EmployeeContract')
          ..add('id', id)
          ..add('staffProfileId', staffProfileId)
          ..add('schoolId', schoolId)
          ..add('contractNo', contractNo)
          ..add('contractType', contractType)
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('probationDays', probationDays)
          ..add('probationEnd', probationEnd)
          ..add('baseSalary', baseSalary)
          ..add('paymentMethod', paymentMethod)
          ..add('bankName', bankName)
          ..add('bankAccount', bankAccount)
          ..add('status', status)
          ..add('isCurrent', isCurrent)
          ..add('renewedFromId', renewedFromId)
          ..add('attachments', attachments)
          ..add('notes', notes)
          ..add('createdBy', createdBy)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('daysRemaining', daysRemaining)
          ..add('durationDays', durationDays)
          ..add('displayStatus', displayStatus))
        .toString();
  }
}

class EmployeeContractBuilder
    implements Builder<EmployeeContract, EmployeeContractBuilder> {
  _$EmployeeContract? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _staffProfileId;
  int? get staffProfileId => _$this._staffProfileId;
  set staffProfileId(int? staffProfileId) =>
      _$this._staffProfileId = staffProfileId;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  String? _contractNo;
  String? get contractNo => _$this._contractNo;
  set contractNo(String? contractNo) => _$this._contractNo = contractNo;

  String? _contractType;
  String? get contractType => _$this._contractType;
  set contractType(String? contractType) => _$this._contractType = contractType;

  DateTime? _startDate;
  DateTime? get startDate => _$this._startDate;
  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  DateTime? _endDate;
  DateTime? get endDate => _$this._endDate;
  set endDate(DateTime? endDate) => _$this._endDate = endDate;

  int? _probationDays;
  int? get probationDays => _$this._probationDays;
  set probationDays(int? probationDays) =>
      _$this._probationDays = probationDays;

  DateTime? _probationEnd;
  DateTime? get probationEnd => _$this._probationEnd;
  set probationEnd(DateTime? probationEnd) =>
      _$this._probationEnd = probationEnd;

  String? _baseSalary;
  String? get baseSalary => _$this._baseSalary;
  set baseSalary(String? baseSalary) => _$this._baseSalary = baseSalary;

  String? _paymentMethod;
  String? get paymentMethod => _$this._paymentMethod;
  set paymentMethod(String? paymentMethod) =>
      _$this._paymentMethod = paymentMethod;

  String? _bankName;
  String? get bankName => _$this._bankName;
  set bankName(String? bankName) => _$this._bankName = bankName;

  String? _bankAccount;
  String? get bankAccount => _$this._bankAccount;
  set bankAccount(String? bankAccount) => _$this._bankAccount = bankAccount;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  bool? _isCurrent;
  bool? get isCurrent => _$this._isCurrent;
  set isCurrent(bool? isCurrent) => _$this._isCurrent = isCurrent;

  int? _renewedFromId;
  int? get renewedFromId => _$this._renewedFromId;
  set renewedFromId(int? renewedFromId) =>
      _$this._renewedFromId = renewedFromId;

  ListBuilder<JsonObject?>? _attachments;
  ListBuilder<JsonObject?> get attachments =>
      _$this._attachments ??= ListBuilder<JsonObject?>();
  set attachments(ListBuilder<JsonObject?>? attachments) =>
      _$this._attachments = attachments;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  int? _createdBy;
  int? get createdBy => _$this._createdBy;
  set createdBy(int? createdBy) => _$this._createdBy = createdBy;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _daysRemaining;
  String? get daysRemaining => _$this._daysRemaining;
  set daysRemaining(String? daysRemaining) =>
      _$this._daysRemaining = daysRemaining;

  String? _durationDays;
  String? get durationDays => _$this._durationDays;
  set durationDays(String? durationDays) => _$this._durationDays = durationDays;

  String? _displayStatus;
  String? get displayStatus => _$this._displayStatus;
  set displayStatus(String? displayStatus) =>
      _$this._displayStatus = displayStatus;

  EmployeeContractBuilder() {
    EmployeeContract._defaults(this);
  }

  EmployeeContractBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _staffProfileId = $v.staffProfileId;
      _schoolId = $v.schoolId;
      _contractNo = $v.contractNo;
      _contractType = $v.contractType;
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _probationDays = $v.probationDays;
      _probationEnd = $v.probationEnd;
      _baseSalary = $v.baseSalary;
      _paymentMethod = $v.paymentMethod;
      _bankName = $v.bankName;
      _bankAccount = $v.bankAccount;
      _status = $v.status;
      _isCurrent = $v.isCurrent;
      _renewedFromId = $v.renewedFromId;
      _attachments = $v.attachments?.toBuilder();
      _notes = $v.notes;
      _createdBy = $v.createdBy;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _daysRemaining = $v.daysRemaining;
      _durationDays = $v.durationDays;
      _displayStatus = $v.displayStatus;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EmployeeContract other) {
    _$v = other as _$EmployeeContract;
  }

  @override
  void update(void Function(EmployeeContractBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EmployeeContract build() => _build();

  _$EmployeeContract _build() {
    _$EmployeeContract _$result;
    try {
      _$result =
          _$v ??
          _$EmployeeContract._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'EmployeeContract',
              'id',
            ),
            staffProfileId: BuiltValueNullFieldError.checkNotNull(
              staffProfileId,
              r'EmployeeContract',
              'staffProfileId',
            ),
            schoolId: BuiltValueNullFieldError.checkNotNull(
              schoolId,
              r'EmployeeContract',
              'schoolId',
            ),
            contractNo: BuiltValueNullFieldError.checkNotNull(
              contractNo,
              r'EmployeeContract',
              'contractNo',
            ),
            contractType: BuiltValueNullFieldError.checkNotNull(
              contractType,
              r'EmployeeContract',
              'contractType',
            ),
            startDate: BuiltValueNullFieldError.checkNotNull(
              startDate,
              r'EmployeeContract',
              'startDate',
            ),
            endDate: endDate,
            probationDays: probationDays,
            probationEnd: probationEnd,
            baseSalary: BuiltValueNullFieldError.checkNotNull(
              baseSalary,
              r'EmployeeContract',
              'baseSalary',
            ),
            paymentMethod: paymentMethod,
            bankName: bankName,
            bankAccount: bankAccount,
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'EmployeeContract',
              'status',
            ),
            isCurrent: BuiltValueNullFieldError.checkNotNull(
              isCurrent,
              r'EmployeeContract',
              'isCurrent',
            ),
            renewedFromId: renewedFromId,
            attachments: _attachments?.build(),
            notes: notes,
            createdBy: createdBy,
            createdAt: createdAt,
            updatedAt: updatedAt,
            daysRemaining: BuiltValueNullFieldError.checkNotNull(
              daysRemaining,
              r'EmployeeContract',
              'daysRemaining',
            ),
            durationDays: BuiltValueNullFieldError.checkNotNull(
              durationDays,
              r'EmployeeContract',
              'durationDays',
            ),
            displayStatus: BuiltValueNullFieldError.checkNotNull(
              displayStatus,
              r'EmployeeContract',
              'displayStatus',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'attachments';
        _attachments?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'EmployeeContract',
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
