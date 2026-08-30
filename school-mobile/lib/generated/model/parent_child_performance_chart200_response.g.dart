// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_child_performance_chart200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentChildPerformanceChart200Response
    extends ParentChildPerformanceChart200Response {
  @override
  final AnyOf anyOf;

  factory _$ParentChildPerformanceChart200Response([
    void Function(ParentChildPerformanceChart200ResponseBuilder)? updates,
  ]) => (ParentChildPerformanceChart200ResponseBuilder()..update(updates))
      ._build();

  _$ParentChildPerformanceChart200Response._({required this.anyOf}) : super._();
  @override
  ParentChildPerformanceChart200Response rebuild(
    void Function(ParentChildPerformanceChart200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentChildPerformanceChart200ResponseBuilder toBuilder() =>
      ParentChildPerformanceChart200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentChildPerformanceChart200Response &&
        anyOf == other.anyOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, anyOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ParentChildPerformanceChart200Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class ParentChildPerformanceChart200ResponseBuilder
    implements
        Builder<
          ParentChildPerformanceChart200Response,
          ParentChildPerformanceChart200ResponseBuilder
        > {
  _$ParentChildPerformanceChart200Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  ParentChildPerformanceChart200ResponseBuilder() {
    ParentChildPerformanceChart200Response._defaults(this);
  }

  ParentChildPerformanceChart200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentChildPerformanceChart200Response other) {
    _$v = other as _$ParentChildPerformanceChart200Response;
  }

  @override
  void update(
    void Function(ParentChildPerformanceChart200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentChildPerformanceChart200Response build() => _build();

  _$ParentChildPerformanceChart200Response _build() {
    final _$result =
        _$v ??
        _$ParentChildPerformanceChart200Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'ParentChildPerformanceChart200Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
