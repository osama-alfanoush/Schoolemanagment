// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_index_journal_batches200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingIndexJournalBatches200Response
    extends AccountingIndexJournalBatches200Response {
  @override
  final int currentPage;
  @override
  final BuiltList<JournalBatch> data;
  @override
  final String? firstPageUrl;
  @override
  final int? from;
  @override
  final String? lastPageUrl;
  @override
  final int lastPage;
  @override
  final BuiltList<AccountingIndexJournalBatches200ResponseLinksInner> links;
  @override
  final String? nextPageUrl;
  @override
  final String? path;
  @override
  final int perPage;
  @override
  final String? prevPageUrl;
  @override
  final int? to;
  @override
  final int total;

  factory _$AccountingIndexJournalBatches200Response([
    void Function(AccountingIndexJournalBatches200ResponseBuilder)? updates,
  ]) => (AccountingIndexJournalBatches200ResponseBuilder()..update(updates))
      ._build();

  _$AccountingIndexJournalBatches200Response._({
    required this.currentPage,
    required this.data,
    this.firstPageUrl,
    this.from,
    this.lastPageUrl,
    required this.lastPage,
    required this.links,
    this.nextPageUrl,
    this.path,
    required this.perPage,
    this.prevPageUrl,
    this.to,
    required this.total,
  }) : super._();
  @override
  AccountingIndexJournalBatches200Response rebuild(
    void Function(AccountingIndexJournalBatches200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingIndexJournalBatches200ResponseBuilder toBuilder() =>
      AccountingIndexJournalBatches200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingIndexJournalBatches200Response &&
        currentPage == other.currentPage &&
        data == other.data &&
        firstPageUrl == other.firstPageUrl &&
        from == other.from &&
        lastPageUrl == other.lastPageUrl &&
        lastPage == other.lastPage &&
        links == other.links &&
        nextPageUrl == other.nextPageUrl &&
        path == other.path &&
        perPage == other.perPage &&
        prevPageUrl == other.prevPageUrl &&
        to == other.to &&
        total == other.total;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, currentPage.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, firstPageUrl.hashCode);
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, lastPageUrl.hashCode);
    _$hash = $jc(_$hash, lastPage.hashCode);
    _$hash = $jc(_$hash, links.hashCode);
    _$hash = $jc(_$hash, nextPageUrl.hashCode);
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jc(_$hash, perPage.hashCode);
    _$hash = $jc(_$hash, prevPageUrl.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'AccountingIndexJournalBatches200Response',
          )
          ..add('currentPage', currentPage)
          ..add('data', data)
          ..add('firstPageUrl', firstPageUrl)
          ..add('from', from)
          ..add('lastPageUrl', lastPageUrl)
          ..add('lastPage', lastPage)
          ..add('links', links)
          ..add('nextPageUrl', nextPageUrl)
          ..add('path', path)
          ..add('perPage', perPage)
          ..add('prevPageUrl', prevPageUrl)
          ..add('to', to)
          ..add('total', total))
        .toString();
  }
}

class AccountingIndexJournalBatches200ResponseBuilder
    implements
        Builder<
          AccountingIndexJournalBatches200Response,
          AccountingIndexJournalBatches200ResponseBuilder
        > {
  _$AccountingIndexJournalBatches200Response? _$v;

  int? _currentPage;
  int? get currentPage => _$this._currentPage;
  set currentPage(int? currentPage) => _$this._currentPage = currentPage;

  ListBuilder<JournalBatch>? _data;
  ListBuilder<JournalBatch> get data =>
      _$this._data ??= ListBuilder<JournalBatch>();
  set data(ListBuilder<JournalBatch>? data) => _$this._data = data;

  String? _firstPageUrl;
  String? get firstPageUrl => _$this._firstPageUrl;
  set firstPageUrl(String? firstPageUrl) => _$this._firstPageUrl = firstPageUrl;

  int? _from;
  int? get from => _$this._from;
  set from(int? from) => _$this._from = from;

  String? _lastPageUrl;
  String? get lastPageUrl => _$this._lastPageUrl;
  set lastPageUrl(String? lastPageUrl) => _$this._lastPageUrl = lastPageUrl;

  int? _lastPage;
  int? get lastPage => _$this._lastPage;
  set lastPage(int? lastPage) => _$this._lastPage = lastPage;

  ListBuilder<AccountingIndexJournalBatches200ResponseLinksInner>? _links;
  ListBuilder<AccountingIndexJournalBatches200ResponseLinksInner> get links =>
      _$this._links ??=
          ListBuilder<AccountingIndexJournalBatches200ResponseLinksInner>();
  set links(
    ListBuilder<AccountingIndexJournalBatches200ResponseLinksInner>? links,
  ) => _$this._links = links;

  String? _nextPageUrl;
  String? get nextPageUrl => _$this._nextPageUrl;
  set nextPageUrl(String? nextPageUrl) => _$this._nextPageUrl = nextPageUrl;

  String? _path;
  String? get path => _$this._path;
  set path(String? path) => _$this._path = path;

  int? _perPage;
  int? get perPage => _$this._perPage;
  set perPage(int? perPage) => _$this._perPage = perPage;

  String? _prevPageUrl;
  String? get prevPageUrl => _$this._prevPageUrl;
  set prevPageUrl(String? prevPageUrl) => _$this._prevPageUrl = prevPageUrl;

  int? _to;
  int? get to => _$this._to;
  set to(int? to) => _$this._to = to;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  AccountingIndexJournalBatches200ResponseBuilder() {
    AccountingIndexJournalBatches200Response._defaults(this);
  }

  AccountingIndexJournalBatches200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _currentPage = $v.currentPage;
      _data = $v.data.toBuilder();
      _firstPageUrl = $v.firstPageUrl;
      _from = $v.from;
      _lastPageUrl = $v.lastPageUrl;
      _lastPage = $v.lastPage;
      _links = $v.links.toBuilder();
      _nextPageUrl = $v.nextPageUrl;
      _path = $v.path;
      _perPage = $v.perPage;
      _prevPageUrl = $v.prevPageUrl;
      _to = $v.to;
      _total = $v.total;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingIndexJournalBatches200Response other) {
    _$v = other as _$AccountingIndexJournalBatches200Response;
  }

  @override
  void update(
    void Function(AccountingIndexJournalBatches200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingIndexJournalBatches200Response build() => _build();

  _$AccountingIndexJournalBatches200Response _build() {
    _$AccountingIndexJournalBatches200Response _$result;
    try {
      _$result =
          _$v ??
          _$AccountingIndexJournalBatches200Response._(
            currentPage: BuiltValueNullFieldError.checkNotNull(
              currentPage,
              r'AccountingIndexJournalBatches200Response',
              'currentPage',
            ),
            data: data.build(),
            firstPageUrl: firstPageUrl,
            from: from,
            lastPageUrl: lastPageUrl,
            lastPage: BuiltValueNullFieldError.checkNotNull(
              lastPage,
              r'AccountingIndexJournalBatches200Response',
              'lastPage',
            ),
            links: links.build(),
            nextPageUrl: nextPageUrl,
            path: path,
            perPage: BuiltValueNullFieldError.checkNotNull(
              perPage,
              r'AccountingIndexJournalBatches200Response',
              'perPage',
            ),
            prevPageUrl: prevPageUrl,
            to: to,
            total: BuiltValueNullFieldError.checkNotNull(
              total,
              r'AccountingIndexJournalBatches200Response',
              'total',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();

        _$failedField = 'links';
        links.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountingIndexJournalBatches200Response',
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
