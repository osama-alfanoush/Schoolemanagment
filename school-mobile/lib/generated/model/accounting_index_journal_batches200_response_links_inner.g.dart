// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_index_journal_batches200_response_links_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingIndexJournalBatches200ResponseLinksInner
    extends AccountingIndexJournalBatches200ResponseLinksInner {
  @override
  final String? url;
  @override
  final String label;
  @override
  final bool active;

  factory _$AccountingIndexJournalBatches200ResponseLinksInner([
    void Function(AccountingIndexJournalBatches200ResponseLinksInnerBuilder)?
    updates,
  ]) =>
      (AccountingIndexJournalBatches200ResponseLinksInnerBuilder()
            ..update(updates))
          ._build();

  _$AccountingIndexJournalBatches200ResponseLinksInner._({
    this.url,
    required this.label,
    required this.active,
  }) : super._();
  @override
  AccountingIndexJournalBatches200ResponseLinksInner rebuild(
    void Function(AccountingIndexJournalBatches200ResponseLinksInnerBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingIndexJournalBatches200ResponseLinksInnerBuilder toBuilder() =>
      AccountingIndexJournalBatches200ResponseLinksInnerBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingIndexJournalBatches200ResponseLinksInner &&
        url == other.url &&
        label == other.label &&
        active == other.active;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, active.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'AccountingIndexJournalBatches200ResponseLinksInner',
          )
          ..add('url', url)
          ..add('label', label)
          ..add('active', active))
        .toString();
  }
}

class AccountingIndexJournalBatches200ResponseLinksInnerBuilder
    implements
        Builder<
          AccountingIndexJournalBatches200ResponseLinksInner,
          AccountingIndexJournalBatches200ResponseLinksInnerBuilder
        > {
  _$AccountingIndexJournalBatches200ResponseLinksInner? _$v;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  bool? _active;
  bool? get active => _$this._active;
  set active(bool? active) => _$this._active = active;

  AccountingIndexJournalBatches200ResponseLinksInnerBuilder() {
    AccountingIndexJournalBatches200ResponseLinksInner._defaults(this);
  }

  AccountingIndexJournalBatches200ResponseLinksInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _url = $v.url;
      _label = $v.label;
      _active = $v.active;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingIndexJournalBatches200ResponseLinksInner other) {
    _$v = other as _$AccountingIndexJournalBatches200ResponseLinksInner;
  }

  @override
  void update(
    void Function(AccountingIndexJournalBatches200ResponseLinksInnerBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingIndexJournalBatches200ResponseLinksInner build() => _build();

  _$AccountingIndexJournalBatches200ResponseLinksInner _build() {
    final _$result =
        _$v ??
        _$AccountingIndexJournalBatches200ResponseLinksInner._(
          url: url,
          label: BuiltValueNullFieldError.checkNotNull(
            label,
            r'AccountingIndexJournalBatches200ResponseLinksInner',
            'label',
          ),
          active: BuiltValueNullFieldError.checkNotNull(
            active,
            r'AccountingIndexJournalBatches200ResponseLinksInner',
            'active',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
