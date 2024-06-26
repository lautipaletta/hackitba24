// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HomeState _$HomeStateFromJson(Map<String, dynamic> json) {
  return _HomeState.fromJson(json);
}

/// @nodoc
mixin _$HomeState {
  String get userName => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  Map<Mood, int> get moodMap => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isGeneratingReport => throw _privateConstructorUsedError;
  List<bool>? get attendance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {String userName,
      String userId,
      Map<Mood, int> moodMap,
      bool isLoading,
      bool isGeneratingReport,
      List<bool>? attendance});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? userId = null,
    Object? moodMap = null,
    Object? isLoading = null,
    Object? isGeneratingReport = null,
    Object? attendance = freezed,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      moodMap: null == moodMap
          ? _value.moodMap
          : moodMap // ignore: cast_nullable_to_non_nullable
              as Map<Mood, int>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isGeneratingReport: null == isGeneratingReport
          ? _value.isGeneratingReport
          : isGeneratingReport // ignore: cast_nullable_to_non_nullable
              as bool,
      attendance: freezed == attendance
          ? _value.attendance
          : attendance // ignore: cast_nullable_to_non_nullable
              as List<bool>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userName,
      String userId,
      Map<Mood, int> moodMap,
      bool isLoading,
      bool isGeneratingReport,
      List<bool>? attendance});
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? userId = null,
    Object? moodMap = null,
    Object? isLoading = null,
    Object? isGeneratingReport = null,
    Object? attendance = freezed,
  }) {
    return _then(_$HomeStateImpl(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      moodMap: null == moodMap
          ? _value._moodMap
          : moodMap // ignore: cast_nullable_to_non_nullable
              as Map<Mood, int>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isGeneratingReport: null == isGeneratingReport
          ? _value.isGeneratingReport
          : isGeneratingReport // ignore: cast_nullable_to_non_nullable
              as bool,
      attendance: freezed == attendance
          ? _value._attendance
          : attendance // ignore: cast_nullable_to_non_nullable
              as List<bool>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$HomeStateImpl implements _HomeState {
  const _$HomeStateImpl(
      {required this.userName,
      required this.userId,
      required final Map<Mood, int> moodMap,
      this.isLoading = false,
      this.isGeneratingReport = false,
      final List<bool>? attendance = null})
      : _moodMap = moodMap,
        _attendance = attendance;

  factory _$HomeStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeStateImplFromJson(json);

  @override
  final String userName;
  @override
  final String userId;
  final Map<Mood, int> _moodMap;
  @override
  Map<Mood, int> get moodMap {
    if (_moodMap is EqualUnmodifiableMapView) return _moodMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_moodMap);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isGeneratingReport;
  final List<bool>? _attendance;
  @override
  @JsonKey()
  List<bool>? get attendance {
    final value = _attendance;
    if (value == null) return null;
    if (_attendance is EqualUnmodifiableListView) return _attendance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'HomeState(userName: $userName, userId: $userId, moodMap: $moodMap, isLoading: $isLoading, isGeneratingReport: $isGeneratingReport, attendance: $attendance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(other._moodMap, _moodMap) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isGeneratingReport, isGeneratingReport) ||
                other.isGeneratingReport == isGeneratingReport) &&
            const DeepCollectionEquality()
                .equals(other._attendance, _attendance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userName,
      userId,
      const DeepCollectionEquality().hash(_moodMap),
      isLoading,
      isGeneratingReport,
      const DeepCollectionEquality().hash(_attendance));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeStateImplToJson(
      this,
    );
  }
}

abstract class _HomeState implements HomeState {
  const factory _HomeState(
      {required final String userName,
      required final String userId,
      required final Map<Mood, int> moodMap,
      final bool isLoading,
      final bool isGeneratingReport,
      final List<bool>? attendance}) = _$HomeStateImpl;

  factory _HomeState.fromJson(Map<String, dynamic> json) =
      _$HomeStateImpl.fromJson;

  @override
  String get userName;
  @override
  String get userId;
  @override
  Map<Mood, int> get moodMap;
  @override
  bool get isLoading;
  @override
  bool get isGeneratingReport;
  @override
  List<bool>? get attendance;
  @override
  @JsonKey(ignore: true)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
