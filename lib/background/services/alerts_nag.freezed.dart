// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alerts_nag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NagAlertsData _$NagAlertsDataFromJson(Map<String, dynamic> json) {
  return _NagAlertsData.fromJson(json);
}

/// @nodoc
mixin _$NagAlertsData {
  NagDataSection? get data => throw _privateConstructorUsedError;

  /// Serializes this NagAlertsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NagAlertsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NagAlertsDataCopyWith<NagAlertsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NagAlertsDataCopyWith<$Res> {
  factory $NagAlertsDataCopyWith(
          NagAlertsData value, $Res Function(NagAlertsData) then) =
      _$NagAlertsDataCopyWithImpl<$Res, NagAlertsData>;
  @useResult
  $Res call({NagDataSection? data});

  $NagDataSectionCopyWith<$Res>? get data;
}

/// @nodoc
class _$NagAlertsDataCopyWithImpl<$Res, $Val extends NagAlertsData>
    implements $NagAlertsDataCopyWith<$Res> {
  _$NagAlertsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NagAlertsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as NagDataSection?,
    ) as $Val);
  }

  /// Create a copy of NagAlertsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NagDataSectionCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $NagDataSectionCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NagAlertsDataImplCopyWith<$Res>
    implements $NagAlertsDataCopyWith<$Res> {
  factory _$$NagAlertsDataImplCopyWith(
          _$NagAlertsDataImpl value, $Res Function(_$NagAlertsDataImpl) then) =
      __$$NagAlertsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({NagDataSection? data});

  @override
  $NagDataSectionCopyWith<$Res>? get data;
}

