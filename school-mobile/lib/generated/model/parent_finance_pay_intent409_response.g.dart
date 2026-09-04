// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_finance_pay_intent409_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentFinancePayIntent409Response
    extends ParentFinancePayIntent409Response {
  @override
  final String message;
  @override
  final String errors;

  factory _$ParentFinancePayIntent409Response([
    void Function(ParentFinancePayIntent409ResponseBuilder)? updates,
  ]) => (ParentFinancePayIntent409ResponseBuilder()..update(updates))._build();

  _$ParentFinancePayIntent409Response._({
    required this.message,
    required this.errors,
  }) : super._();
  @override
  ParentFinancePayIntent409Response rebuild(
    void Function(ParentFinancePayIntent409ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentFinancePayIntent409ResponseBuilder toBuilder() =>
      ParentFinancePayIntent409ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentFinancePayIntent409Response &&
        message == other.message &&
        errors == other.errors;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, errors.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParentFinancePayIntent409Response')
          ..add('message', message)
          ..add('errors', errors))
        .toString();
  }
}

class ParentFinancePayIntent409ResponseBuilder
    implements
        Builder<
          ParentFinancePayIntent409Response,
          ParentFinancePayIntent409ResponseBuilder
        > {
  _$ParentFinancePayIntent409Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _errors;
  String? get errors => _$this._errors;
  set errors(String? errors) => _$this._errors = errors;

  ParentFinancePayIntent409ResponseBuilder() {
    ParentFinancePayIntent409Response._defaults(this);
  }

  ParentFinancePayIntent409ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _errors = $v.errors;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentFinancePayIntent409Response other) {
    _$v = other as _$ParentFinancePayIntent409Response;
  }

  @override
  void update(
    void Function(ParentFinancePayIntent409ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentFinancePayIntent409Response build() => _build();

  _$ParentFinancePayIntent409Response _build() {
    final _$result =
        _$v ??
        _$ParentFinancePayIntent409Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'ParentFinancePayIntent409Response',
            'message',
          ),
          errors: BuiltValueNullFieldError.checkNotNull(
            errors,
            r'ParentFinancePayIntent409Response',
            'errors',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
