// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_threads200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInboxThreads200ResponseData
    extends ParentInboxThreads200ResponseData {
  @override
  final BuiltList<JsonObject?> threads;

  factory _$ParentInboxThreads200ResponseData([
    void Function(ParentInboxThreads200ResponseDataBuilder)? updates,
  ]) => (ParentInboxThreads200ResponseDataBuilder()..update(updates))._build();

  _$ParentInboxThreads200ResponseData._({required this.threads}) : super._();
  @override
  ParentInboxThreads200ResponseData rebuild(
    void Function(ParentInboxThreads200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxThreads200ResponseDataBuilder toBuilder() =>
      ParentInboxThreads200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxThreads200ResponseData &&
        threads == other.threads;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, threads.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ParentInboxThreads200ResponseData',
    )..add('threads', threads)).toString();
  }
}

class ParentInboxThreads200ResponseDataBuilder
    implements
        Builder<
          ParentInboxThreads200ResponseData,
          ParentInboxThreads200ResponseDataBuilder
        > {
  _$ParentInboxThreads200ResponseData? _$v;

  ListBuilder<JsonObject?>? _threads;
  ListBuilder<JsonObject?> get threads =>
      _$this._threads ??= ListBuilder<JsonObject?>();
  set threads(ListBuilder<JsonObject?>? threads) => _$this._threads = threads;

  ParentInboxThreads200ResponseDataBuilder() {
    ParentInboxThreads200ResponseData._defaults(this);
  }

  ParentInboxThreads200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _threads = $v.threads.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxThreads200ResponseData other) {
    _$v = other as _$ParentInboxThreads200ResponseData;
  }

  @override
  void update(
    void Function(ParentInboxThreads200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxThreads200ResponseData build() => _build();

  _$ParentInboxThreads200ResponseData _build() {
    _$ParentInboxThreads200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$ParentInboxThreads200ResponseData._(threads: threads.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'threads';
        threads.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentInboxThreads200ResponseData',
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
