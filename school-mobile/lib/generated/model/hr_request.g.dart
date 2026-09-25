// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrRequest extends HrRequest {
  @override
  final int id;
  @override
  final int teacherUserId;
  @override
  final String type;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final String? amount;
  @override
  final String subject;
  @override
  final String reason;
  @override
  final String status;
  @override
  final String? adminResponse;
  @override
  final int? reviewedBy;
  @override
  final DateTime? reviewedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$HrRequest([void Function(HrRequestBuilder)? updates]) =>
      (HrRequestBuilder()..update(updates))._build();

  _$HrRequest._({
    required this.id,
    required this.teacherUserId,
    required this.type,
    this.startDate,
    this.endDate,
    this.amount,
    required this.subject,
    required this.reason,
    required this.status,
    this.adminResponse,
    this.reviewedBy,
    this.reviewedAt,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  HrRequest rebuild(void Function(HrRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HrRequestBuilder toBuilder() => HrRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrRequest &&
        id == other.id &&
        teacherUserId == other.teacherUserId &&
        type == other.type &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        amount == other.amount &&
        subject == other.subject &&
        reason == other.reason &&
        status == other.status &&
        adminResponse == other.adminResponse &&
        reviewedBy == other.reviewedBy &&
        reviewedAt == other.reviewedAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, teacherUserId.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, adminResponse.hashCode);
    _$hash = $jc(_$hash, reviewedBy.hashCode);
    _$hash = $jc(_$hash, reviewedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HrRequest')
          ..add('id', id)
          ..add('teacherUserId', teacherUserId)
          ..add('type', type)
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('amount', amount)
          ..add('subject', subject)
          ..add('reason', reason)
          ..add('status', status)
          ..add('adminResponse', adminResponse)
          ..add('reviewedBy', reviewedBy)
          ..add('reviewedAt', reviewedAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class HrRequestBuilder implements Builder<HrRequest, HrRequestBuilder> {
  _$HrRequest? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _teacherUserId;
  int? get teacherUserId => _$this._teacherUserId;
  set teacherUserId(int? teacherUserId) =>
      _$this._teacherUserId = teacherUserId;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  DateTime? _startDate;
  DateTime? get startDate => _$this._startDate;
  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  DateTime? _endDate;
  DateTime? get endDate => _$this._endDate;
  set endDate(DateTime? endDate) => _$this._endDate = endDate;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _adminResponse;
  String? get adminResponse => _$this._adminResponse;
  set adminResponse(String? adminResponse) =>
      _$this._adminResponse = adminResponse;

  int? _reviewedBy;
  int? get reviewedBy => _$this._reviewedBy;
  set reviewedBy(int? reviewedBy) => _$this._reviewedBy = reviewedBy;

  DateTime? _reviewedAt;
  DateTime? get reviewedAt => _$this._reviewedAt;
  set reviewedAt(DateTime? reviewedAt) => _$this._reviewedAt = reviewedAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  HrRequestBuilder() {
    HrRequest._defaults(this);
  }

  HrRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _teacherUserId = $v.teacherUserId;
      _type = $v.type;
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _amount = $v.amount;
      _subject = $v.subject;
      _reason = $v.reason;
      _status = $v.status;
      _adminResponse = $v.adminResponse;
      _reviewedBy = $v.reviewedBy;
      _reviewedAt = $v.reviewedAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrRequest other) {
    _$v = other as _$HrRequest;
  }

  @override
  void update(void Function(HrRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrRequest build() => _build();

  _$HrRequest _build() {
    final _$result =
        _$v ??
        _$HrRequest._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'HrRequest', 'id'),
          teacherUserId: BuiltValueNullFieldError.checkNotNull(
            teacherUserId,
            r'HrRequest',
            'teacherUserId',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'HrRequest',
            'type',
          ),
          startDate: startDate,
          endDate: endDate,
          amount: amount,
          subject: BuiltValueNullFieldError.checkNotNull(
            subject,
            r'HrRequest',
            'subject',
          ),
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'HrRequest',
            'reason',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HrRequest',
            'status',
          ),
          adminResponse: adminResponse,
          reviewedBy: reviewedBy,
          reviewedAt: reviewedAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'HrRequest',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
