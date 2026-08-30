// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mfa_request_help_desk_recovery201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MfaRequestHelpDeskRecovery201Response
    extends MfaRequestHelpDeskRecovery201Response {
  @override
  final JsonObject? data;

  factory _$MfaRequestHelpDeskRecovery201Response([
    void Function(MfaRequestHelpDeskRecovery201ResponseBuilder)? updates,
  ]) => (MfaRequestHelpDeskRecovery201ResponseBuilder()..update(updates))
      ._build();

  _$MfaRequestHelpDeskRecovery201Response._({this.data}) : super._();
  @override
  MfaRequestHelpDeskRecovery201Response rebuild(
    void Function(MfaRequestHelpDeskRecovery201ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MfaRequestHelpDeskRecovery201ResponseBuilder toBuilder() =>
      MfaRequestHelpDeskRecovery201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MfaRequestHelpDeskRecovery201Response && data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'MfaRequestHelpDeskRecovery201Response',
    )..add('data', data)).toString();
  }
}

class MfaRequestHelpDeskRecovery201ResponseBuilder
    implements
        Builder<
          MfaRequestHelpDeskRecovery201Response,
          MfaRequestHelpDeskRecovery201ResponseBuilder
        > {
  _$MfaRequestHelpDeskRecovery201Response? _$v;

  JsonObject? _data;
  JsonObject? get data => _$this._data;
  set data(JsonObject? data) => _$this._data = data;

  MfaRequestHelpDeskRecovery201ResponseBuilder() {
    MfaRequestHelpDeskRecovery201Response._defaults(this);
  }

  MfaRequestHelpDeskRecovery201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MfaRequestHelpDeskRecovery201Response other) {
    _$v = other as _$MfaRequestHelpDeskRecovery201Response;
  }

  @override
  void update(
    void Function(MfaRequestHelpDeskRecovery201ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  MfaRequestHelpDeskRecovery201Response build() => _build();

  _$MfaRequestHelpDeskRecovery201Response _build() {
    final _$result =
        _$v ?? _$MfaRequestHelpDeskRecovery201Response._(data: data);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
