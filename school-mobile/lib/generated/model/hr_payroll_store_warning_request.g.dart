// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_payroll_store_warning_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrPayrollStoreWarningRequest extends HrPayrollStoreWarningRequest {
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
  final BuiltList<String>? attachments;
  @override
  final DateTime? effectExpiresAt;
  @override
  final int? previousWarningId;

  factory _$HrPayrollStoreWarningRequest([
    void Function(HrPayrollStoreWarningRequestBuilder)? updates,
  ]) => (HrPayrollStoreWarningRequestBuilder()..update(updates))._build();

  _$HrPayrollStoreWarningRequest._({
    required this.staffProfileId,
    required this.warningType,
    required this.offence,
    required this.incidentDescription,
    required this.incidentDate,
    required this.issuedDate,
    required this.level,
    this.attachments,
    this.effectExpiresAt,
    this.previousWarningId,
  }) : super._();
  @override
  HrPayrollStoreWarningRequest rebuild(
    void Function(HrPayrollStoreWarningRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrPayrollStoreWarningRequestBuilder toBuilder() =>
      HrPayrollStoreWarningRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrPayrollStoreWarningRequest &&
        staffProfileId == other.staffProfileId &&
        warningType == other.warningType &&
        offence == other.offence &&
        incidentDescription == other.incidentDescription &&
        incidentDate == other.incidentDate &&
        issuedDate == other.issuedDate &&
        level == other.level &&
        attachments == other.attachments &&
        effectExpiresAt == other.effectExpiresAt &&
        previousWarningId == other.previousWarningId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, staffProfileId.hashCode);
    _$hash = $jc(_$hash, warningType.hashCode);
    _$hash = $jc(_$hash, offence.hashCode);
    _$hash = $jc(_$hash, incidentDescription.hashCode);
    _$hash = $jc(_$hash, incidentDate.hashCode);
    _$hash = $jc(_$hash, issuedDate.hashCode);
    _$hash = $jc(_$hash, level.hashCode);
    _$hash = $jc(_$hash, attachments.hashCode);
    _$hash = $jc(_$hash, effectExpiresAt.hashCode);
    _$hash = $jc(_$hash, previousWarningId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HrPayrollStoreWarningRequest')
          ..add('staffProfileId', staffProfileId)
          ..add('warningType', warningType)
          ..add('offence', offence)
          ..add('incidentDescription', incidentDescription)
          ..add('incidentDate', incidentDate)
          ..add('issuedDate', issuedDate)
          ..add('level', level)
          ..add('attachments', attachments)
          ..add('effectExpiresAt', effectExpiresAt)
          ..add('previousWarningId', previousWarningId))
        .toString();
  }
}

class HrPayrollStoreWarningRequestBuilder
    implements
        Builder<
          HrPayrollStoreWarningRequest,
          HrPayrollStoreWarningRequestBuilder
        > {
  _$HrPayrollStoreWarningRequest? _$v;

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

  ListBuilder<String>? _attachments;
  ListBuilder<String> get attachments =>
      _$this._attachments ??= ListBuilder<String>();
  set attachments(ListBuilder<String>? attachments) =>
      _$this._attachments = attachments;

  DateTime? _effectExpiresAt;
  DateTime? get effectExpiresAt => _$this._effectExpiresAt;
  set effectExpiresAt(DateTime? effectExpiresAt) =>
      _$this._effectExpiresAt = effectExpiresAt;

  int? _previousWarningId;
  int? get previousWarningId => _$this._previousWarningId;
  set previousWarningId(int? previousWarningId) =>
      _$this._previousWarningId = previousWarningId;

  HrPayrollStoreWarningRequestBuilder() {
    HrPayrollStoreWarningRequest._defaults(this);
  }

  HrPayrollStoreWarningRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _staffProfileId = $v.staffProfileId;
      _warningType = $v.warningType;
      _offence = $v.offence;
      _incidentDescription = $v.incidentDescription;
      _incidentDate = $v.incidentDate;
      _issuedDate = $v.issuedDate;
      _level = $v.level;
      _attachments = $v.attachments?.toBuilder();
      _effectExpiresAt = $v.effectExpiresAt;
      _previousWarningId = $v.previousWarningId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrPayrollStoreWarningRequest other) {
    _$v = other as _$HrPayrollStoreWarningRequest;
  }

  @override
  void update(void Function(HrPayrollStoreWarningRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrPayrollStoreWarningRequest build() => _build();

  _$HrPayrollStoreWarningRequest _build() {
    _$HrPayrollStoreWarningRequest _$result;
    try {
      _$result =
          _$v ??
          _$HrPayrollStoreWarningRequest._(
            staffProfileId: BuiltValueNullFieldError.checkNotNull(
              staffProfileId,
              r'HrPayrollStoreWarningRequest',
              'staffProfileId',
            ),
            warningType: BuiltValueNullFieldError.checkNotNull(
              warningType,
              r'HrPayrollStoreWarningRequest',
              'warningType',
            ),
            offence: BuiltValueNullFieldError.checkNotNull(
              offence,
              r'HrPayrollStoreWarningRequest',
              'offence',
            ),
            incidentDescription: BuiltValueNullFieldError.checkNotNull(
              incidentDescription,
              r'HrPayrollStoreWarningRequest',
              'incidentDescription',
            ),
            incidentDate: BuiltValueNullFieldError.checkNotNull(
              incidentDate,
              r'HrPayrollStoreWarningRequest',
              'incidentDate',
            ),
            issuedDate: BuiltValueNullFieldError.checkNotNull(
              issuedDate,
              r'HrPayrollStoreWarningRequest',
              'issuedDate',
            ),
            level: BuiltValueNullFieldError.checkNotNull(
              level,
              r'HrPayrollStoreWarningRequest',
              'level',
            ),
            attachments: _attachments?.build(),
            effectExpiresAt: effectExpiresAt,
            previousWarningId: previousWarningId,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'attachments';
        _attachments?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HrPayrollStoreWarningRequest',
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
