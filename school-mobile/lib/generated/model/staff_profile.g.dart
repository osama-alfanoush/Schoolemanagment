// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_profile.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StaffProfile extends StaffProfile {
  @override
  final int id;
  @override
  final int userId;
  @override
  final String? department;
  @override
  final String? position;
  @override
  final DateTime? hireDate;
  @override
  final String? contractType;
  @override
  final DateTime? contractEnd;
  @override
  final String baseSalary;
  @override
  final BuiltList<JsonObject?>? qualifications;
  @override
  final int annualLeaveBalance;
  @override
  final int sickLeaveBalance;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;
  @override
  final String? employeeNo;
  @override
  final int? supervisorUserId;
  @override
  final String? employmentType;
  @override
  final String employmentStatus;
  @override
  final DateTime? terminationDate;
  @override
  final DateTime? contractStart;
  @override
  final int? probationDays;
  @override
  final DateTime? probationEnd;
  @override
  final String? paymentMethod;
  @override
  final String? bankName;
  @override
  final String? bankAccount;
  @override
  final bool socialInsuranceRegistered;
  @override
  final String? socialInsuranceNumber;
  @override
  final DateTime? socialInsuranceStart;
  @override
  final DateTime? socialInsuranceEnd;
  @override
  final String? socialInsuranceSchemeCode;
  @override
  final BuiltList<JsonObject?>? documents;

  factory _$StaffProfile([void Function(StaffProfileBuilder)? updates]) =>
      (StaffProfileBuilder()..update(updates))._build();

  _$StaffProfile._({
    required this.id,
    required this.userId,
    this.department,
    this.position,
    this.hireDate,
    this.contractType,
    this.contractEnd,
    required this.baseSalary,
    this.qualifications,
    required this.annualLeaveBalance,
    required this.sickLeaveBalance,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
    this.employeeNo,
    this.supervisorUserId,
    this.employmentType,
    required this.employmentStatus,
    this.terminationDate,
    this.contractStart,
    this.probationDays,
    this.probationEnd,
    this.paymentMethod,
    this.bankName,
    this.bankAccount,
    required this.socialInsuranceRegistered,
    this.socialInsuranceNumber,
    this.socialInsuranceStart,
    this.socialInsuranceEnd,
    this.socialInsuranceSchemeCode,
    this.documents,
  }) : super._();
  @override
  StaffProfile rebuild(void Function(StaffProfileBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StaffProfileBuilder toBuilder() => StaffProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StaffProfile &&
        id == other.id &&
        userId == other.userId &&
        department == other.department &&
        position == other.position &&
        hireDate == other.hireDate &&
        contractType == other.contractType &&
        contractEnd == other.contractEnd &&
        baseSalary == other.baseSalary &&
        qualifications == other.qualifications &&
        annualLeaveBalance == other.annualLeaveBalance &&
        sickLeaveBalance == other.sickLeaveBalance &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId &&
        employeeNo == other.employeeNo &&
        supervisorUserId == other.supervisorUserId &&
        employmentType == other.employmentType &&
        employmentStatus == other.employmentStatus &&
        terminationDate == other.terminationDate &&
        contractStart == other.contractStart &&
        probationDays == other.probationDays &&
        probationEnd == other.probationEnd &&
        paymentMethod == other.paymentMethod &&
        bankName == other.bankName &&
        bankAccount == other.bankAccount &&
        socialInsuranceRegistered == other.socialInsuranceRegistered &&
        socialInsuranceNumber == other.socialInsuranceNumber &&
        socialInsuranceStart == other.socialInsuranceStart &&
        socialInsuranceEnd == other.socialInsuranceEnd &&
        socialInsuranceSchemeCode == other.socialInsuranceSchemeCode &&
        documents == other.documents;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, department.hashCode);
    _$hash = $jc(_$hash, position.hashCode);
    _$hash = $jc(_$hash, hireDate.hashCode);
    _$hash = $jc(_$hash, contractType.hashCode);
    _$hash = $jc(_$hash, contractEnd.hashCode);
    _$hash = $jc(_$hash, baseSalary.hashCode);
    _$hash = $jc(_$hash, qualifications.hashCode);
    _$hash = $jc(_$hash, annualLeaveBalance.hashCode);
    _$hash = $jc(_$hash, sickLeaveBalance.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, employeeNo.hashCode);
    _$hash = $jc(_$hash, supervisorUserId.hashCode);
    _$hash = $jc(_$hash, employmentType.hashCode);
    _$hash = $jc(_$hash, employmentStatus.hashCode);
    _$hash = $jc(_$hash, terminationDate.hashCode);
    _$hash = $jc(_$hash, contractStart.hashCode);
    _$hash = $jc(_$hash, probationDays.hashCode);
    _$hash = $jc(_$hash, probationEnd.hashCode);
    _$hash = $jc(_$hash, paymentMethod.hashCode);
    _$hash = $jc(_$hash, bankName.hashCode);
    _$hash = $jc(_$hash, bankAccount.hashCode);
    _$hash = $jc(_$hash, socialInsuranceRegistered.hashCode);
    _$hash = $jc(_$hash, socialInsuranceNumber.hashCode);
    _$hash = $jc(_$hash, socialInsuranceStart.hashCode);
    _$hash = $jc(_$hash, socialInsuranceEnd.hashCode);
    _$hash = $jc(_$hash, socialInsuranceSchemeCode.hashCode);
    _$hash = $jc(_$hash, documents.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StaffProfile')
          ..add('id', id)
          ..add('userId', userId)
          ..add('department', department)
          ..add('position', position)
          ..add('hireDate', hireDate)
          ..add('contractType', contractType)
          ..add('contractEnd', contractEnd)
          ..add('baseSalary', baseSalary)
          ..add('qualifications', qualifications)
          ..add('annualLeaveBalance', annualLeaveBalance)
          ..add('sickLeaveBalance', sickLeaveBalance)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId)
          ..add('employeeNo', employeeNo)
          ..add('supervisorUserId', supervisorUserId)
          ..add('employmentType', employmentType)
          ..add('employmentStatus', employmentStatus)
          ..add('terminationDate', terminationDate)
          ..add('contractStart', contractStart)
          ..add('probationDays', probationDays)
          ..add('probationEnd', probationEnd)
          ..add('paymentMethod', paymentMethod)
          ..add('bankName', bankName)
          ..add('bankAccount', bankAccount)
          ..add('socialInsuranceRegistered', socialInsuranceRegistered)
          ..add('socialInsuranceNumber', socialInsuranceNumber)
          ..add('socialInsuranceStart', socialInsuranceStart)
          ..add('socialInsuranceEnd', socialInsuranceEnd)
          ..add('socialInsuranceSchemeCode', socialInsuranceSchemeCode)
          ..add('documents', documents))
        .toString();
  }
}

