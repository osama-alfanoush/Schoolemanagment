// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradebook_reopen_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GradebookReopenRequest extends GradebookReopenRequest {
  @override
  final int version;
  @override
  final String reason;
  @override
  final DateTime reopenedUntil;

  factory _$GradebookReopenRequest([
    void Function(GradebookReopenRequestBuilder)? updates,
  ]) => (GradebookReopenRequestBuilder()..update(updates))._build();

  _$GradebookReopenRequest._({
    required this.version,
    required this.reason,
    required this.reopenedUntil,
  }) : super._();
  @override
  GradebookReopenRequest rebuild(
    void Function(GradebookReopenRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GradebookReopenRequestBuilder toBuilder() =>
      GradebookReopenRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GradebookReopenRequest &&
        version == other.version &&
        reason == other.reason &&
        reopenedUntil == other.reopenedUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, reopenedUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GradebookReopenRequest')
          ..add('version', version)
          ..add('reason', reason)
          ..add('reopenedUntil', reopenedUntil))
        .toString();
  }
}

class GradebookReopenRequestBuilder
    implements Builder<GradebookReopenRequest, GradebookReopenRequestBuilder> {
  _$GradebookReopenRequest? _$v;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  DateTime? _reopenedUntil;
  DateTime? get reopenedUntil => _$this._reopenedUntil;
  set reopenedUntil(DateTime? reopenedUntil) =>
      _$this._reopenedUntil = reopenedUntil;

  GradebookReopenRequestBuilder() {
    GradebookReopenRequest._defaults(this);
  }

  GradebookReopenRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _version = $v.version;
      _reason = $v.reason;
      _reopenedUntil = $v.reopenedUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GradebookReopenRequest other) {
    _$v = other as _$GradebookReopenRequest;
  }

  @override
  void update(void Function(GradebookReopenRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GradebookReopenRequest build() => _build();

  _$GradebookReopenRequest _build() {
    final _$result =
        _$v ??
        _$GradebookReopenRequest._(
          version: BuiltValueNullFieldError.checkNotNull(
            version,
            r'GradebookReopenRequest',
            'version',
          ),
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'GradebookReopenRequest',
            'reason',
          ),
          reopenedUntil: BuiltValueNullFieldError.checkNotNull(
            reopenedUntil,
            r'GradebookReopenRequest',
            'reopenedUntil',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