/// @nodoc
class __$$NagAlertsDataImplCopyWithImpl<$Res>
    extends _$NagAlertsDataCopyWithImpl<$Res, _$NagAlertsDataImpl>
    implements _$$NagAlertsDataImplCopyWith<$Res> {
  __$$NagAlertsDataImplCopyWithImpl(
      _$NagAlertsDataImpl _value, $Res Function(_$NagAlertsDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of NagAlertsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$NagAlertsDataImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as NagDataSection?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NagAlertsDataImpl implements _NagAlertsData {
  const _$NagAlertsDataImpl({this.data});

  factory _$NagAlertsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$NagAlertsDataImplFromJson(json);

  @override
  final NagDataSection? data;

  @override
  String toString() {
    return 'NagAlertsData(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NagAlertsDataImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of NagAlertsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NagAlertsDataImplCopyWith<_$NagAlertsDataImpl> get copyWith =>
      __$$NagAlertsDataImplCopyWithImpl<_$NagAlertsDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NagAlertsDataImplToJson(
      this,
    );
  }
}

abstract class _NagAlertsData implements NagAlertsData {
  const factory _NagAlertsData({final NagDataSection? data}) =
      _$NagAlertsDataImpl;

  factory _NagAlertsData.fromJson(Map<String, dynamic> json) =
      _$NagAlertsDataImpl.fromJson;

  @override
  NagDataSection? get data;

  /// Create a copy of NagAlertsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NagAlertsDataImplCopyWith<_$NagAlertsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NagDataSection _$NagDataSectionFromJson(Map<String, dynamic> json) {
  return _NagDataSection.fromJson(json);
}

/// @nodoc
mixin _$NagDataSection {
  Map<String, NagAlertData?>? get hostlist =>
      throw _privateConstructorUsedError;
  Map<String, Map<String, NagAlertData?>?>? get servicelist =>
      throw _privateConstructorUsedError;

  /// Serializes this NagDataSection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NagDataSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NagDataSectionCopyWith<NagDataSection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NagDataSectionCopyWith<$Res> {
  factory $NagDataSectionCopyWith(
          NagDataSection value, $Res Function(NagDataSection) then) =
      _$NagDataSectionCopyWithImpl<$Res, NagDataSection>;
  @useResult
  $Res call(
      {Map<String, NagAlertData?>? hostlist,
      Map<String, Map<String, NagAlertData?>?>? servicelist});
}

/// @nodoc
class _$NagDataSectionCopyWithImpl<$Res, $Val extends NagDataSection>
    implements $NagDataSectionCopyWith<$Res> {
  _$NagDataSectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NagDataSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hostlist = freezed,
    Object? servicelist = freezed,
  }) {
    return _then(_value.copyWith(
      hostlist: freezed == hostlist
          ? _value.hostlist
          : hostlist // ignore: cast_nullable_to_non_nullable
              as Map<String, NagAlertData?>?,
      servicelist: freezed == servicelist
          ? _value.servicelist
          : servicelist // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, NagAlertData?>?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NagDataSectionImplCopyWith<$Res>
    implements $NagDataSectionCopyWith<$Res> {
  factory _$$NagDataSectionImplCopyWith(_$NagDataSectionImpl value,
          $Res Function(_$NagDataSectionImpl) then) =
      __$$NagDataSectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, NagAlertData?>? hostlist,
      Map<String, Map<String, NagAlertData?>?>? servicelist});
}

/// @nodoc
class __$$NagDataSectionImplCopyWithImpl<$Res>
    extends _$NagDataSectionCopyWithImpl<$Res, _$NagDataSectionImpl>
    implements _$$NagDataSectionImplCopyWith<$Res> {
  __$$NagDataSectionImplCopyWithImpl(
      _$NagDataSectionImpl _value, $Res Function(_$NagDataSectionImpl) _then)
      : super(_value, _then);

  /// Create a copy of NagDataSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hostlist = freezed,
    Object? servicelist = freezed,
  }) {
    return _then(_$NagDataSectionImpl(
      hostlist: freezed == hostlist
          ? _value._hostlist
          : hostlist // ignore: cast_nullable_to_non_nullable
              as Map<String, NagAlertData?>?,
      servicelist: freezed == servicelist
          ? _value._servicelist
          : servicelist // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, NagAlertData?>?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NagDataSectionImpl implements _NagDataSection {
  const _$NagDataSectionImpl(
      {final Map<String, NagAlertData?>? hostlist,
      final Map<String, Map<String, NagAlertData?>?>? servicelist})
      : _hostlist = hostlist,
        _servicelist = servicelist;

  factory _$NagDataSectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$NagDataSectionImplFromJson(json);

  final Map<String, NagAlertData?>? _hostlist;
  @override
  Map<String, NagAlertData?>? get hostlist {
    final value = _hostlist;
    if (value == null) return null;
    if (_hostlist is EqualUnmodifiableMapView) return _hostlist;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, Map<String, NagAlertData?>?>? _servicelist;
  @override
  Map<String, Map<String, NagAlertData?>?>? get servicelist {
    final value = _servicelist;
    if (value == null) return null;
    if (_servicelist is EqualUnmodifiableMapView) return _servicelist;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'NagDataSection(hostlist: $hostlist, servicelist: $servicelist)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NagDataSectionImpl &&
            const DeepCollectionEquality().equals(other._hostlist, _hostlist) &&
            const DeepCollectionEquality()
                .equals(other._servicelist, _servicelist));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_hostlist),
      const DeepCollectionEquality().hash(_servicelist));

  /// Create a copy of NagDataSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NagDataSectionImplCopyWith<_$NagDataSectionImpl> get copyWith =>
      __$$NagDataSectionImplCopyWithImpl<_$NagDataSectionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NagDataSectionImplToJson(
      this,
    );
  }
}

abstract class _NagDataSection implements NagDataSection {
  const factory _NagDataSection(
          {final Map<String, NagAlertData?>? hostlist,
          final Map<String, Map<String, NagAlertData?>?>? servicelist}) =
      _$NagDataSectionImpl;

  factory _NagDataSection.fromJson(Map<String, dynamic> json) =
      _$NagDataSectionImpl.fromJson;

  @override
  Map<String, NagAlertData?>? get hostlist;
  @override
  Map<String, Map<String, NagAlertData?>?>? get servicelist;

  /// Create a copy of NagDataSection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NagDataSectionImplCopyWith<_$NagDataSectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NagAlertData _$NagAlertDataFromJson(Map<String, dynamic> json) {
  return _NagAlertData.fromJson(json);
}

/// @nodoc
mixin _$NagAlertData {
  String? get description => throw _privateConstructorUsedError;
  int? get status =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  int? get scheduled_downtime_depth =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  bool? get problem_has_been_acknowledged =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  int? get last_state_change =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  int? get last_hard_state_change =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  int? get last_check =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  int? get state_type =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  String? get plugin_output => throw _privateConstructorUsedError;

  /// Serializes this NagAlertData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NagAlertData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NagAlertDataCopyWith<NagAlertData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NagAlertDataCopyWith<$Res> {
  factory $NagAlertDataCopyWith(
          NagAlertData value, $Res Function(NagAlertData) then) =
      _$NagAlertDataCopyWithImpl<$Res, NagAlertData>;
  @useResult
  $Res call(
      {String? description,
      int? status,
      int? scheduled_downtime_depth,
      bool? problem_has_been_acknowledged,
      int? last_state_change,
      int? last_hard_state_change,
      int? last_check,
      int? state_type,
      String? plugin_output});
}

/// @nodoc
class _$NagAlertDataCopyWithImpl<$Res, $Val extends NagAlertData>
    implements $NagAlertDataCopyWith<$Res> {
  _$NagAlertDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NagAlertData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
    Object? status = freezed,
    Object? scheduled_downtime_depth = freezed,
    Object? problem_has_been_acknowledged = freezed,
    Object? last_state_change = freezed,
    Object? last_hard_state_change = freezed,
    Object? last_check = freezed,
    Object? state_type = freezed,
    Object? plugin_output = freezed,
  }) {
    return _then(_value.copyWith(
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      scheduled_downtime_depth: freezed == scheduled_downtime_depth
          ? _value.scheduled_downtime_depth
          : scheduled_downtime_depth // ignore: cast_nullable_to_non_nullable
              as int?,
      problem_has_been_acknowledged: freezed == problem_has_been_acknowledged
          ? _value.problem_has_been_acknowledged
          : problem_has_been_acknowledged // ignore: cast_nullable_to_non_nullable
              as bool?,
      last_state_change: freezed == last_state_change
          ? _value.last_state_change
          : last_state_change // ignore: cast_nullable_to_non_nullable
              as int?,
      last_hard_state_change: freezed == last_hard_state_change
          ? _value.last_hard_state_change
          : last_hard_state_change // ignore: cast_nullable_to_non_nullable
              as int?,
      last_check: freezed == last_check
          ? _value.last_check
          : last_check // ignore: cast_nullable_to_non_nullable
              as int?,
      state_type: freezed == state_type
          ? _value.state_type
          : state_type // ignore: cast_nullable_to_non_nullable
              as int?,
      plugin_output: freezed == plugin_output
          ? _value.plugin_output
          : plugin_output // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NagAlertDataImplCopyWith<$Res>
    implements $NagAlertDataCopyWith<$Res> {
  factory _$$NagAlertDataImplCopyWith(
          _$NagAlertDataImpl value, $Res Function(_$NagAlertDataImpl) then) =
      __$$NagAlertDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? description,
      int? status,
      int? scheduled_downtime_depth,
      bool? problem_has_been_acknowledged,
      int? last_state_change,
      int? last_hard_state_change,
      int? last_check,
      int? state_type,
      String? plugin_output});
}

/// @nodoc
class __$$NagAlertDataImplCopyWithImpl<$Res>
    extends _$NagAlertDataCopyWithImpl<$Res, _$NagAlertDataImpl>
    implements _$$NagAlertDataImplCopyWith<$Res> {
  __$$NagAlertDataImplCopyWithImpl(
      _$NagAlertDataImpl _value, $Res Function(_$NagAlertDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of NagAlertData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
    Object? status = freezed,
    Object? scheduled_downtime_depth = freezed,
    Object? problem_has_been_acknowledged = freezed,
    Object? last_state_change = freezed,
    Object? last_hard_state_change = freezed,
    Object? last_check = freezed,
    Object? state_type = freezed,
    Object? plugin_output = freezed,
  }) {
    return _then(_$NagAlertDataImpl(
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      scheduled_downtime_depth: freezed == scheduled_downtime_depth
          ? _value.scheduled_downtime_depth
          : scheduled_downtime_depth // ignore: cast_nullable_to_non_nullable
              as int?,
      problem_has_been_acknowledged: freezed == problem_has_been_acknowledged
          ? _value.problem_has_been_acknowledged
          : problem_has_been_acknowledged // ignore: cast_nullable_to_non_nullable
              as bool?,
      last_state_change: freezed == last_state_change
          ? _value.last_state_change
          : last_state_change // ignore: cast_nullable_to_non_nullable
              as int?,
      last_hard_state_change: freezed == last_hard_state_change
          ? _value.last_hard_state_change
          : last_hard_state_change // ignore: cast_nullable_to_non_nullable
              as int?,
      last_check: freezed == last_check
          ? _value.last_check
          : last_check // ignore: cast_nullable_to_non_nullable
              as int?,
      state_type: freezed == state_type
          ? _value.state_type
          : state_type // ignore: cast_nullable_to_non_nullable
              as int?,
      plugin_output: freezed == plugin_output
          ? _value.plugin_output
          : plugin_output // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NagAlertDataImpl implements _NagAlertData {
  const _$NagAlertDataImpl(
      {this.description,
      this.status,
      this.scheduled_downtime_depth,
      this.problem_has_been_acknowledged,
      this.last_state_change,
      this.last_hard_state_change,
      this.last_check,
      this.state_type,
      this.plugin_output});

  factory _$NagAlertDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$NagAlertDataImplFromJson(json);

  @override
  final String? description;
  @override
  final int? status;
// ignore: non_constant_identifier_names
  @override
  final int? scheduled_downtime_depth;
// ignore: non_constant_identifier_names
  @override
  final bool? problem_has_been_acknowledged;
// ignore: non_constant_identifier_names
  @override
  final int? last_state_change;
// ignore: non_constant_identifier_names
  @override
  final int? last_hard_state_change;
// ignore: non_constant_identifier_names
  @override
  final int? last_check;
// ignore: non_constant_identifier_names
  @override
  final int? state_type;
// ignore: non_constant_identifier_names
  @override
  final String? plugin_output;

  @override
  String toString() {
    return 'NagAlertData(description: $description, status: $status, scheduled_downtime_depth: $scheduled_downtime_depth, problem_has_been_acknowledged: $problem_has_been_acknowledged, last_state_change: $last_state_change, last_hard_state_change: $last_hard_state_change, last_check: $last_check, state_type: $state_type, plugin_output: $plugin_output)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NagAlertDataImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(
                    other.scheduled_downtime_depth, scheduled_downtime_depth) ||
                other.scheduled_downtime_depth == scheduled_downtime_depth) &&
            (identical(other.problem_has_been_acknowledged,
                    problem_has_been_acknowledged) ||
                other.problem_has_been_acknowledged ==
                    problem_has_been_acknowledged) &&
            (identical(other.last_state_change, last_state_change) ||
                other.last_state_change == last_state_change) &&
            (identical(other.last_hard_state_change, last_hard_state_change) ||
                other.last_hard_state_change == last_hard_state_change) &&
            (identical(other.last_check, last_check) ||
                other.last_check == last_check) &&
            (identical(other.state_type, state_type) ||
                other.state_type == state_type) &&
            (identical(other.plugin_output, plugin_output) ||
                other.plugin_output == plugin_output));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      description,
      status,
      scheduled_downtime_depth,
      problem_has_been_acknowledged,
      last_state_change,
      last_hard_state_change,
      last_check,
      state_type,
      plugin_output);

  /// Create a copy of NagAlertData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NagAlertDataImplCopyWith<_$NagAlertDataImpl> get copyWith =>
      __$$NagAlertDataImplCopyWithImpl<_$NagAlertDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NagAlertDataImplToJson(
      this,
    );
  }
}

abstract class _NagAlertData implements NagAlertData {
  const factory _NagAlertData(
      {final String? description,
      final int? status,
      final int? scheduled_downtime_depth,
      final bool? problem_has_been_acknowledged,
      final int? last_state_change,
      final int? last_hard_state_change,
      final int? last_check,
      final int? state_type,
      final String? plugin_output}) = _$NagAlertDataImpl;

  factory _NagAlertData.fromJson(Map<String, dynamic> json) =
      _$NagAlertDataImpl.fromJson;

  @override
  String? get description;
  @override
  int? get status; // ignore: non_constant_identifier_names
  @override
  int? get scheduled_downtime_depth; // ignore: non_constant_identifier_names
  @override
  bool?
      get problem_has_been_acknowledged; // ignore: non_constant_identifier_names
  @override
  int? get last_state_change; // ignore: non_constant_identifier_names
  @override
  int? get last_hard_state_change; // ignore: non_constant_identifier_names
  @override
  int? get last_check; // ignore: non_constant_identifier_names
  @override
  int? get state_type; // ignore: non_constant_identifier_names
  @override
  String? get plugin_output;

  /// Create a copy of NagAlertData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NagAlertDataImplCopyWith<_$NagAlertDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
