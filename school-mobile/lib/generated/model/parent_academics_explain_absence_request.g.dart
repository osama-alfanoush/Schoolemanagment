// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_academics_explain_absence_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentAcademicsExplainAbsenceRequest
    extends ParentAcademicsExplainAbsenceRequest {
  @override
  final String reason;
  @override
  final String idempotencyKey;

  factory _$ParentAcademicsExplainAbsenceRequest([
    void Function(ParentAcademicsExplainAbsenceRequestBuilder)? updates,
  ]) =>
      (ParentAcademicsExplainAbsenceRequestBuilder()..update(updates))._build();

  _$ParentAcademicsExplainAbsenceRequest._({
    required this.reason,
    required this.idempotencyKey,
  }) : super._();
  @override
  ParentAcademicsExplainAbsenceRequest rebuild(
    void Function(ParentAcademicsExplainAbsenceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentAcademicsExplainAbsenceRequestBuilder toBuilder() =>
      ParentAcademicsExplainAbsenceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentAcademicsExplainAbsenceRequest &&
        reason == other.reason &&
        idempotencyKey == other.idempotencyKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParentAcademicsExplainAbsenceRequest')
          ..add('reason', reason)
          ..add('idempotencyKey', idempotencyKey))
        .toString();
  }
}

class ParentAcademicsExplainAbsenceRequestBuilder
    implements
        Builder<
          ParentAcademicsExplainAbsenceRequest,
          ParentAcademicsExplainAbsenceRequestBuilder
        > {
  _$ParentAcademicsExplainAbsenceRequest? _$v;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  ParentAcademicsExplainAbsenceRequestBuilder() {
    ParentAcademicsExplainAbsenceRequest._defaults(this);
  }

  ParentAcademicsExplainAbsenceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _idempotencyKey = $v.idempotencyKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentAcademicsExplainAbsenceRequest other) {
    _$v = other as _$ParentAcademicsExplainAbsenceRequest;
  }

  @override
  void update(
    void Function(ParentAcademicsExplainAbsenceRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentAcademicsExplainAbsenceRequest build() => _build();

  _$ParentAcademicsExplainAbsenceRequest _build() {
    final _$result =
        _$v ??
        _$ParentAcademicsExplainAbsenceRequest._(
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'ParentAcademicsExplainAbsenceRequest',
            'reason',
          ),
          idempotencyKey: BuiltValueNullFieldError.checkNotNull(
            idempotencyKey,
            r'ParentAcademicsExplainAbsenceRequest',
            'idempotencyKey',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
