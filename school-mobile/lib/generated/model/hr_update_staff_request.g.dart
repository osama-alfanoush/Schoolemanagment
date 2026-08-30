// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_update_staff_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrUpdateStaffRequestEmploymentStatusEnum
_$hrUpdateStaffRequestEmploymentStatusEnum_active =
    const HrUpdateStaffRequestEmploymentStatusEnum._('active');
const HrUpdateStaffRequestEmploymentStatusEnum
_$hrUpdateStaffRequestEmploymentStatusEnum_suspended =
    const HrUpdateStaffRequestEmploymentStatusEnum._('suspended');
const HrUpdateStaffRequestEmploymentStatusEnum
_$hrUpdateStaffRequestEmploymentStatusEnum_onLeave =
    const HrUpdateStaffRequestEmploymentStatusEnum._('onLeave');
const HrUpdateStaffRequestEmploymentStatusEnum
_$hrUpdateStaffRequestEmploymentStatusEnum_terminated =
    const HrUpdateStaffRequestEmploymentStatusEnum._('terminated');

HrUpdateStaffRequestEmploymentStatusEnum
_$hrUpdateStaffRequestEmploymentStatusEnumValueOf(String name) {
  switch (name) {
    case 'active':
      return _$hrUpdateStaffRequestEmploymentStatusEnum_active;
    case 'suspended':
      return _$hrUpdateStaffRequestEmploymentStatusEnum_suspended;
    case 'onLeave':
      return _$hrUpdateStaffRequestEmploymentStatusEnum_onLeave;
    case 'terminated':
      return _$hrUpdateStaffRequestEmploymentStatusEnum_terminated;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrUpdateStaffRequestEmploymentStatusEnum>
_$hrUpdateStaffRequestEmploymentStatusEnumValues =
    BuiltSet<HrUpdateStaffRequestEmploymentStatusEnum>(
      const <HrUpdateStaffRequestEmploymentStatusEnum>[
        _$hrUpdateStaffRequestEmploymentStatusEnum_active,
        _$hrUpdateStaffRequestEmploymentStatusEnum_suspended,
        _$hrUpdateStaffRequestEmploymentStatusEnum_onLeave,
        _$hrUpdateStaffRequestEmploymentStatusEnum_terminated,
      ],
    );

Serializer<HrUpdateStaffRequestEmploymentStatusEnum>
_$hrUpdateStaffRequestEmploymentStatusEnumSerializer =
    _$HrUpdateStaffRequestEmploymentStatusEnumSerializer();

class _$HrUpdateStaffRequestEmploymentStatusEnumSerializer
    implements PrimitiveSerializer<HrUpdateStaffRequestEmploymentStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'active': 'active',
    'suspended': 'suspended',
    'onLeave': 'on_leave',
    'terminated': 'terminated',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'active': 'active',
    'suspended': 'suspended',
    'on_leave': 'onLeave',
    'terminated': 'terminated',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrUpdateStaffRequestEmploymentStatusEnum,
  ];
  @override
  final String wireName = 'HrUpdateStaffRequestEmploymentStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrUpdateStaffRequestEmploymentStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrUpdateStaffRequestEmploymentStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrUpdateStaffRequestEmploymentStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrUpdateStaffRequest extends HrUpdateStaffRequest {
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
  final num? baseSalary;
  @override
  final BuiltList<String>? qualifications;
  @override
  final int? annualLeaveBalance;
  @override
  final int? sickLeaveBalance;
  @override
  final String? employeeNo;
  @override
  final int? supervisorUserId;
  @override
  final String? employmentType;
  @override
  final HrUpdateStaffRequestEmploymentStatusEnum? employmentStatus;
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
  final bool? socialInsuranceRegistered;
  @override
  final String? socialInsuranceNumber;
  @override
  final DateTime? socialInsuranceStart;
  @override
  final DateTime? socialInsuranceEnd;
  @override
  final String? socialInsuranceSchemeCode;
  @override
  final BuiltList<String>? documents;
  @override
  final String? reason;

  factory _$HrUpdateStaffRequest([
    void Function(HrUpdateStaffRequestBuilder)? updates,
  ]) => (HrUpdateStaffRequestBuilder()..update(updates))._build();

  _$HrUpdateStaffRequest._({
    this.department,
    this.position,
    this.hireDate,
    this.contractType,
    this.contractEnd,
    this.baseSalary,
    this.qualifications,
    this.annualLeaveBalance,
    this.sickLeaveBalance,
    this.employeeNo,
    this.supervisorUserId,
    this.employmentType,
    this.employmentStatus,
    this.terminationDate,
    this.contractStart,
    this.probationDays,
    this.probationEnd,
    this.paymentMethod,
    this.bankName,
    this.bankAccount,
    this.socialInsuranceRegistered,
    this.socialInsuranceNumber,
    this.socialInsuranceStart,
    this.socialInsuranceEnd,
    this.socialInsuranceSchemeCode,
    this.documents,
    this.reason,
  }) : super._();
  @override
  HrUpdateStaffRequest rebuild(
    void Function(HrUpdateStaffRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrUpdateStaffRequestBuilder toBuilder() =>
      HrUpdateStaffRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrUpdateStaffRequest &&
        department == other.department &&
        position == other.position &&
        hireDate == other.hireDate &&
        contractType == other.contractType &&
        contractEnd == other.contractEnd &&
        baseSalary == other.baseSalary &&
        qualifications == other.qualifications &&
        annualLeaveBalance == other.annualLeaveBalance &&
        sickLeaveBalance == other.sickLeaveBalance &&
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
        documents == other.documents &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, department.hashCode);
    _$hash = $jc(_$hash, position.hashCode);
    _$hash = $jc(_$hash, hireDate.hashCode);
    _$hash = $jc(_$hash, contractType.hashCode);
    _$hash = $jc(_$hash, contractEnd.hashCode);
    _$hash = $jc(_$hash, baseSalary.hashCode);
    _$hash = $jc(_$hash, qualifications.hashCode);
    _$hash = $jc(_$hash, annualLeaveBalance.hashCode);
    _$hash = $jc(_$hash, sickLeaveBalance.hashCode);
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
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HrUpdateStaffRequest')
          ..add('department', department)
          ..add('position', position)
          ..add('hireDate', hireDate)
          ..add('contractType', contractType)
          ..add('contractEnd', contractEnd)
          ..add('baseSalary', baseSalary)
          ..add('qualifications', qualifications)
          ..add('annualLeaveBalance', annualLeaveBalance)
          ..add('sickLeaveBalance', sickLeaveBalance)
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
          ..add('documents', documents)
          ..add('reason', reason))
        .toString();
  }
}