class StaffProfileBuilder
    implements Builder<StaffProfile, StaffProfileBuilder> {
  _$StaffProfile? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _department;
  String? get department => _$this._department;
  set department(String? department) => _$this._department = department;

  String? _position;
  String? get position => _$this._position;
  set position(String? position) => _$this._position = position;

  DateTime? _hireDate;
  DateTime? get hireDate => _$this._hireDate;
  set hireDate(DateTime? hireDate) => _$this._hireDate = hireDate;

  String? _contractType;
  String? get contractType => _$this._contractType;
  set contractType(String? contractType) => _$this._contractType = contractType;

  DateTime? _contractEnd;
  DateTime? get contractEnd => _$this._contractEnd;
  set contractEnd(DateTime? contractEnd) => _$this._contractEnd = contractEnd;

  String? _baseSalary;
  String? get baseSalary => _$this._baseSalary;
  set baseSalary(String? baseSalary) => _$this._baseSalary = baseSalary;

  ListBuilder<JsonObject?>? _qualifications;
  ListBuilder<JsonObject?> get qualifications =>
      _$this._qualifications ??= ListBuilder<JsonObject?>();
  set qualifications(ListBuilder<JsonObject?>? qualifications) =>
      _$this._qualifications = qualifications;

  int? _annualLeaveBalance;
  int? get annualLeaveBalance => _$this._annualLeaveBalance;
  set annualLeaveBalance(int? annualLeaveBalance) =>
      _$this._annualLeaveBalance = annualLeaveBalance;

  int? _sickLeaveBalance;
  int? get sickLeaveBalance => _$this._sickLeaveBalance;
  set sickLeaveBalance(int? sickLeaveBalance) =>
      _$this._sickLeaveBalance = sickLeaveBalance;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  String? _employeeNo;
  String? get employeeNo => _$this._employeeNo;
  set employeeNo(String? employeeNo) => _$this._employeeNo = employeeNo;

  int? _supervisorUserId;
  int? get supervisorUserId => _$this._supervisorUserId;
  set supervisorUserId(int? supervisorUserId) =>
      _$this._supervisorUserId = supervisorUserId;

  String? _employmentType;
  String? get employmentType => _$this._employmentType;
  set employmentType(String? employmentType) =>
      _$this._employmentType = employmentType;

  String? _employmentStatus;
  String? get employmentStatus => _$this._employmentStatus;
  set employmentStatus(String? employmentStatus) =>
      _$this._employmentStatus = employmentStatus;

  DateTime? _terminationDate;
  DateTime? get terminationDate => _$this._terminationDate;
  set terminationDate(DateTime? terminationDate) =>
      _$this._terminationDate = terminationDate;

  DateTime? _contractStart;
  DateTime? get contractStart => _$this._contractStart;
  set contractStart(DateTime? contractStart) =>
      _$this._contractStart = contractStart;

  int? _probationDays;
  int? get probationDays => _$this._probationDays;
  set probationDays(int? probationDays) =>
      _$this._probationDays = probationDays;

  DateTime? _probationEnd;
  DateTime? get probationEnd => _$this._probationEnd;
  set probationEnd(DateTime? probationEnd) =>
      _$this._probationEnd = probationEnd;

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

  bool? _socialInsuranceRegistered;
  bool? get socialInsuranceRegistered => _$this._socialInsuranceRegistered;
  set socialInsuranceRegistered(bool? socialInsuranceRegistered) =>
      _$this._socialInsuranceRegistered = socialInsuranceRegistered;

  String? _socialInsuranceNumber;
  String? get socialInsuranceNumber => _$this._socialInsuranceNumber;
  set socialInsuranceNumber(String? socialInsuranceNumber) =>
      _$this._socialInsuranceNumber = socialInsuranceNumber;

  DateTime? _socialInsuranceStart;
  DateTime? get socialInsuranceStart => _$this._socialInsuranceStart;
  set socialInsuranceStart(DateTime? socialInsuranceStart) =>
      _$this._socialInsuranceStart = socialInsuranceStart;

  DateTime? _socialInsuranceEnd;
  DateTime? get socialInsuranceEnd => _$this._socialInsuranceEnd;
  set socialInsuranceEnd(DateTime? socialInsuranceEnd) =>
      _$this._socialInsuranceEnd = socialInsuranceEnd;

  String? _socialInsuranceSchemeCode;
  String? get socialInsuranceSchemeCode => _$this._socialInsuranceSchemeCode;
  set socialInsuranceSchemeCode(String? socialInsuranceSchemeCode) =>
      _$this._socialInsuranceSchemeCode = socialInsuranceSchemeCode;

  ListBuilder<JsonObject?>? _documents;
  ListBuilder<JsonObject?> get documents =>
      _$this._documents ??= ListBuilder<JsonObject?>();
  set documents(ListBuilder<JsonObject?>? documents) =>
      _$this._documents = documents;

  StaffProfileBuilder() {
    StaffProfile._defaults(this);
  }

  StaffProfileBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _department = $v.department;
      _position = $v.position;
      _hireDate = $v.hireDate;
      _contractType = $v.contractType;
      _contractEnd = $v.contractEnd;
      _baseSalary = $v.baseSalary;
      _qualifications = $v.qualifications?.toBuilder();
      _annualLeaveBalance = $v.annualLeaveBalance;
      _sickLeaveBalance = $v.sickLeaveBalance;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _employeeNo = $v.employeeNo;
      _supervisorUserId = $v.supervisorUserId;
      _employmentType = $v.employmentType;
      _employmentStatus = $v.employmentStatus;
      _terminationDate = $v.terminationDate;
      _contractStart = $v.contractStart;
      _probationDays = $v.probationDays;
      _probationEnd = $v.probationEnd;
      _paymentMethod = $v.paymentMethod;
      _bankName = $v.bankName;
      _bankAccount = $v.bankAccount;
      _socialInsuranceRegistered = $v.socialInsuranceRegistered;
      _socialInsuranceNumber = $v.socialInsuranceNumber;
      _socialInsuranceStart = $v.socialInsuranceStart;
      _socialInsuranceEnd = $v.socialInsuranceEnd;
      _socialInsuranceSchemeCode = $v.socialInsuranceSchemeCode;
      _documents = $v.documents?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StaffProfile other) {
    _$v = other as _$StaffProfile;
  }

  @override
  void update(void Function(StaffProfileBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StaffProfile build() => _build();

  _$StaffProfile _build() {
    _$StaffProfile _$result;
    try {
      _$result =
          _$v ??
          _$StaffProfile._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'StaffProfile',
              'id',
            ),
            userId: BuiltValueNullFieldError.checkNotNull(
              userId,
              r'StaffProfile',
              'userId',
            ),
            department: department,
            position: position,
            hireDate: hireDate,
            contractType: contractType,
            contractEnd: contractEnd,
            baseSalary: BuiltValueNullFieldError.checkNotNull(
              baseSalary,
              r'StaffProfile',
              'baseSalary',
            ),
            qualifications: _qualifications?.build(),
            annualLeaveBalance: BuiltValueNullFieldError.checkNotNull(
              annualLeaveBalance,
              r'StaffProfile',
              'annualLeaveBalance',
            ),
            sickLeaveBalance: BuiltValueNullFieldError.checkNotNull(
              sickLeaveBalance,
              r'StaffProfile',
              'sickLeaveBalance',
            ),
            createdAt: createdAt,
            updatedAt: updatedAt,
            schoolId: BuiltValueNullFieldError.checkNotNull(
              schoolId,
              r'StaffProfile',
              'schoolId',
            ),
            employeeNo: employeeNo,
            supervisorUserId: supervisorUserId,
            employmentType: employmentType,
            employmentStatus: BuiltValueNullFieldError.checkNotNull(
              employmentStatus,
              r'StaffProfile',
              'employmentStatus',
            ),
            terminationDate: terminationDate,
            contractStart: contractStart,
            probationDays: probationDays,
            probationEnd: probationEnd,
            paymentMethod: paymentMethod,
            bankName: bankName,
            bankAccount: bankAccount,
            socialInsuranceRegistered: BuiltValueNullFieldError.checkNotNull(
              socialInsuranceRegistered,
              r'StaffProfile',
              'socialInsuranceRegistered',
            ),
            socialInsuranceNumber: socialInsuranceNumber,
            socialInsuranceStart: socialInsuranceStart,
            socialInsuranceEnd: socialInsuranceEnd,
            socialInsuranceSchemeCode: socialInsuranceSchemeCode,
            documents: _documents?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'qualifications';
        _qualifications?.build();

        _$failedField = 'documents';
        _documents?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'StaffProfile',
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
