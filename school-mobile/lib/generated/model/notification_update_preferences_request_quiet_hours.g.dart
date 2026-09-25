// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_update_preferences_request_quiet_hours.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NotificationUpdatePreferencesRequestQuietHours
    extends NotificationUpdatePreferencesRequestQuietHours {
  @override
  final String? start;
  @override
  final String? end;

  factory _$NotificationUpdatePreferencesRequestQuietHours([
    void Function(NotificationUpdatePreferencesRequestQuietHoursBuilder)?
    updates,
  ]) =>
      (NotificationUpdatePreferencesRequestQuietHoursBuilder()..update(updates))
          ._build();

  _$NotificationUpdatePreferencesRequestQuietHours._({this.start, this.end})
    : super._();
  @override
  NotificationUpdatePreferencesRequestQuietHours rebuild(
    void Function(NotificationUpdatePreferencesRequestQuietHoursBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationUpdatePreferencesRequestQuietHoursBuilder toBuilder() =>
      NotificationUpdatePreferencesRequestQuietHoursBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationUpdatePreferencesRequestQuietHours &&
        start == other.start &&
        end == other.end;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, start.hashCode);
    _$hash = $jc(_$hash, end.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'NotificationUpdatePreferencesRequestQuietHours',
          )
          ..add('start', start)
          ..add('end', end))
        .toString();
  }
}

class NotificationUpdatePreferencesRequestQuietHoursBuilder
    implements
        Builder<
          NotificationUpdatePreferencesRequestQuietHours,
          NotificationUpdatePreferencesRequestQuietHoursBuilder
        > {
  _$NotificationUpdatePreferencesRequestQuietHours? _$v;

  String? _start;
  String? get start => _$this._start;
  set start(String? start) => _$this._start = start;

  String? _end;
  String? get end => _$this._end;
  set end(String? end) => _$this._end = end;

  NotificationUpdatePreferencesRequestQuietHoursBuilder() {
    NotificationUpdatePreferencesRequestQuietHours._defaults(this);
  }

  NotificationUpdatePreferencesRequestQuietHoursBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _start = $v.start;
      _end = $v.end;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationUpdatePreferencesRequestQuietHours other) {
    _$v = other as _$NotificationUpdatePreferencesRequestQuietHours;
  }

  @override
  void update(
    void Function(NotificationUpdatePreferencesRequestQuietHoursBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  NotificationUpdatePreferencesRequestQuietHours build() => _build();

  _$NotificationUpdatePreferencesRequestQuietHours _build() {
    final _$result =
        _$v ??
        _$NotificationUpdatePreferencesRequestQuietHours._(
          start: start,
          end: end,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
