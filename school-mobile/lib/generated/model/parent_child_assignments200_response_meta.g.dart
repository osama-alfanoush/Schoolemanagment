// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_child_assignments200_response_meta.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentChildAssignments200ResponseMeta
    extends ParentChildAssignments200ResponseMeta {
  @override
  final int currentPage;
  @override
  final int lastPage;
  @override
  final int perPage;
  @override
  final int total;

  factory _$ParentChildAssignments200ResponseMeta([
    void Function(ParentChildAssignments200ResponseMetaBuilder)? updates,
  ]) => (ParentChildAssignments200ResponseMetaBuilder()..update(updates))
      ._build();

  _$ParentChildAssignments200ResponseMeta._({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  }) : super._();
  @override
  ParentChildAssignments200ResponseMeta rebuild(
    void Function(ParentChildAssignments200ResponseMetaBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentChildAssignments200ResponseMetaBuilder toBuilder() =>
      ParentChildAssignments200ResponseMetaBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentChildAssignments200ResponseMeta &&
        currentPage == other.currentPage &&
        lastPage == other.lastPage &&
        perPage == other.perPage &&
        total == other.total;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, currentPage.hashCode);
    _$hash = $jc(_$hash, lastPage.hashCode);
    _$hash = $jc(_$hash, perPage.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ParentChildAssignments200ResponseMeta',
          )
          ..add('currentPage', currentPage)
          ..add('lastPage', lastPage)
          ..add('perPage', perPage)
          ..add('total', total))
        .toString();
  }
}

class ParentChildAssignments200ResponseMetaBuilder
    implements
        Builder<
          ParentChildAssignments200ResponseMeta,
          ParentChildAssignments200ResponseMetaBuilder
        > {
  _$ParentChildAssignments200ResponseMeta? _$v;

  int? _currentPage;
  int? get currentPage => _$this._currentPage;
  set currentPage(int? currentPage) => _$this._currentPage = currentPage;

  int? _lastPage;
  int? get lastPage => _$this._lastPage;
  set lastPage(int? lastPage) => _$this._lastPage = lastPage;

  int? _perPage;
  int? get perPage => _$this._perPage;
  set perPage(int? perPage) => _$this._perPage = perPage;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  ParentChildAssignments200ResponseMetaBuilder() {
    ParentChildAssignments200ResponseMeta._defaults(this);
  }

  ParentChildAssignments200ResponseMetaBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _currentPage = $v.currentPage;
      _lastPage = $v.lastPage;
      _perPage = $v.perPage;
      _total = $v.total;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentChildAssignments200ResponseMeta other) {
    _$v = other as _$ParentChildAssignments200ResponseMeta;
  }

  @override
  void update(
    void Function(ParentChildAssignments200ResponseMetaBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentChildAssignments200ResponseMeta build() => _build();

  _$ParentChildAssignments200ResponseMeta _build() {
    final _$result =
        _$v ??
        _$ParentChildAssignments200ResponseMeta._(
          currentPage: BuiltValueNullFieldError.checkNotNull(
            currentPage,
            r'ParentChildAssignments200ResponseMeta',
            'currentPage',
          ),
          lastPage: BuiltValueNullFieldError.checkNotNull(
            lastPage,
            r'ParentChildAssignments200ResponseMeta',
            'lastPage',
          ),
          perPage: BuiltValueNullFieldError.checkNotNull(
            perPage,
            r'ParentChildAssignments200ResponseMeta',
            'perPage',
          ),
          total: BuiltValueNullFieldError.checkNotNull(
            total,
            r'ParentChildAssignments200ResponseMeta',
            'total',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
