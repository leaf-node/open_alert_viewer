// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alert_details_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AlertDetailsState {
  String get sourceName => throw _privateConstructorUsedError;

  /// Create a copy of AlertDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlertDetailsStateCopyWith<AlertDetailsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertDetailsStateCopyWith<$Res> {
  factory $AlertDetailsStateCopyWith(
          AlertDetailsState value, $Res Function(AlertDetailsState) then) =
      _$AlertDetailsStateCopyWithImpl<$Res, AlertDetailsState>;
  @useResult
  $Res call({String sourceName});
}

/// @nodoc
class _$AlertDetailsStateCopyWithImpl<$Res, $Val extends AlertDetailsState>
    implements $AlertDetailsStateCopyWith<$Res> {
  _$AlertDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AlertDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceName = null,
  }) {
    return _then(_value.copyWith(
      sourceName: null == sourceName
          ? _value.sourceName
          : sourceName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlertDetailsStateImplCopyWith<$Res>
    implements $AlertDetailsStateCopyWith<$Res> {
  factory _$$AlertDetailsStateImplCopyWith(_$AlertDetailsStateImpl value,
          $Res Function(_$AlertDetailsStateImpl) then) =
      __$$AlertDetailsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String sourceName});
}

/// @nodoc
class __$$AlertDetailsStateImplCopyWithImpl<$Res>
    extends _$AlertDetailsStateCopyWithImpl<$Res, _$AlertDetailsStateImpl>
    implements _$$AlertDetailsStateImplCopyWith<$Res> {
  __$$AlertDetailsStateImplCopyWithImpl(_$AlertDetailsStateImpl _value,
      $Res Function(_$AlertDetailsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AlertDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceName = null,
  }) {
    return _then(_$AlertDetailsStateImpl(
      sourceName: null == sourceName
          ? _value.sourceName
          : sourceName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AlertDetailsStateImpl implements _AlertDetailsState {
  const _$AlertDetailsStateImpl({required this.sourceName});

  @override
  final String sourceName;

  @override
  String toString() {
    return 'AlertDetailsState(sourceName: $sourceName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertDetailsStateImpl &&
            (identical(other.sourceName, sourceName) ||
                other.sourceName == sourceName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sourceName);

  /// Create a copy of AlertDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertDetailsStateImplCopyWith<_$AlertDetailsStateImpl> get copyWith =>
      __$$AlertDetailsStateImplCopyWithImpl<_$AlertDetailsStateImpl>(
          this, _$identity);
}

abstract class _AlertDetailsState implements AlertDetailsState {
  const factory _AlertDetailsState({required final String sourceName}) =
      _$AlertDetailsStateImpl;

  @override
  String get sourceName;

  /// Create a copy of AlertDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlertDetailsStateImplCopyWith<_$AlertDetailsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
