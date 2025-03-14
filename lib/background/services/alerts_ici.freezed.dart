// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alerts_ici.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

IciAlertsData _$IciAlertsDataFromJson(Map<String, dynamic> json) {
  return _IciAlertsData.fromJson(json);
}

/// @nodoc
mixin _$IciAlertsData {
  List<IciResultsData>? get results => throw _privateConstructorUsedError;

  /// Serializes this IciAlertsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IciAlertsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IciAlertsDataCopyWith<IciAlertsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IciAlertsDataCopyWith<$Res> {
  factory $IciAlertsDataCopyWith(
    IciAlertsData value,
    $Res Function(IciAlertsData) then,
  ) = _$IciAlertsDataCopyWithImpl<$Res, IciAlertsData>;
  @useResult
  $Res call({List<IciResultsData>? results});
}

/// @nodoc
class _$IciAlertsDataCopyWithImpl<$Res, $Val extends IciAlertsData>
    implements $IciAlertsDataCopyWith<$Res> {
  _$IciAlertsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IciAlertsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? results = freezed}) {
    return _then(
      _value.copyWith(
            results:
                freezed == results
                    ? _value.results
                    : results // ignore: cast_nullable_to_non_nullable
                        as List<IciResultsData>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IciAlertsDataImplCopyWith<$Res>
    implements $IciAlertsDataCopyWith<$Res> {
  factory _$$IciAlertsDataImplCopyWith(
    _$IciAlertsDataImpl value,
    $Res Function(_$IciAlertsDataImpl) then,
  ) = __$$IciAlertsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<IciResultsData>? results});
}

/// @nodoc
class __$$IciAlertsDataImplCopyWithImpl<$Res>
    extends _$IciAlertsDataCopyWithImpl<$Res, _$IciAlertsDataImpl>
    implements _$$IciAlertsDataImplCopyWith<$Res> {
  __$$IciAlertsDataImplCopyWithImpl(
    _$IciAlertsDataImpl _value,
    $Res Function(_$IciAlertsDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IciAlertsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? results = freezed}) {
    return _then(
      _$IciAlertsDataImpl(
        results:
            freezed == results
                ? _value._results
                : results // ignore: cast_nullable_to_non_nullable
                    as List<IciResultsData>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IciAlertsDataImpl implements _IciAlertsData {
  const _$IciAlertsDataImpl({final List<IciResultsData>? results})
    : _results = results;

  factory _$IciAlertsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$IciAlertsDataImplFromJson(json);

  final List<IciResultsData>? _results;
  @override
  List<IciResultsData>? get results {
    final value = _results;
    if (value == null) return null;
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'IciAlertsData(results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IciAlertsDataImpl &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_results));

  /// Create a copy of IciAlertsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IciAlertsDataImplCopyWith<_$IciAlertsDataImpl> get copyWith =>
      __$$IciAlertsDataImplCopyWithImpl<_$IciAlertsDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IciAlertsDataImplToJson(this);
  }
}

abstract class _IciAlertsData implements IciAlertsData {
  const factory _IciAlertsData({final List<IciResultsData>? results}) =
      _$IciAlertsDataImpl;

  factory _IciAlertsData.fromJson(Map<String, dynamic> json) =
      _$IciAlertsDataImpl.fromJson;

  @override
  List<IciResultsData>? get results;

  /// Create a copy of IciAlertsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IciAlertsDataImplCopyWith<_$IciAlertsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IciResultsData _$IciResultsDataFromJson(Map<String, dynamic> json) {
  return _IciResultsData.fromJson(json);
}

/// @nodoc
mixin _$IciResultsData {
  AttrsData? get attrs => throw _privateConstructorUsedError;
  JoinsData? get joins => throw _privateConstructorUsedError;

  /// Serializes this IciResultsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IciResultsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IciResultsDataCopyWith<IciResultsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IciResultsDataCopyWith<$Res> {
  factory $IciResultsDataCopyWith(
    IciResultsData value,
    $Res Function(IciResultsData) then,
  ) = _$IciResultsDataCopyWithImpl<$Res, IciResultsData>;
  @useResult
  $Res call({AttrsData? attrs, JoinsData? joins});

  $AttrsDataCopyWith<$Res>? get attrs;
  $JoinsDataCopyWith<$Res>? get joins;
}

/// @nodoc
class _$IciResultsDataCopyWithImpl<$Res, $Val extends IciResultsData>
    implements $IciResultsDataCopyWith<$Res> {
  _$IciResultsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IciResultsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? attrs = freezed, Object? joins = freezed}) {
    return _then(
      _value.copyWith(
            attrs:
                freezed == attrs
                    ? _value.attrs
                    : attrs // ignore: cast_nullable_to_non_nullable
                        as AttrsData?,
            joins:
                freezed == joins
                    ? _value.joins
                    : joins // ignore: cast_nullable_to_non_nullable
                        as JoinsData?,
          )
          as $Val,
    );
  }

  /// Create a copy of IciResultsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AttrsDataCopyWith<$Res>? get attrs {
    if (_value.attrs == null) {
      return null;
    }

    return $AttrsDataCopyWith<$Res>(_value.attrs!, (value) {
      return _then(_value.copyWith(attrs: value) as $Val);
    });
  }

  /// Create a copy of IciResultsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $JoinsDataCopyWith<$Res>? get joins {
    if (_value.joins == null) {
      return null;
    }

    return $JoinsDataCopyWith<$Res>(_value.joins!, (value) {
      return _then(_value.copyWith(joins: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IciResultsDataImplCopyWith<$Res>
    implements $IciResultsDataCopyWith<$Res> {
  factory _$$IciResultsDataImplCopyWith(
    _$IciResultsDataImpl value,
    $Res Function(_$IciResultsDataImpl) then,
  ) = __$$IciResultsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AttrsData? attrs, JoinsData? joins});

  @override
  $AttrsDataCopyWith<$Res>? get attrs;
  @override
  $JoinsDataCopyWith<$Res>? get joins;
}

/// @nodoc
class __$$IciResultsDataImplCopyWithImpl<$Res>
    extends _$IciResultsDataCopyWithImpl<$Res, _$IciResultsDataImpl>
    implements _$$IciResultsDataImplCopyWith<$Res> {
  __$$IciResultsDataImplCopyWithImpl(
    _$IciResultsDataImpl _value,
    $Res Function(_$IciResultsDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IciResultsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? attrs = freezed, Object? joins = freezed}) {
    return _then(
      _$IciResultsDataImpl(
        attrs:
            freezed == attrs
                ? _value.attrs
                : attrs // ignore: cast_nullable_to_non_nullable
                    as AttrsData?,
        joins:
            freezed == joins
                ? _value.joins
                : joins // ignore: cast_nullable_to_non_nullable
                    as JoinsData?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IciResultsDataImpl implements _IciResultsData {
  const _$IciResultsDataImpl({this.attrs, this.joins});

  factory _$IciResultsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$IciResultsDataImplFromJson(json);

  @override
  final AttrsData? attrs;
  @override
  final JoinsData? joins;

  @override
  String toString() {
    return 'IciResultsData(attrs: $attrs, joins: $joins)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IciResultsDataImpl &&
            (identical(other.attrs, attrs) || other.attrs == attrs) &&
            (identical(other.joins, joins) || other.joins == joins));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, attrs, joins);

  /// Create a copy of IciResultsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IciResultsDataImplCopyWith<_$IciResultsDataImpl> get copyWith =>
      __$$IciResultsDataImplCopyWithImpl<_$IciResultsDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$IciResultsDataImplToJson(this);
  }
}

abstract class _IciResultsData implements IciResultsData {
  const factory _IciResultsData({
    final AttrsData? attrs,
    final JoinsData? joins,
  }) = _$IciResultsDataImpl;

  factory _IciResultsData.fromJson(Map<String, dynamic> json) =
      _$IciResultsDataImpl.fromJson;

  @override
  AttrsData? get attrs;
  @override
  JoinsData? get joins;

  /// Create a copy of IciResultsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IciResultsDataImplCopyWith<_$IciResultsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttrsData _$AttrsDataFromJson(Map<String, dynamic> json) {
  return _AttrsData.fromJson(json);
}

/// @nodoc
mixin _$AttrsData {
  String? get display_name => throw _privateConstructorUsedError;
  num? get state =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  num? get downtime_depth => throw _privateConstructorUsedError;
  num? get acknowledgement =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  num? get last_state_change =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  num? get last_hard_state_change =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  num? get last_check =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  LastCheckResultData? get last_check_result =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  num? get state_type => throw _privateConstructorUsedError;

  /// Serializes this AttrsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttrsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttrsDataCopyWith<AttrsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttrsDataCopyWith<$Res> {
  factory $AttrsDataCopyWith(AttrsData value, $Res Function(AttrsData) then) =
      _$AttrsDataCopyWithImpl<$Res, AttrsData>;
  @useResult
  $Res call({
    String? display_name,
    num? state,
    num? downtime_depth,
    num? acknowledgement,
    num? last_state_change,
    num? last_hard_state_change,
    num? last_check,
    LastCheckResultData? last_check_result,
    num? state_type,
  });

  $LastCheckResultDataCopyWith<$Res>? get last_check_result;
}

/// @nodoc
class _$AttrsDataCopyWithImpl<$Res, $Val extends AttrsData>
    implements $AttrsDataCopyWith<$Res> {
  _$AttrsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttrsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? display_name = freezed,
    Object? state = freezed,
    Object? downtime_depth = freezed,
    Object? acknowledgement = freezed,
    Object? last_state_change = freezed,
    Object? last_hard_state_change = freezed,
    Object? last_check = freezed,
    Object? last_check_result = freezed,
    Object? state_type = freezed,
  }) {
    return _then(
      _value.copyWith(
            display_name:
                freezed == display_name
                    ? _value.display_name
                    : display_name // ignore: cast_nullable_to_non_nullable
                        as String?,
            state:
                freezed == state
                    ? _value.state
                    : state // ignore: cast_nullable_to_non_nullable
                        as num?,
            downtime_depth:
                freezed == downtime_depth
                    ? _value.downtime_depth
                    : downtime_depth // ignore: cast_nullable_to_non_nullable
                        as num?,
            acknowledgement:
                freezed == acknowledgement
                    ? _value.acknowledgement
                    : acknowledgement // ignore: cast_nullable_to_non_nullable
                        as num?,
            last_state_change:
                freezed == last_state_change
                    ? _value.last_state_change
                    : last_state_change // ignore: cast_nullable_to_non_nullable
                        as num?,
            last_hard_state_change:
                freezed == last_hard_state_change
                    ? _value.last_hard_state_change
                    : last_hard_state_change // ignore: cast_nullable_to_non_nullable
                        as num?,
            last_check:
                freezed == last_check
                    ? _value.last_check
                    : last_check // ignore: cast_nullable_to_non_nullable
                        as num?,
            last_check_result:
                freezed == last_check_result
                    ? _value.last_check_result
                    : last_check_result // ignore: cast_nullable_to_non_nullable
                        as LastCheckResultData?,
            state_type:
                freezed == state_type
                    ? _value.state_type
                    : state_type // ignore: cast_nullable_to_non_nullable
                        as num?,
          )
          as $Val,
    );
  }

  /// Create a copy of AttrsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LastCheckResultDataCopyWith<$Res>? get last_check_result {
    if (_value.last_check_result == null) {
      return null;
    }

    return $LastCheckResultDataCopyWith<$Res>(_value.last_check_result!, (
      value,
    ) {
      return _then(_value.copyWith(last_check_result: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AttrsDataImplCopyWith<$Res>
    implements $AttrsDataCopyWith<$Res> {
  factory _$$AttrsDataImplCopyWith(
    _$AttrsDataImpl value,
    $Res Function(_$AttrsDataImpl) then,
  ) = __$$AttrsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? display_name,
    num? state,
    num? downtime_depth,
    num? acknowledgement,
    num? last_state_change,
    num? last_hard_state_change,
    num? last_check,
    LastCheckResultData? last_check_result,
    num? state_type,
  });

  @override
  $LastCheckResultDataCopyWith<$Res>? get last_check_result;
}

/// @nodoc
class __$$AttrsDataImplCopyWithImpl<$Res>
    extends _$AttrsDataCopyWithImpl<$Res, _$AttrsDataImpl>
    implements _$$AttrsDataImplCopyWith<$Res> {
  __$$AttrsDataImplCopyWithImpl(
    _$AttrsDataImpl _value,
    $Res Function(_$AttrsDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttrsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? display_name = freezed,
    Object? state = freezed,
    Object? downtime_depth = freezed,
    Object? acknowledgement = freezed,
    Object? last_state_change = freezed,
    Object? last_hard_state_change = freezed,
    Object? last_check = freezed,
    Object? last_check_result = freezed,
    Object? state_type = freezed,
  }) {
    return _then(
      _$AttrsDataImpl(
        display_name:
            freezed == display_name
                ? _value.display_name
                : display_name // ignore: cast_nullable_to_non_nullable
                    as String?,
        state:
            freezed == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                    as num?,
        downtime_depth:
            freezed == downtime_depth
                ? _value.downtime_depth
                : downtime_depth // ignore: cast_nullable_to_non_nullable
                    as num?,
        acknowledgement:
            freezed == acknowledgement
                ? _value.acknowledgement
                : acknowledgement // ignore: cast_nullable_to_non_nullable
                    as num?,
        last_state_change:
            freezed == last_state_change
                ? _value.last_state_change
                : last_state_change // ignore: cast_nullable_to_non_nullable
                    as num?,
        last_hard_state_change:
            freezed == last_hard_state_change
                ? _value.last_hard_state_change
                : last_hard_state_change // ignore: cast_nullable_to_non_nullable
                    as num?,
        last_check:
            freezed == last_check
                ? _value.last_check
                : last_check // ignore: cast_nullable_to_non_nullable
                    as num?,
        last_check_result:
            freezed == last_check_result
                ? _value.last_check_result
                : last_check_result // ignore: cast_nullable_to_non_nullable
                    as LastCheckResultData?,
        state_type:
            freezed == state_type
                ? _value.state_type
                : state_type // ignore: cast_nullable_to_non_nullable
                    as num?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttrsDataImpl implements _AttrsData {
  const _$AttrsDataImpl({
    this.display_name,
    this.state,
    this.downtime_depth,
    this.acknowledgement,
    this.last_state_change,
    this.last_hard_state_change,
    this.last_check,
    this.last_check_result,
    this.state_type,
  });

  factory _$AttrsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttrsDataImplFromJson(json);

  @override
  final String? display_name;
  @override
  final num? state;
  // ignore: non_constant_identifier_names
  @override
  final num? downtime_depth;
  @override
  final num? acknowledgement;
  // ignore: non_constant_identifier_names
  @override
  final num? last_state_change;
  // ignore: non_constant_identifier_names
  @override
  final num? last_hard_state_change;
  // ignore: non_constant_identifier_names
  @override
  final num? last_check;
  // ignore: non_constant_identifier_names
  @override
  final LastCheckResultData? last_check_result;
  // ignore: non_constant_identifier_names
  @override
  final num? state_type;

  @override
  String toString() {
    return 'AttrsData(display_name: $display_name, state: $state, downtime_depth: $downtime_depth, acknowledgement: $acknowledgement, last_state_change: $last_state_change, last_hard_state_change: $last_hard_state_change, last_check: $last_check, last_check_result: $last_check_result, state_type: $state_type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttrsDataImpl &&
            (identical(other.display_name, display_name) ||
                other.display_name == display_name) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.downtime_depth, downtime_depth) ||
                other.downtime_depth == downtime_depth) &&
            (identical(other.acknowledgement, acknowledgement) ||
                other.acknowledgement == acknowledgement) &&
            (identical(other.last_state_change, last_state_change) ||
                other.last_state_change == last_state_change) &&
            (identical(other.last_hard_state_change, last_hard_state_change) ||
                other.last_hard_state_change == last_hard_state_change) &&
            (identical(other.last_check, last_check) ||
                other.last_check == last_check) &&
            (identical(other.last_check_result, last_check_result) ||
                other.last_check_result == last_check_result) &&
            (identical(other.state_type, state_type) ||
                other.state_type == state_type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    display_name,
    state,
    downtime_depth,
    acknowledgement,
    last_state_change,
    last_hard_state_change,
    last_check,
    last_check_result,
    state_type,
  );

  /// Create a copy of AttrsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttrsDataImplCopyWith<_$AttrsDataImpl> get copyWith =>
      __$$AttrsDataImplCopyWithImpl<_$AttrsDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttrsDataImplToJson(this);
  }
}

abstract class _AttrsData implements AttrsData {
  const factory _AttrsData({
    final String? display_name,
    final num? state,
    final num? downtime_depth,
    final num? acknowledgement,
    final num? last_state_change,
    final num? last_hard_state_change,
    final num? last_check,
    final LastCheckResultData? last_check_result,
    final num? state_type,
  }) = _$AttrsDataImpl;

  factory _AttrsData.fromJson(Map<String, dynamic> json) =
      _$AttrsDataImpl.fromJson;

  @override
  String? get display_name;
  @override
  num? get state; // ignore: non_constant_identifier_names
  @override
  num? get downtime_depth;
  @override
  num? get acknowledgement; // ignore: non_constant_identifier_names
  @override
  num? get last_state_change; // ignore: non_constant_identifier_names
  @override
  num? get last_hard_state_change; // ignore: non_constant_identifier_names
  @override
  num? get last_check; // ignore: non_constant_identifier_names
  @override
  LastCheckResultData? get last_check_result; // ignore: non_constant_identifier_names
  @override
  num? get state_type;

  /// Create a copy of AttrsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttrsDataImplCopyWith<_$AttrsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LastCheckResultData _$LastCheckResultDataFromJson(Map<String, dynamic> json) {
  return _LastCheckResultData.fromJson(json);
}

/// @nodoc
mixin _$LastCheckResultData {
  String? get output => throw _privateConstructorUsedError;

  /// Serializes this LastCheckResultData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LastCheckResultData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LastCheckResultDataCopyWith<LastCheckResultData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LastCheckResultDataCopyWith<$Res> {
  factory $LastCheckResultDataCopyWith(
    LastCheckResultData value,
    $Res Function(LastCheckResultData) then,
  ) = _$LastCheckResultDataCopyWithImpl<$Res, LastCheckResultData>;
  @useResult
  $Res call({String? output});
}

/// @nodoc
class _$LastCheckResultDataCopyWithImpl<$Res, $Val extends LastCheckResultData>
    implements $LastCheckResultDataCopyWith<$Res> {
  _$LastCheckResultDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LastCheckResultData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? output = freezed}) {
    return _then(
      _value.copyWith(
            output:
                freezed == output
                    ? _value.output
                    : output // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LastCheckResultDataImplCopyWith<$Res>
    implements $LastCheckResultDataCopyWith<$Res> {
  factory _$$LastCheckResultDataImplCopyWith(
    _$LastCheckResultDataImpl value,
    $Res Function(_$LastCheckResultDataImpl) then,
  ) = __$$LastCheckResultDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? output});
}

/// @nodoc
class __$$LastCheckResultDataImplCopyWithImpl<$Res>
    extends _$LastCheckResultDataCopyWithImpl<$Res, _$LastCheckResultDataImpl>
    implements _$$LastCheckResultDataImplCopyWith<$Res> {
  __$$LastCheckResultDataImplCopyWithImpl(
    _$LastCheckResultDataImpl _value,
    $Res Function(_$LastCheckResultDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LastCheckResultData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? output = freezed}) {
    return _then(
      _$LastCheckResultDataImpl(
        output:
            freezed == output
                ? _value.output
                : output // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LastCheckResultDataImpl implements _LastCheckResultData {
  const _$LastCheckResultDataImpl({this.output});

  factory _$LastCheckResultDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$LastCheckResultDataImplFromJson(json);

  @override
  final String? output;

  @override
  String toString() {
    return 'LastCheckResultData(output: $output)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LastCheckResultDataImpl &&
            (identical(other.output, output) || other.output == output));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, output);

  /// Create a copy of LastCheckResultData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LastCheckResultDataImplCopyWith<_$LastCheckResultDataImpl> get copyWith =>
      __$$LastCheckResultDataImplCopyWithImpl<_$LastCheckResultDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LastCheckResultDataImplToJson(this);
  }
}

abstract class _LastCheckResultData implements LastCheckResultData {
  const factory _LastCheckResultData({final String? output}) =
      _$LastCheckResultDataImpl;

  factory _LastCheckResultData.fromJson(Map<String, dynamic> json) =
      _$LastCheckResultDataImpl.fromJson;

  @override
  String? get output;

  /// Create a copy of LastCheckResultData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LastCheckResultDataImplCopyWith<_$LastCheckResultDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

JoinsData _$JoinsDataFromJson(Map<String, dynamic> json) {
  return _JoinsData.fromJson(json);
}

/// @nodoc
mixin _$JoinsData {
  HostsData? get host => throw _privateConstructorUsedError;

  /// Serializes this JoinsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JoinsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JoinsDataCopyWith<JoinsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JoinsDataCopyWith<$Res> {
  factory $JoinsDataCopyWith(JoinsData value, $Res Function(JoinsData) then) =
      _$JoinsDataCopyWithImpl<$Res, JoinsData>;
  @useResult
  $Res call({HostsData? host});

  $HostsDataCopyWith<$Res>? get host;
}

/// @nodoc
class _$JoinsDataCopyWithImpl<$Res, $Val extends JoinsData>
    implements $JoinsDataCopyWith<$Res> {
  _$JoinsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JoinsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? host = freezed}) {
    return _then(
      _value.copyWith(
            host:
                freezed == host
                    ? _value.host
                    : host // ignore: cast_nullable_to_non_nullable
                        as HostsData?,
          )
          as $Val,
    );
  }

  /// Create a copy of JoinsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HostsDataCopyWith<$Res>? get host {
    if (_value.host == null) {
      return null;
    }

    return $HostsDataCopyWith<$Res>(_value.host!, (value) {
      return _then(_value.copyWith(host: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JoinsDataImplCopyWith<$Res>
    implements $JoinsDataCopyWith<$Res> {
  factory _$$JoinsDataImplCopyWith(
    _$JoinsDataImpl value,
    $Res Function(_$JoinsDataImpl) then,
  ) = __$$JoinsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({HostsData? host});

  @override
  $HostsDataCopyWith<$Res>? get host;
}

/// @nodoc
class __$$JoinsDataImplCopyWithImpl<$Res>
    extends _$JoinsDataCopyWithImpl<$Res, _$JoinsDataImpl>
    implements _$$JoinsDataImplCopyWith<$Res> {
  __$$JoinsDataImplCopyWithImpl(
    _$JoinsDataImpl _value,
    $Res Function(_$JoinsDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of JoinsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? host = freezed}) {
    return _then(
      _$JoinsDataImpl(
        host:
            freezed == host
                ? _value.host
                : host // ignore: cast_nullable_to_non_nullable
                    as HostsData?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JoinsDataImpl implements _JoinsData {
  const _$JoinsDataImpl({this.host});

  factory _$JoinsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$JoinsDataImplFromJson(json);

  @override
  final HostsData? host;

  @override
  String toString() {
    return 'JoinsData(host: $host)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JoinsDataImpl &&
            (identical(other.host, host) || other.host == host));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, host);

  /// Create a copy of JoinsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JoinsDataImplCopyWith<_$JoinsDataImpl> get copyWith =>
      __$$JoinsDataImplCopyWithImpl<_$JoinsDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JoinsDataImplToJson(this);
  }
}

abstract class _JoinsData implements JoinsData {
  const factory _JoinsData({final HostsData? host}) = _$JoinsDataImpl;

  factory _JoinsData.fromJson(Map<String, dynamic> json) =
      _$JoinsDataImpl.fromJson;

  @override
  HostsData? get host;

  /// Create a copy of JoinsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JoinsDataImplCopyWith<_$JoinsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HostsData _$HostsDataFromJson(Map<String, dynamic> json) {
  return _HostsData.fromJson(json);
}

/// @nodoc
mixin _$HostsData {
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this HostsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HostsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HostsDataCopyWith<HostsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HostsDataCopyWith<$Res> {
  factory $HostsDataCopyWith(HostsData value, $Res Function(HostsData) then) =
      _$HostsDataCopyWithImpl<$Res, HostsData>;
  @useResult
  $Res call({String? name});
}

/// @nodoc
class _$HostsDataCopyWithImpl<$Res, $Val extends HostsData>
    implements $HostsDataCopyWith<$Res> {
  _$HostsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HostsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = freezed}) {
    return _then(
      _value.copyWith(
            name:
                freezed == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HostsDataImplCopyWith<$Res>
    implements $HostsDataCopyWith<$Res> {
  factory _$$HostsDataImplCopyWith(
    _$HostsDataImpl value,
    $Res Function(_$HostsDataImpl) then,
  ) = __$$HostsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name});
}

/// @nodoc
class __$$HostsDataImplCopyWithImpl<$Res>
    extends _$HostsDataCopyWithImpl<$Res, _$HostsDataImpl>
    implements _$$HostsDataImplCopyWith<$Res> {
  __$$HostsDataImplCopyWithImpl(
    _$HostsDataImpl _value,
    $Res Function(_$HostsDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HostsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = freezed}) {
    return _then(
      _$HostsDataImpl(
        name:
            freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HostsDataImpl implements _HostsData {
  const _$HostsDataImpl({this.name});

  factory _$HostsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$HostsDataImplFromJson(json);

  @override
  final String? name;

  @override
  String toString() {
    return 'HostsData(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HostsDataImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of HostsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HostsDataImplCopyWith<_$HostsDataImpl> get copyWith =>
      __$$HostsDataImplCopyWithImpl<_$HostsDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HostsDataImplToJson(this);
  }
}

abstract class _HostsData implements HostsData {
  const factory _HostsData({final String? name}) = _$HostsDataImpl;

  factory _HostsData.fromJson(Map<String, dynamic> json) =
      _$HostsDataImpl.fromJson;

  @override
  String? get name;

  /// Create a copy of HostsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HostsDataImplCopyWith<_$HostsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
