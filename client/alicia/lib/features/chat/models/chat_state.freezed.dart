// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatState {
  String? get prevSessionId => throw _privateConstructorUsedError;
  List<Message> get messages => throw _privateConstructorUsedError;
  bool get sessionStarted => throw _privateConstructorUsedError;
  bool get sessionTerminated => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get aliciaTyping => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatStateCopyWith<ChatState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatStateCopyWith<$Res> {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) then) =
      _$ChatStateCopyWithImpl<$Res, ChatState>;
  @useResult
  $Res call(
      {String? prevSessionId,
      List<Message> messages,
      bool sessionStarted,
      bool sessionTerminated,
      String? error,
      bool isLoading,
      bool aliciaTyping,
      bool isLoadingMore});
}

/// @nodoc
class _$ChatStateCopyWithImpl<$Res, $Val extends ChatState>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prevSessionId = freezed,
    Object? messages = null,
    Object? sessionStarted = null,
    Object? sessionTerminated = null,
    Object? error = freezed,
    Object? isLoading = null,
    Object? aliciaTyping = null,
    Object? isLoadingMore = null,
  }) {
    return _then(_value.copyWith(
      prevSessionId: freezed == prevSessionId
          ? _value.prevSessionId
          : prevSessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      sessionStarted: null == sessionStarted
          ? _value.sessionStarted
          : sessionStarted // ignore: cast_nullable_to_non_nullable
              as bool,
      sessionTerminated: null == sessionTerminated
          ? _value.sessionTerminated
          : sessionTerminated // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      aliciaTyping: null == aliciaTyping
          ? _value.aliciaTyping
          : aliciaTyping // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatStateImplCopyWith<$Res>
    implements $ChatStateCopyWith<$Res> {
  factory _$$ChatStateImplCopyWith(
          _$ChatStateImpl value, $Res Function(_$ChatStateImpl) then) =
      __$$ChatStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? prevSessionId,
      List<Message> messages,
      bool sessionStarted,
      bool sessionTerminated,
      String? error,
      bool isLoading,
      bool aliciaTyping,
      bool isLoadingMore});
}

/// @nodoc
class __$$ChatStateImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatStateImpl>
    implements _$$ChatStateImplCopyWith<$Res> {
  __$$ChatStateImplCopyWithImpl(
      _$ChatStateImpl _value, $Res Function(_$ChatStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prevSessionId = freezed,
    Object? messages = null,
    Object? sessionStarted = null,
    Object? sessionTerminated = null,
    Object? error = freezed,
    Object? isLoading = null,
    Object? aliciaTyping = null,
    Object? isLoadingMore = null,
  }) {
    return _then(_$ChatStateImpl(
      prevSessionId: freezed == prevSessionId
          ? _value.prevSessionId
          : prevSessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      sessionStarted: null == sessionStarted
          ? _value.sessionStarted
          : sessionStarted // ignore: cast_nullable_to_non_nullable
              as bool,
      sessionTerminated: null == sessionTerminated
          ? _value.sessionTerminated
          : sessionTerminated // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      aliciaTyping: null == aliciaTyping
          ? _value.aliciaTyping
          : aliciaTyping // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ChatStateImpl implements _ChatState {
  const _$ChatStateImpl(
      {this.prevSessionId = null,
      final List<Message> messages = const [],
      this.sessionStarted = false,
      this.sessionTerminated = false,
      this.error = null,
      this.isLoading = false,
      this.aliciaTyping = false,
      this.isLoadingMore = false})
      : _messages = messages;

  @override
  @JsonKey()
  final String? prevSessionId;
  final List<Message> _messages;
  @override
  @JsonKey()
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey()
  final bool sessionStarted;
  @override
  @JsonKey()
  final bool sessionTerminated;
  @override
  @JsonKey()
  final String? error;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool aliciaTyping;
  @override
  @JsonKey()
  final bool isLoadingMore;

  @override
  String toString() {
    return 'ChatState(prevSessionId: $prevSessionId, messages: $messages, sessionStarted: $sessionStarted, sessionTerminated: $sessionTerminated, error: $error, isLoading: $isLoading, aliciaTyping: $aliciaTyping, isLoadingMore: $isLoadingMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatStateImpl &&
            (identical(other.prevSessionId, prevSessionId) ||
                other.prevSessionId == prevSessionId) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.sessionStarted, sessionStarted) ||
                other.sessionStarted == sessionStarted) &&
            (identical(other.sessionTerminated, sessionTerminated) ||
                other.sessionTerminated == sessionTerminated) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.aliciaTyping, aliciaTyping) ||
                other.aliciaTyping == aliciaTyping) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      prevSessionId,
      const DeepCollectionEquality().hash(_messages),
      sessionStarted,
      sessionTerminated,
      error,
      isLoading,
      aliciaTyping,
      isLoadingMore);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatStateImplCopyWith<_$ChatStateImpl> get copyWith =>
      __$$ChatStateImplCopyWithImpl<_$ChatStateImpl>(this, _$identity);
}

abstract class _ChatState implements ChatState {
  const factory _ChatState(
      {final String? prevSessionId,
      final List<Message> messages,
      final bool sessionStarted,
      final bool sessionTerminated,
      final String? error,
      final bool isLoading,
      final bool aliciaTyping,
      final bool isLoadingMore}) = _$ChatStateImpl;

  @override
  String? get prevSessionId;
  @override
  List<Message> get messages;
  @override
  bool get sessionStarted;
  @override
  bool get sessionTerminated;
  @override
  String? get error;
  @override
  bool get isLoading;
  @override
  bool get aliciaTyping;
  @override
  bool get isLoadingMore;
  @override
  @JsonKey(ignore: true)
  _$$ChatStateImplCopyWith<_$ChatStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
