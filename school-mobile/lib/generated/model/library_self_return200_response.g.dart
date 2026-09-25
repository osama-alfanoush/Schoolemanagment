// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_self_return200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LibrarySelfReturn200ResponseMessageEnum
_$librarySelfReturn200ResponseMessageEnum_bookReturnedSuccessfullyPeriod =
    const LibrarySelfReturn200ResponseMessageEnum._(
      'bookReturnedSuccessfullyPeriod',
    );

LibrarySelfReturn200ResponseMessageEnum
_$librarySelfReturn200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'bookReturnedSuccessfullyPeriod':
      return _$librarySelfReturn200ResponseMessageEnum_bookReturnedSuccessfullyPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<LibrarySelfReturn200ResponseMessageEnum>
_$librarySelfReturn200ResponseMessageEnumValues =
    BuiltSet<LibrarySelfReturn200ResponseMessageEnum>(const <
      LibrarySelfReturn200ResponseMessageEnum
    >[
      _$librarySelfReturn200ResponseMessageEnum_bookReturnedSuccessfullyPeriod,
    ]);

Serializer<LibrarySelfReturn200ResponseMessageEnum>
_$librarySelfReturn200ResponseMessageEnumSerializer =
    _$LibrarySelfReturn200ResponseMessageEnumSerializer();

class _$LibrarySelfReturn200ResponseMessageEnumSerializer
    implements PrimitiveSerializer<LibrarySelfReturn200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bookReturnedSuccessfullyPeriod': 'Book returned successfully.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Book returned successfully.': 'bookReturnedSuccessfullyPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    LibrarySelfReturn200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'LibrarySelfReturn200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    LibrarySelfReturn200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  LibrarySelfReturn200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => LibrarySelfReturn200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$LibrarySelfReturn200Response extends LibrarySelfReturn200Response {
  @override
  final LibrarySelfReturn200ResponseMessageEnum message;
  @override
  final String fineAmount;

  factory _$LibrarySelfReturn200Response([
    void Function(LibrarySelfReturn200ResponseBuilder)? updates,
  ]) => (LibrarySelfReturn200ResponseBuilder()..update(updates))._build();

  _$LibrarySelfReturn200Response._({
    required this.message,
    required this.fineAmount,
  }) : super._();
  @override
  LibrarySelfReturn200Response rebuild(
    void Function(LibrarySelfReturn200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  LibrarySelfReturn200ResponseBuilder toBuilder() =>
      LibrarySelfReturn200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LibrarySelfReturn200Response &&
        message == other.message &&
        fineAmount == other.fineAmount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, fineAmount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LibrarySelfReturn200Response')
          ..add('message', message)
          ..add('fineAmount', fineAmount))
        .toString();
  }
}

class LibrarySelfReturn200ResponseBuilder
    implements
        Builder<
          LibrarySelfReturn200Response,
          LibrarySelfReturn200ResponseBuilder
        > {
  _$LibrarySelfReturn200Response? _$v;

  LibrarySelfReturn200ResponseMessageEnum? _message;
  LibrarySelfReturn200ResponseMessageEnum? get message => _$this._message;
  set message(LibrarySelfReturn200ResponseMessageEnum? message) =>
      _$this._message = message;

  String? _fineAmount;
  String? get fineAmount => _$this._fineAmount;
  set fineAmount(String? fineAmount) => _$this._fineAmount = fineAmount;

  LibrarySelfReturn200ResponseBuilder() {
    LibrarySelfReturn200Response._defaults(this);
  }

  LibrarySelfReturn200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _fineAmount = $v.fineAmount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LibrarySelfReturn200Response other) {
    _$v = other as _$LibrarySelfReturn200Response;
  }

  @override
  void update(void Function(LibrarySelfReturn200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LibrarySelfReturn200Response build() => _build();

  _$LibrarySelfReturn200Response _build() {
    final _$result =
        _$v ??
        _$LibrarySelfReturn200Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'LibrarySelfReturn200Response',
            'message',
          ),
          fineAmount: BuiltValueNullFieldError.checkNotNull(
            fineAmount,
            r'LibrarySelfReturn200Response',
            'fineAmount',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
