// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disciplinary_warning.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DisciplinaryWarning extends DisciplinaryWarning {
  @override
  final int id;
  @override
  final String warningNo;
  @override
  final int staffProfileId;
  @override
  final String warningType;
  @override
  final String offence;
  @override
  final String incidentDescription;
  @override
  final DateTime incidentDate;
  @override
  final DateTime issuedDate;
  @override
  final String level;
  @override
  final int issuedBy;
  @override
  final String status;
  @override
  final DateTime? receivedAt;
  @override
  final String? employeeComments;
  @override
  final BuiltList<JsonObject?>? attachments;
  @override
  final DateTime? effectExpiresAt;
  @override
  final int? previousWarningId;
  @override
  final String? cancellationReason;
  @override
  final int? approvedBy;
  @override
  final DateTime? approvedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$DisciplinaryWarning([
    void Function(DisciplinaryWarningBuilder)? updates,
  ]) => (DisciplinaryWarningBuilder()..update(updates))._build();

  _$DisciplinaryWarning._({
    required this.id,
    required this.warningNo,
    required this.staffProfileId,
    required this.warningType,
    required this.offence,
    required this.incidentDescription,
    required this.incidentDate,
    required this.issuedDate,
    required this.level,
    required this.issuedBy,
    required this.status,
    this.receivedAt,
    this.employeeComments,
    this.attachments,
    this.effectExpiresAt,
    this.previousWarningId,
    this.cancellationReason,
    this.approvedBy,
    this.approvedAt,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  DisciplinaryWarning rebuild(
    void Function(DisciplinaryWarningBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DisciplinaryWarningBuilder toBuilder() =>
      DisciplinaryWarningBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DisciplinaryWarning &&
        id == other.id &&
        warningNo == other.warningNo &&
        staffProfileId == other.staffProfileId &&
        warningType == other.warningType &&
        offence == other.offence &&
        incidentDescription == other.incidentDescription &&
        incidentDate == other.incidentDate &&
        issuedDate == other.issuedDate &&
        level == other.level &&
        issuedBy == other.issuedBy &&
        status == other.status &&
        receivedAt == other.receivedAt &&
        employeeComments == other.employeeComments &&
        attachments == other.attachments &&
        effectExpiresAt == other.effectExpiresAt &&
        previousWarningId == other.previousWarningId &&
        cancellationReason == other.cancellationReason &&
        approvedBy == other.approvedBy &&
        approvedAt == other.approvedAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, warningNo.hashCode);
    _$hash = $jc(_$hash, staffProfileId.hashCode);
    _$hash = $jc(_$hash, warningType.hashCode);
    _$hash = $jc(_$hash, offence.hashCode);
    _$hash = $jc(_$hash, incidentDescription.hashCode);
    _$hash = $jc(_$hash, incidentDate.hashCode);
    _$hash = $jc(_$hash, issuedDate.hashCode);
    _$hash = $jc(_$hash, level.hashCode);
    _$hash = $jc(_$hash, issuedBy.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, receivedAt.hashCode);
    _$hash = $jc(_$hash, employeeComments.hashCode);
    _$hash = $jc(_$hash, attachments.hashCode);
    _$hash = $jc(_$hash, effectExpiresAt.hashCode);
    _$hash = $jc(_$hash, previousWarningId.hashCode);
    _$hash = $jc(_$hash, cancellationReason.hashCode);
    _$hash = $jc(_$hash, approvedBy.hashCode);
    _$hash = $jc(_$hash, approvedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DisciplinaryWarning')
          ..add('id', id)
          ..add('warningNo', warningNo)
          ..add('staffProfileId', staffProfileId)
          ..add('warningType', warningType)
          ..add('offence', offence)
          ..add('incidentDescription', incidentDescription)
          ..add('incidentDate', incidentDate)
          ..add('issuedDate', issuedDate)
          ..add('level', level)
          ..add('issuedBy', issuedBy)
          ..add('status', status)
          ..add('receivedAt', receivedAt)
          ..add('employeeComments', employeeComments)
          ..add('attachments', attachments)
          ..add('effectExpiresAt', effectExpiresAt)
          ..add('previousWarningId', previousWarningId)
          ..add('cancellationReason', cancellationReason)
          ..add('approvedBy', approvedBy)
          ..add('approvedAt', approvedAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class DisciplinaryWarningBuilder
    implements Builder<DisciplinaryWarning, DisciplinaryWarningBuilder> {
  _$DisciplinaryWarning? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _warningNo;
  String? get warningNo => _$this._warningNo;
  set warningNo(String? warningNo) => _$this._warningNo = warningNo;

  int? _staffProfileId;
  int? get staffProfileId => _$this._staffProfileId;
  set staffProfileId(int? staffProfileId) =>
      _$this._staffProfileId = staffProfileId;

  String? _warningType;
  String? get warningType => _$this._warningType;
  set warningType(String? warningType) => _$this._warningType = warningType;

  String? _offence;
  String? get offence => _$this._offence;
  set offence(String? offence) => _$this._offence = offence;

  String? _incidentDescription;
  String? get incidentDescription => _$this._incidentDescription;
  set incidentDescription(String? incidentDescription) =>
      _$this._incidentDescription = incidentDescription;

  DateTime? _incidentDate;
  DateTime? get incidentDate => _$this._incidentDate;
  set incidentDate(DateTime? incidentDate) =>
      _$this._incidentDate = incidentDate;

  DateTime? _issuedDate;
  DateTime? get issuedDate => _$this._issuedDate;
  set issuedDate(DateTime? issuedDate) => _$this._issuedDate = issuedDate;

  String? _level;
  String? get level => _$this._level;
  set level(String? level) => _$this._level = level;

  int? _issuedBy;
  int? get issuedBy => _$this._issuedBy;
  set issuedBy(int? issuedBy) => _$this._issuedBy = issuedBy;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  DateTime? _receivedAt;
  DateTime? get receivedAt => _$this._receivedAt;
  set receivedAt(DateTime? receivedAt) => _$this._receivedAt = receivedAt;

  String? _employeeComments;
  String? get employeeComments => _$this._employeeComments;
  set employeeComments(String? employeeComments) =>
      _$this._employeeComments = employeeComments;

  ListBuilder<JsonObject?>? _attachments;
  ListBuilder<JsonObject?> get attachments =>
      _$this._attachments ??= ListBuilder<JsonObject?>();
  set attachments(ListBuilder<JsonObject?>? attachments) =>
      _$this._attachments = attachments;

  DateTime? _effectExpiresAt;
  DateTime? get effectExpiresAt => _$this._effectExpiresAt;
  set effectExpiresAt(DateTime? effectExpiresAt) =>
      _$this._effectExpiresAt = effectExpiresAt;

  int? _previousWarningId;
  int? get previousWarningId => _$this._previousWarningId;
  set previousWarningId(int? previousWarningId) =>
      _$this._previousWarningId = previousWarningId;

  String? _cancellationReason;
  String? get cancellationReason => _$this._cancellationReason;
  set cancellationReason(String? cancellationReason) =>
      _$this._cancellationReason = cancellationReason;

  int? _approvedBy;
  int? get approvedBy => _$this._approvedBy;
  set approvedBy(int? approvedBy) => _$this._approvedBy = approvedBy;

  DateTime? _approvedAt;
  DateTime? get approvedAt => _$this._approvedAt;
  set approvedAt(DateTime? approvedAt) => _$this._approvedAt = approvedAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  DisciplinaryWarningBuilder() {
    DisciplinaryWarning._defaults(this);
  }

  DisciplinaryWarningBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _warningNo = $v.warningNo;
      _staffProfileId = $v.staffProfileId;
      _warningType = $v.warningType;
      _offence = $v.offence;
      _incidentDescription = $v.incidentDescription;
      _incidentDate = $v.incidentDate;
      _issuedDate = $v.issuedDate;
      _level = $v.level;
      _issuedBy = $v.issuedBy;
      _status = $v.status;
      _receivedAt = $v.receivedAt;
      _employeeComments = $v.employeeComments;
      _attachments = $v.attachments?.toBuilder();
      _effectExpiresAt = $v.effectExpiresAt;
      _previousWarningId = $v.previousWarningId;
      _cancellationReason = $v.cancellationReason;
      _approvedBy = $v.approvedBy;
      _approvedAt = $v.approvedAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DisciplinaryWarning other) {
    _$v = other as _$DisciplinaryWarning;
  }

  @override
  void update(void Function(DisciplinaryWarningBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DisciplinaryWarning build() => _build();

  _$DisciplinaryWarning _build() {
    _$DisciplinaryWarning _$result;
    try {
      _$result =
          _$v ??
          _$DisciplinaryWarning._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'DisciplinaryWarning',
              'id',
            ),
            warningNo: BuiltValueNullFieldError.checkNotNull(
              warningNo,
              r'DisciplinaryWarning',
              'warningNo',
            ),
            staffProfileId: BuiltValueNullFieldError.checkNotNull(
              staffProfileId,
              r'DisciplinaryWarning',
              'staffProfileId',
            ),
            warningType: BuiltValueNullFieldError.checkNotNull(
              warningType,
              r'DisciplinaryWarning',
              'warningType',
            ),
            offence: BuiltValueNullFieldError.checkNotNull(
              offence,
              r'DisciplinaryWarning',
              'offence',
            ),
            incidentDescription: BuiltValueNullFieldError.checkNotNull(
              incidentDescription,
              r'DisciplinaryWarning',
              'incidentDescription',
            ),
            incidentDate: BuiltValueNullFieldError.checkNotNull(
              incidentDate,
              r'DisciplinaryWarning',
              'incidentDate',
            ),
            issuedDate: BuiltValueNullFieldError.checkNotNull(
              issuedDate,
              r'DisciplinaryWarning',
              'issuedDate',
            ),
            level: BuiltValueNullFieldError.checkNotNull(
              level,
              r'DisciplinaryWarning',
              'level',
            ),
            issuedBy: BuiltValueNullFieldError.checkNotNull(
              issuedBy,
              r'DisciplinaryWarning',
              'issuedBy',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'DisciplinaryWarning',
              'status',
            ),
            receivedAt: receivedAt,
            employeeComments: employeeComments,
            attachments: _attachments?.build(),
            effectExpiresAt: effectExpiresAt,
            previousWarningId: previousWarningId,
            cancellationReason: cancellationReason,
            approvedBy: approvedBy,
            approvedAt: approvedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            schoolId: BuiltValueNullFieldError.checkNotNull(
              schoolId,
              r'DisciplinaryWarning',
              'schoolId',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'attachments';
        _attachments?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DisciplinaryWarning',
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
