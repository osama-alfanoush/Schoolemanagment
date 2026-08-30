// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payroll_store_run_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PayrollStoreRunRequest extends PayrollStoreRunRequest {
  @override
  final int year;
  @override
  final int month;

  factory _$PayrollStoreRunRequest([
    void Function(PayrollStoreRunRequestBuilder)? updates,
  ]) => (PayrollStoreRunRequestBuilder()..update(updates))._build();

  _$PayrollStoreRunRequest._({required this.year, required this.month})
    : super._();
  @override
  PayrollStoreRunRequest rebuild(
    void Function(PayrollStoreRunRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PayrollStoreRunRequestBuilder toBuilder() =>
      PayrollStoreRunRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PayrollStoreRunRequest &&
        year == other.year &&
        month == other.month;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, year.hashCode);
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PayrollStoreRunRequest')
          ..add('year', year)
          ..add('month', month))
        .toString();
  }
}

class PayrollStoreRunRequestBuilder
    implements Builder<PayrollStoreRunRequest, PayrollStoreRunRequestBuilder> {
  _$PayrollStoreRunRequest? _$v;

  int? _year;
  int? get year => _$this._year;
  set year(int? year) => _$this._year = year;

  int? _month;
  int? get month => _$this._month;
  set month(int? month) => _$this._month = month;

  PayrollStoreRunRequestBuilder() {
    PayrollStoreRunRequest._defaults(this);
  }

  PayrollStoreRunRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _year = $v.year;
      _month = $v.month;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PayrollStoreRunRequest other) {
    _$v = other as _$PayrollStoreRunRequest;
  }

  @override
  void update(void Function(PayrollStoreRunRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PayrollStoreRunRequest build() => _build();

  _$PayrollStoreRunRequest _build() {
    final _$result =
        _$v ??
        _$PayrollStoreRunRequest._(
          year: BuiltValueNullFieldError.checkNotNull(
            year,
            r'PayrollStoreRunRequest',
            'year',
          ),
          month: BuiltValueNullFieldError.checkNotNull(
            month,
            r'PayrollStoreRunRequest',
            'month',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
