// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'root_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RootSettingsCubitState {
  List<AlertSourceData> get sources => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;

  /// Create a copy of RootSettingsCubitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RootSettingsCubitStateCopyWith<RootSettingsCubitState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RootSettingsCubitStateCopyWith<$Res> {
  factory $RootSettingsCubitStateCopyWith(RootSettingsCubitState value,
          $Res Function(RootSettingsCubitState) then) =
      _$RootSettingsCubitStateCopyWithImpl<$Res, RootSettingsCubitState>;
  @useResult
  $Res call({List<AlertSourceData> sources, bool success});
}

/// @nodoc
class _$RootSettingsCubitStateCopyWithImpl<$Res,
        $Val extends RootSettingsCubitState>
    implements $RootSettingsCubitStateCopyWith<$Res> {
  _$RootSettingsCubitStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RootSettingsCubitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sources = null,
    Object? success = null,
  }) {
    return _then(_value.copyWith(
      sources: null == sources
          ? _value.sources
          : sources // ignore: cast_nullable_to_non_nullable
              as List<AlertSourceData>,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RootSettingsStateImplCopyWith<$Res>
    implements $RootSettingsCubitStateCopyWith<$Res> {
  factory _$$RootSettingsStateImplCopyWith(_$RootSettingsStateImpl value,
          $Res Function(_$RootSettingsStateImpl) then) =
      __$$RootSettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AlertSourceData> sources, bool success});
}

/// @nodoc
class __$$RootSettingsStateImplCopyWithImpl<$Res>
    extends _$RootSettingsCubitStateCopyWithImpl<$Res, _$RootSettingsStateImpl>
    implements _$$RootSettingsStateImplCopyWith<$Res> {
  __$$RootSettingsStateImplCopyWithImpl(_$RootSettingsStateImpl _value,
      $Res Function(_$RootSettingsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RootSettingsCubitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sources = null,
    Object? success = null,
  }) {
    return _then(_$RootSettingsStateImpl(
      sources: null == sources
          ? _value._sources
          : sources // ignore: cast_nullable_to_non_nullable
              as List<AlertSourceData>,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$RootSettingsStateImpl implements _RootSettingsState {
  const _$RootSettingsStateImpl(
      {required final List<AlertSourceData> sources, required this.success})
      : _sources = sources;

  final List<AlertSourceData> _sources;
  @override
  List<AlertSourceData> get sources {
    if (_sources is EqualUnmodifiableListView) return _sources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sources);
  }

  @override
  final bool success;

  @override
  String toString() {
    return 'RootSettingsCubitState(sources: $sources, success: $success)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RootSettingsStateImpl &&
            const DeepCollectionEquality().equals(other._sources, _sources) &&
            (identical(other.success, success) || other.success == success));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_sources), success);

  /// Create a copy of RootSettingsCubitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RootSettingsStateImplCopyWith<_$RootSettingsStateImpl> get copyWith =>
      __$$RootSettingsStateImplCopyWithImpl<_$RootSettingsStateImpl>(
          this, _$identity);
}

abstract class _RootSettingsState implements RootSettingsCubitState {
  const factory _RootSettingsState(
      {required final List<AlertSourceData> sources,
      required final bool success}) = _$RootSettingsStateImpl;

  @override
  List<AlertSourceData> get sources;
  @override
  bool get success;

  /// Create a copy of RootSettingsCubitState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RootSettingsStateImplCopyWith<_$RootSettingsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
