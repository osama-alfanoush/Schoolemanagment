// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mfa_regenerate_recovery_codes200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MfaRegenerateRecoveryCodes200Response
    extends MfaRegenerateRecoveryCodes200Response {
  @override
  final BuiltList<String> recoveryCodes;

  factory _$MfaRegenerateRecoveryCodes200Response([
    void Function(MfaRegenerateRecoveryCodes200ResponseBuilder)? updates,
  ]) => (MfaRegenerateRecoveryCodes200ResponseBuilder()..update(updates))
      ._build();

  _$MfaRegenerateRecoveryCodes200Response._({required this.recoveryCodes})
    : super._();
  @override
  MfaRegenerateRecoveryCodes200Response rebuild(
    void Function(MfaRegenerateRecoveryCodes200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MfaRegenerateRecoveryCodes200ResponseBuilder toBuilder() =>
      MfaRegenerateRecoveryCodes200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MfaRegenerateRecoveryCodes200Response &&
        recoveryCodes == other.recoveryCodes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, recoveryCodes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'MfaRegenerateRecoveryCodes200Response',
    )..add('recoveryCodes', recoveryCodes)).toString();
  }
}

class MfaRegenerateRecoveryCodes200ResponseBuilder
    implements
        Builder<
          MfaRegenerateRecoveryCodes200Response,
          MfaRegenerateRecoveryCodes200ResponseBuilder
        > {
  _$MfaRegenerateRecoveryCodes200Response? _$v;

  ListBuilder<String>? _recoveryCodes;
  ListBuilder<String> get recoveryCodes =>
      _$this._recoveryCodes ??= ListBuilder<String>();
  set recoveryCodes(ListBuilder<String>? recoveryCodes) =>
      _$this._recoveryCodes = recoveryCodes;

  MfaRegenerateRecoveryCodes200ResponseBuilder() {
    MfaRegenerateRecoveryCodes200Response._defaults(this);
  }

  MfaRegenerateRecoveryCodes200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _recoveryCodes = $v.recoveryCodes.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MfaRegenerateRecoveryCodes200Response other) {
    _$v = other as _$MfaRegenerateRecoveryCodes200Response;
  }

  @override
  void update(
    void Function(MfaRegenerateRecoveryCodes200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  MfaRegenerateRecoveryCodes200Response build() => _build();

  _$MfaRegenerateRecoveryCodes200Response _build() {
    _$MfaRegenerateRecoveryCodes200Response _$result;
    try {
      _$result =
          _$v ??
          _$MfaRegenerateRecoveryCodes200Response._(
            recoveryCodes: recoveryCodes.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'recoveryCodes';
        recoveryCodes.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'MfaRegenerateRecoveryCodes200Response',
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
