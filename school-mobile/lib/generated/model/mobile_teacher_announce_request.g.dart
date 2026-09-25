// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_teacher_announce_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MobileTeacherAnnounceRequest extends MobileTeacherAnnounceRequest {
  @override
  final String idempotencyKey;
  @override
  final String templateKey;
  @override
  final String? detail;
  @override
  final String audience;

  factory _$MobileTeacherAnnounceRequest([
    void Function(MobileTeacherAnnounceRequestBuilder)? updates,
  ]) => (MobileTeacherAnnounceRequestBuilder()..update(updates))._build();

  _$MobileTeacherAnnounceRequest._({
    required this.idempotencyKey,
    required this.templateKey,
    this.detail,
    required this.audience,
  }) : super._();
  @override
  MobileTeacherAnnounceRequest rebuild(
    void Function(MobileTeacherAnnounceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MobileTeacherAnnounceRequestBuilder toBuilder() =>
      MobileTeacherAnnounceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MobileTeacherAnnounceRequest &&
        idempotencyKey == other.idempotencyKey &&
        templateKey == other.templateKey &&
        detail == other.detail &&
        audience == other.audience;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jc(_$hash, templateKey.hashCode);
    _$hash = $jc(_$hash, detail.hashCode);
    _$hash = $jc(_$hash, audience.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MobileTeacherAnnounceRequest')
          ..add('idempotencyKey', idempotencyKey)
          ..add('templateKey', templateKey)
          ..add('detail', detail)
          ..add('audience', audience))
        .toString();
  }
}

class MobileTeacherAnnounceRequestBuilder
    implements
        Builder<
          MobileTeacherAnnounceRequest,
          MobileTeacherAnnounceRequestBuilder
        > {
  _$MobileTeacherAnnounceRequest? _$v;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  String? _templateKey;
  String? get templateKey => _$this._templateKey;
  set templateKey(String? templateKey) => _$this._templateKey = templateKey;

  String? _detail;
  String? get detail => _$this._detail;
  set detail(String? detail) => _$this._detail = detail;

  String? _audience;
  String? get audience => _$this._audience;
  set audience(String? audience) => _$this._audience = audience;

  MobileTeacherAnnounceRequestBuilder() {
    MobileTeacherAnnounceRequest._defaults(this);
  }

  MobileTeacherAnnounceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _idempotencyKey = $v.idempotencyKey;
      _templateKey = $v.templateKey;
      _detail = $v.detail;
      _audience = $v.audience;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MobileTeacherAnnounceRequest other) {
    _$v = other as _$MobileTeacherAnnounceRequest;
  }

  @override
  void update(void Function(MobileTeacherAnnounceRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MobileTeacherAnnounceRequest build() => _build();

  _$MobileTeacherAnnounceRequest _build() {
    final _$result =
        _$v ??
        _$MobileTeacherAnnounceRequest._(
          idempotencyKey: BuiltValueNullFieldError.checkNotNull(
            idempotencyKey,
            r'MobileTeacherAnnounceRequest',
            'idempotencyKey',
          ),
          templateKey: BuiltValueNullFieldError.checkNotNull(
            templateKey,
            r'MobileTeacherAnnounceRequest',
            'templateKey',
          ),
          detail: detail,
          audience: BuiltValueNullFieldError.checkNotNull(
            audience,
            r'MobileTeacherAnnounceRequest',
            'audience',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
