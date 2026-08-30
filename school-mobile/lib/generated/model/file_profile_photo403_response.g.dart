// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_profile_photo403_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FileProfilePhoto403Response extends FileProfilePhoto403Response {
  @override
  final String message;

  factory _$FileProfilePhoto403Response([
    void Function(FileProfilePhoto403ResponseBuilder)? updates,
  ]) => (FileProfilePhoto403ResponseBuilder()..update(updates))._build();

  _$FileProfilePhoto403Response._({required this.message}) : super._();
  @override
  FileProfilePhoto403Response rebuild(
    void Function(FileProfilePhoto403ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FileProfilePhoto403ResponseBuilder toBuilder() =>
      FileProfilePhoto403ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FileProfilePhoto403Response && message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'FileProfilePhoto403Response',
    )..add('message', message)).toString();
  }
}

class FileProfilePhoto403ResponseBuilder
    implements
        Builder<
          FileProfilePhoto403Response,
          FileProfilePhoto403ResponseBuilder
        > {
  _$FileProfilePhoto403Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  FileProfilePhoto403ResponseBuilder() {
    FileProfilePhoto403Response._defaults(this);
  }

  FileProfilePhoto403ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FileProfilePhoto403Response other) {
    _$v = other as _$FileProfilePhoto403Response;
  }

  @override
  void update(void Function(FileProfilePhoto403ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FileProfilePhoto403Response build() => _build();

  _$FileProfilePhoto403Response _build() {
    final _$result =
        _$v ??
        _$FileProfilePhoto403Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'FileProfilePhoto403Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
