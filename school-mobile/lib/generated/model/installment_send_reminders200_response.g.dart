// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installment_send_reminders200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InstallmentSendReminders200Response
    extends InstallmentSendReminders200Response {
  @override
  final int remindersSent;

  factory _$InstallmentSendReminders200Response([
    void Function(InstallmentSendReminders200ResponseBuilder)? updates,
  ]) =>
      (InstallmentSendReminders200ResponseBuilder()..update(updates))._build();

  _$InstallmentSendReminders200Response._({required this.remindersSent})
    : super._();
  @override
  InstallmentSendReminders200Response rebuild(
    void Function(InstallmentSendReminders200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  InstallmentSendReminders200ResponseBuilder toBuilder() =>
      InstallmentSendReminders200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InstallmentSendReminders200Response &&
        remindersSent == other.remindersSent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, remindersSent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'InstallmentSendReminders200Response',
    )..add('remindersSent', remindersSent)).toString();
  }
}

class InstallmentSendReminders200ResponseBuilder
    implements
        Builder<
          InstallmentSendReminders200Response,
          InstallmentSendReminders200ResponseBuilder
        > {
  _$InstallmentSendReminders200Response? _$v;

  int? _remindersSent;
  int? get remindersSent => _$this._remindersSent;
  set remindersSent(int? remindersSent) =>
      _$this._remindersSent = remindersSent;

  InstallmentSendReminders200ResponseBuilder() {
    InstallmentSendReminders200Response._defaults(this);
  }

  InstallmentSendReminders200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _remindersSent = $v.remindersSent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InstallmentSendReminders200Response other) {
    _$v = other as _$InstallmentSendReminders200Response;
  }

  @override
  void update(
    void Function(InstallmentSendReminders200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  InstallmentSendReminders200Response build() => _build();

  _$InstallmentSendReminders200Response _build() {
    final _$result =
        _$v ??
        _$InstallmentSendReminders200Response._(
          remindersSent: BuiltValueNullFieldError.checkNotNull(
            remindersSent,
            r'InstallmentSendReminders200Response',
            'remindersSent',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
