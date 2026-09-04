// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_home_home200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentHomeHome200ResponseData extends ParentHomeHome200ResponseData {
  @override
  final AnyOf anyOf;

  factory _$ParentHomeHome200ResponseData([
    void Function(ParentHomeHome200ResponseDataBuilder)? updates,
  ]) => (ParentHomeHome200ResponseDataBuilder()..update(updates))._build();

  _$ParentHomeHome200ResponseData._({required this.anyOf}) : super._();
  @override
  ParentHomeHome200ResponseData rebuild(
    void Function(ParentHomeHome200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentHomeHome200ResponseDataBuilder toBuilder() =>
      ParentHomeHome200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentHomeHome200ResponseData && anyOf == other.anyOf;
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
      r'ParentHomeHome200ResponseData',
    )..add('anyOf', anyOf)).toString();
  }
}

class ParentHomeHome200ResponseDataBuilder
    implements
        Builder<
          ParentHomeHome200ResponseData,
          ParentHomeHome200ResponseDataBuilder
        > {
  _$ParentHomeHome200ResponseData? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  ParentHomeHome200ResponseDataBuilder() {
    ParentHomeHome200ResponseData._defaults(this);
  }

  ParentHomeHome200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentHomeHome200ResponseData other) {
    _$v = other as _$ParentHomeHome200ResponseData;
  }

  @override
  void update(void Function(ParentHomeHome200ResponseDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentHomeHome200ResponseData build() => _build();

  _$ParentHomeHome200ResponseData _build() {
    final _$result =
        _$v ??
        _$ParentHomeHome200ResponseData._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'ParentHomeHome200ResponseData',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
