// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_send_reminders200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FinanceSendReminders200Response
    extends FinanceSendReminders200Response {
  @override
  final int reminded;

  factory _$FinanceSendReminders200Response([
    void Function(FinanceSendReminders200ResponseBuilder)? updates,
  ]) => (FinanceSendReminders200ResponseBuilder()..update(updates))._build();

  _$FinanceSendReminders200Response._({required this.reminded}) : super._();
  @override
  FinanceSendReminders200Response rebuild(
    void Function(FinanceSendReminders200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FinanceSendReminders200ResponseBuilder toBuilder() =>
      FinanceSendReminders200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceSendReminders200Response &&
        reminded == other.reminded;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reminded.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'FinanceSendReminders200Response',
    )..add('reminded', reminded)).toString();
  }
}

class FinanceSendReminders200ResponseBuilder
    implements
        Builder<
          FinanceSendReminders200Response,
          FinanceSendReminders200ResponseBuilder
        > {
  _$FinanceSendReminders200Response? _$v;

  int? _reminded;
  int? get reminded => _$this._reminded;
  set reminded(int? reminded) => _$this._reminded = reminded;

  FinanceSendReminders200ResponseBuilder() {
    FinanceSendReminders200Response._defaults(this);
  }

  FinanceSendReminders200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reminded = $v.reminded;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinanceSendReminders200Response other) {
    _$v = other as _$FinanceSendReminders200Response;
  }

  @override
  void update(void Function(FinanceSendReminders200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceSendReminders200Response build() => _build();

  _$FinanceSendReminders200Response _build() {
    final _$result =
        _$v ??
        _$FinanceSendReminders200Response._(
          reminded: BuiltValueNullFieldError.checkNotNull(
            reminded,
            r'FinanceSendReminders200Response',
            'reminded',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