class HrUpdateStaffRequestBuilder
    implements Builder<HrUpdateStaffRequest, HrUpdateStaffRequestBuilder> {
  _$HrUpdateStaffRequest? _$v;

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

  num? _baseSalary;
  num? get baseSalary => _$this._baseSalary;
  set baseSalary(num? baseSalary) => _$this._baseSalary = baseSalary;

  ListBuilder<String>? _qualifications;
  ListBuilder<String> get qualifications =>
      _$this._qualifications ??= ListBuilder<String>();
  set qualifications(ListBuilder<String>? qualifications) =>
      _$this._qualifications = qualifications;

  int? _annualLeaveBalance;
  int? get annualLeaveBalance => _$this._annualLeaveBalance;
  set annualLeaveBalance(int? annualLeaveBalance) =>
      _$this._annualLeaveBalance = annualLeaveBalance;

  int? _sickLeaveBalance;
  int? get sickLeaveBalance => _$this._sickLeaveBalance;
  set sickLeaveBalance(int? sickLeaveBalance) =>
      _$this._sickLeaveBalance = sickLeaveBalance;

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

  HrUpdateStaffRequestEmploymentStatusEnum? _employmentStatus;
  HrUpdateStaffRequestEmploymentStatusEnum? get employmentStatus =>
      _$this._employmentStatus;
  set employmentStatus(
    HrUpdateStaffRequestEmploymentStatusEnum? employmentStatus,
  ) => _$this._employmentStatus = employmentStatus;

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

  ListBuilder<String>? _documents;
  ListBuilder<String> get documents =>
      _$this._documents ??= ListBuilder<String>();
  set documents(ListBuilder<String>? documents) =>
      _$this._documents = documents;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  HrUpdateStaffRequestBuilder() {
    HrUpdateStaffRequest._defaults(this);
  }

  HrUpdateStaffRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _department = $v.department;
      _position = $v.position;
      _hireDate = $v.hireDate;
      _contractType = $v.contractType;
      _contractEnd = $v.contractEnd;
      _baseSalary = $v.baseSalary;
      _qualifications = $v.qualifications?.toBuilder();
      _annualLeaveBalance = $v.annualLeaveBalance;
      _sickLeaveBalance = $v.sickLeaveBalance;
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
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrUpdateStaffRequest other) {
    _$v = other as _$HrUpdateStaffRequest;
  }

  @override
  void update(void Function(HrUpdateStaffRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrUpdateStaffRequest build() => _build();

  _$HrUpdateStaffRequest _build() {
    _$HrUpdateStaffRequest _$result;
    try {
      _$result =
          _$v ??
          _$HrUpdateStaffRequest._(
            department: department,
            position: position,
            hireDate: hireDate,
            contractType: contractType,
            contractEnd: contractEnd,
            baseSalary: baseSalary,
            qualifications: _qualifications?.build(),
            annualLeaveBalance: annualLeaveBalance,
            sickLeaveBalance: sickLeaveBalance,
            employeeNo: employeeNo,
            supervisorUserId: supervisorUserId,
            employmentType: employmentType,
            employmentStatus: employmentStatus,
            terminationDate: terminationDate,
            contractStart: contractStart,
            probationDays: probationDays,
            probationEnd: probationEnd,
            paymentMethod: paymentMethod,
            bankName: bankName,
            bankAccount: bankAccount,
            socialInsuranceRegistered: socialInsuranceRegistered,
            socialInsuranceNumber: socialInsuranceNumber,
            socialInsuranceStart: socialInsuranceStart,
            socialInsuranceEnd: socialInsuranceEnd,
            socialInsuranceSchemeCode: socialInsuranceSchemeCode,
            documents: _documents?.build(),
            reason: reason,
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
          r'HrUpdateStaffRequest',
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
