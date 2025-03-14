// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alerts_prom.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PromAlertsData _$PromAlertsDataFromJson(Map<String, dynamic> json) {
  return _PromAlertsData.fromJson(json);
}

/// @nodoc
mixin _$PromAlertsData {
  String? get startsAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;
  String? get endsAt => throw _privateConstructorUsedError;
  String? get generatorURL => throw _privateConstructorUsedError;
  AnnotationsData? get annotations => throw _privateConstructorUsedError;
  LabelsData? get labels => throw _privateConstructorUsedError;
  StatusData? get status => throw _privateConstructorUsedError;

  /// Serializes this PromAlertsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PromAlertsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PromAlertsDataCopyWith<PromAlertsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromAlertsDataCopyWith<$Res> {
  factory $PromAlertsDataCopyWith(
    PromAlertsData value,
    $Res Function(PromAlertsData) then,
  ) = _$PromAlertsDataCopyWithImpl<$Res, PromAlertsData>;
  @useResult
  $Res call({
    String? startsAt,
    String? updatedAt,
    String? endsAt,
    String? generatorURL,
    AnnotationsData? annotations,
    LabelsData? labels,
    StatusData? status,
  });

  $AnnotationsDataCopyWith<$Res>? get annotations;
  $LabelsDataCopyWith<$Res>? get labels;
  $StatusDataCopyWith<$Res>? get status;
}

/// @nodoc
class _$PromAlertsDataCopyWithImpl<$Res, $Val extends PromAlertsData>
    implements $PromAlertsDataCopyWith<$Res> {
  _$PromAlertsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PromAlertsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startsAt = freezed,
    Object? updatedAt = freezed,
    Object? endsAt = freezed,
    Object? generatorURL = freezed,
    Object? annotations = freezed,
    Object? labels = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _value.copyWith(
            startsAt:
                freezed == startsAt
                    ? _value.startsAt
                    : startsAt // ignore: cast_nullable_to_non_nullable
                        as String?,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as String?,
            endsAt:
                freezed == endsAt
                    ? _value.endsAt
                    : endsAt // ignore: cast_nullable_to_non_nullable
                        as String?,
            generatorURL:
                freezed == generatorURL
                    ? _value.generatorURL
                    : generatorURL // ignore: cast_nullable_to_non_nullable
                        as String?,
            annotations:
                freezed == annotations
                    ? _value.annotations
                    : annotations // ignore: cast_nullable_to_non_nullable
                        as AnnotationsData?,
            labels:
                freezed == labels
                    ? _value.labels
                    : labels // ignore: cast_nullable_to_non_nullable
                        as LabelsData?,
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as StatusData?,
          )
          as $Val,
    );
  }

  /// Create a copy of PromAlertsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AnnotationsDataCopyWith<$Res>? get annotations {
    if (_value.annotations == null) {
      return null;
    }

    return $AnnotationsDataCopyWith<$Res>(_value.annotations!, (value) {
      return _then(_value.copyWith(annotations: value) as $Val);
    });
  }

  /// Create a copy of PromAlertsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LabelsDataCopyWith<$Res>? get labels {
    if (_value.labels == null) {
      return null;
    }

    return $LabelsDataCopyWith<$Res>(_value.labels!, (value) {
      return _then(_value.copyWith(labels: value) as $Val);
    });
  }

  /// Create a copy of PromAlertsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StatusDataCopyWith<$Res>? get status {
    if (_value.status == null) {
      return null;
    }

    return $StatusDataCopyWith<$Res>(_value.status!, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PromAlertsDataImplCopyWith<$Res>
    implements $PromAlertsDataCopyWith<$Res> {
  factory _$$PromAlertsDataImplCopyWith(
    _$PromAlertsDataImpl value,
    $Res Function(_$PromAlertsDataImpl) then,
  ) = __$$PromAlertsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? startsAt,
    String? updatedAt,
    String? endsAt,
    String? generatorURL,
    AnnotationsData? annotations,
    LabelsData? labels,
    StatusData? status,
  });

  @override
  $AnnotationsDataCopyWith<$Res>? get annotations;
  @override
  $LabelsDataCopyWith<$Res>? get labels;
  @override
  $StatusDataCopyWith<$Res>? get status;
}

/// @nodoc
class __$$PromAlertsDataImplCopyWithImpl<$Res>
    extends _$PromAlertsDataCopyWithImpl<$Res, _$PromAlertsDataImpl>
    implements _$$PromAlertsDataImplCopyWith<$Res> {
  __$$PromAlertsDataImplCopyWithImpl(
    _$PromAlertsDataImpl _value,
    $Res Function(_$PromAlertsDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PromAlertsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startsAt = freezed,
    Object? updatedAt = freezed,
    Object? endsAt = freezed,
    Object? generatorURL = freezed,
    Object? annotations = freezed,
    Object? labels = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _$PromAlertsDataImpl(
        startsAt:
            freezed == startsAt
                ? _value.startsAt
                : startsAt // ignore: cast_nullable_to_non_nullable
                    as String?,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as String?,
        endsAt:
            freezed == endsAt
                ? _value.endsAt
                : endsAt // ignore: cast_nullable_to_non_nullable
                    as String?,
        generatorURL:
            freezed == generatorURL
                ? _value.generatorURL
                : generatorURL // ignore: cast_nullable_to_non_nullable
                    as String?,
        annotations:
            freezed == annotations
                ? _value.annotations
                : annotations // ignore: cast_nullable_to_non_nullable
                    as AnnotationsData?,
        labels:
            freezed == labels
                ? _value.labels
                : labels // ignore: cast_nullable_to_non_nullable
                    as LabelsData?,
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as StatusData?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PromAlertsDataImpl implements _PromAlertsData {
  const _$PromAlertsDataImpl({
    this.startsAt,
    this.updatedAt,
    this.endsAt,
    this.generatorURL,
    this.annotations,
    this.labels,
    this.status,
  });

  factory _$PromAlertsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromAlertsDataImplFromJson(json);

  @override
  final String? startsAt;
  @override
  final String? updatedAt;
  @override
  final String? endsAt;
  @override
  final String? generatorURL;
  @override
  final AnnotationsData? annotations;
  @override
  final LabelsData? labels;
  @override
  final StatusData? status;

  @override
  String toString() {
    return 'PromAlertsData(startsAt: $startsAt, updatedAt: $updatedAt, endsAt: $endsAt, generatorURL: $generatorURL, annotations: $annotations, labels: $labels, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromAlertsDataImpl &&
            (identical(other.startsAt, startsAt) ||
                other.startsAt == startsAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.endsAt, endsAt) || other.endsAt == endsAt) &&
            (identical(other.generatorURL, generatorURL) ||
                other.generatorURL == generatorURL) &&
            (identical(other.annotations, annotations) ||
                other.annotations == annotations) &&
            (identical(other.labels, labels) || other.labels == labels) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    startsAt,
    updatedAt,
    endsAt,
    generatorURL,
    annotations,
    labels,
    status,
  );

  /// Create a copy of PromAlertsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PromAlertsDataImplCopyWith<_$PromAlertsDataImpl> get copyWith =>
      __$$PromAlertsDataImplCopyWithImpl<_$PromAlertsDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PromAlertsDataImplToJson(this);
  }
}

abstract class _PromAlertsData implements PromAlertsData {
  const factory _PromAlertsData({
    final String? startsAt,
    final String? updatedAt,
    final String? endsAt,
    final String? generatorURL,
    final AnnotationsData? annotations,
    final LabelsData? labels,
    final StatusData? status,
  }) = _$PromAlertsDataImpl;

  factory _PromAlertsData.fromJson(Map<String, dynamic> json) =
      _$PromAlertsDataImpl.fromJson;

  @override
  String? get startsAt;
  @override
  String? get updatedAt;
  @override
  String? get endsAt;
  @override
  String? get generatorURL;
  @override
  AnnotationsData? get annotations;
  @override
  LabelsData? get labels;
  @override
  StatusData? get status;

  /// Create a copy of PromAlertsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PromAlertsDataImplCopyWith<_$PromAlertsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnnotationsData _$AnnotationsDataFromJson(Map<String, dynamic> json) {
  return _AnnotationsData.fromJson(json);
}

/// @nodoc
mixin _$AnnotationsData {
  String? get summary => throw _privateConstructorUsedError;

  /// Serializes this AnnotationsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnnotationsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnnotationsDataCopyWith<AnnotationsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnnotationsDataCopyWith<$Res> {
  factory $AnnotationsDataCopyWith(
    AnnotationsData value,
    $Res Function(AnnotationsData) then,
  ) = _$AnnotationsDataCopyWithImpl<$Res, AnnotationsData>;
  @useResult
  $Res call({String? summary});
}

/// @nodoc
class _$AnnotationsDataCopyWithImpl<$Res, $Val extends AnnotationsData>
    implements $AnnotationsDataCopyWith<$Res> {
  _$AnnotationsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnnotationsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? summary = freezed}) {
    return _then(
      _value.copyWith(
            summary:
                freezed == summary
                    ? _value.summary
                    : summary // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnnotationsDataImplCopyWith<$Res>
    implements $AnnotationsDataCopyWith<$Res> {
  factory _$$AnnotationsDataImplCopyWith(
    _$AnnotationsDataImpl value,
    $Res Function(_$AnnotationsDataImpl) then,
  ) = __$$AnnotationsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? summary});
}

/// @nodoc
class __$$AnnotationsDataImplCopyWithImpl<$Res>
    extends _$AnnotationsDataCopyWithImpl<$Res, _$AnnotationsDataImpl>
    implements _$$AnnotationsDataImplCopyWith<$Res> {
  __$$AnnotationsDataImplCopyWithImpl(
    _$AnnotationsDataImpl _value,
    $Res Function(_$AnnotationsDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnnotationsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? summary = freezed}) {
    return _then(
      _$AnnotationsDataImpl(
        summary:
            freezed == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnnotationsDataImpl implements _AnnotationsData {
  const _$AnnotationsDataImpl({this.summary});

  factory _$AnnotationsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnnotationsDataImplFromJson(json);

  @override
  final String? summary;

  @override
  String toString() {
    return 'AnnotationsData(summary: $summary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnnotationsDataImpl &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, summary);

  /// Create a copy of AnnotationsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnnotationsDataImplCopyWith<_$AnnotationsDataImpl> get copyWith =>
      __$$AnnotationsDataImplCopyWithImpl<_$AnnotationsDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnnotationsDataImplToJson(this);
  }
}

abstract class _AnnotationsData implements AnnotationsData {
  const factory _AnnotationsData({final String? summary}) =
      _$AnnotationsDataImpl;

  factory _AnnotationsData.fromJson(Map<String, dynamic> json) =
      _$AnnotationsDataImpl.fromJson;

  @override
  String? get summary;

  /// Create a copy of AnnotationsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnnotationsDataImplCopyWith<_$AnnotationsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StatusData _$StatusDataFromJson(Map<String, dynamic> json) {
  return _StatusData.fromJson(json);
}

/// @nodoc
mixin _$StatusData {
  List<Object>? get silencedBy => throw _privateConstructorUsedError;

  /// Serializes this StatusData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StatusData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatusDataCopyWith<StatusData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusDataCopyWith<$Res> {
  factory $StatusDataCopyWith(
    StatusData value,
    $Res Function(StatusData) then,
  ) = _$StatusDataCopyWithImpl<$Res, StatusData>;
  @useResult
  $Res call({List<Object>? silencedBy});
}

/// @nodoc
class _$StatusDataCopyWithImpl<$Res, $Val extends StatusData>
    implements $StatusDataCopyWith<$Res> {
  _$StatusDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatusData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? silencedBy = freezed}) {
    return _then(
      _value.copyWith(
            silencedBy:
                freezed == silencedBy
                    ? _value.silencedBy
                    : silencedBy // ignore: cast_nullable_to_non_nullable
                        as List<Object>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StatusDataImplCopyWith<$Res>
    implements $StatusDataCopyWith<$Res> {
  factory _$$StatusDataImplCopyWith(
    _$StatusDataImpl value,
    $Res Function(_$StatusDataImpl) then,
  ) = __$$StatusDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Object>? silencedBy});
}

/// @nodoc
class __$$StatusDataImplCopyWithImpl<$Res>
    extends _$StatusDataCopyWithImpl<$Res, _$StatusDataImpl>
    implements _$$StatusDataImplCopyWith<$Res> {
  __$$StatusDataImplCopyWithImpl(
    _$StatusDataImpl _value,
    $Res Function(_$StatusDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StatusData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? silencedBy = freezed}) {
    return _then(
      _$StatusDataImpl(
        silencedBy:
            freezed == silencedBy
                ? _value._silencedBy
                : silencedBy // ignore: cast_nullable_to_non_nullable
                    as List<Object>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusDataImpl implements _StatusData {
  const _$StatusDataImpl({final List<Object>? silencedBy})
    : _silencedBy = silencedBy;

  factory _$StatusDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusDataImplFromJson(json);

  final List<Object>? _silencedBy;
  @override
  List<Object>? get silencedBy {
    final value = _silencedBy;
    if (value == null) return null;
    if (_silencedBy is EqualUnmodifiableListView) return _silencedBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'StatusData(silencedBy: $silencedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusDataImpl &&
            const DeepCollectionEquality().equals(
              other._silencedBy,
              _silencedBy,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_silencedBy),
  );

  /// Create a copy of StatusData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusDataImplCopyWith<_$StatusDataImpl> get copyWith =>
      __$$StatusDataImplCopyWithImpl<_$StatusDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusDataImplToJson(this);
  }
}

abstract class _StatusData implements StatusData {
  const factory _StatusData({final List<Object>? silencedBy}) =
      _$StatusDataImpl;

  factory _StatusData.fromJson(Map<String, dynamic> json) =
      _$StatusDataImpl.fromJson;

  @override
  List<Object>? get silencedBy;

  /// Create a copy of StatusData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusDataImplCopyWith<_$StatusDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LabelsData _$LabelsDataFromJson(Map<String, dynamic> json) {
  return _LabelsData.fromJson(json);
}

/// @nodoc
mixin _$LabelsData {
  String? get severity =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  String? get oav_type => throw _privateConstructorUsedError;
  String? get instance => throw _privateConstructorUsedError;
  String? get alertname => throw _privateConstructorUsedError;

  /// Serializes this LabelsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LabelsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LabelsDataCopyWith<LabelsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LabelsDataCopyWith<$Res> {
  factory $LabelsDataCopyWith(
    LabelsData value,
    $Res Function(LabelsData) then,
  ) = _$LabelsDataCopyWithImpl<$Res, LabelsData>;
  @useResult
  $Res call({
    String? severity,
    String? oav_type,
    String? instance,
    String? alertname,
  });
}

/// @nodoc
class _$LabelsDataCopyWithImpl<$Res, $Val extends LabelsData>
    implements $LabelsDataCopyWith<$Res> {
  _$LabelsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LabelsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? severity = freezed,
    Object? oav_type = freezed,
    Object? instance = freezed,
    Object? alertname = freezed,
  }) {
    return _then(
      _value.copyWith(
            severity:
                freezed == severity
                    ? _value.severity
                    : severity // ignore: cast_nullable_to_non_nullable
                        as String?,
            oav_type:
                freezed == oav_type
                    ? _value.oav_type
                    : oav_type // ignore: cast_nullable_to_non_nullable
                        as String?,
            instance:
                freezed == instance
                    ? _value.instance
                    : instance // ignore: cast_nullable_to_non_nullable
                        as String?,
            alertname:
                freezed == alertname
                    ? _value.alertname
                    : alertname // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LabelsDataImplCopyWith<$Res>
    implements $LabelsDataCopyWith<$Res> {
  factory _$$LabelsDataImplCopyWith(
    _$LabelsDataImpl value,
    $Res Function(_$LabelsDataImpl) then,
  ) = __$$LabelsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? severity,
    String? oav_type,
    String? instance,
    String? alertname,
  });
}

/// @nodoc
class __$$LabelsDataImplCopyWithImpl<$Res>
    extends _$LabelsDataCopyWithImpl<$Res, _$LabelsDataImpl>
    implements _$$LabelsDataImplCopyWith<$Res> {
  __$$LabelsDataImplCopyWithImpl(
    _$LabelsDataImpl _value,
    $Res Function(_$LabelsDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LabelsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? severity = freezed,
    Object? oav_type = freezed,
    Object? instance = freezed,
    Object? alertname = freezed,
  }) {
    return _then(
      _$LabelsDataImpl(
        severity:
            freezed == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                    as String?,
        oav_type:
            freezed == oav_type
                ? _value.oav_type
                : oav_type // ignore: cast_nullable_to_non_nullable
                    as String?,
        instance:
            freezed == instance
                ? _value.instance
                : instance // ignore: cast_nullable_to_non_nullable
                    as String?,
        alertname:
            freezed == alertname
                ? _value.alertname
                : alertname // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LabelsDataImpl implements _LabelsData {
  const _$LabelsDataImpl({
    this.severity,
    this.oav_type,
    this.instance,
    this.alertname,
  });

  factory _$LabelsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$LabelsDataImplFromJson(json);

  @override
  final String? severity;
  // ignore: non_constant_identifier_names
  @override
  final String? oav_type;
  @override
  final String? instance;
  @override
  final String? alertname;

  @override
  String toString() {
    return 'LabelsData(severity: $severity, oav_type: $oav_type, instance: $instance, alertname: $alertname)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LabelsDataImpl &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.oav_type, oav_type) ||
                other.oav_type == oav_type) &&
            (identical(other.instance, instance) ||
                other.instance == instance) &&
            (identical(other.alertname, alertname) ||
                other.alertname == alertname));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, severity, oav_type, instance, alertname);

  /// Create a copy of LabelsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LabelsDataImplCopyWith<_$LabelsDataImpl> get copyWith =>
      __$$LabelsDataImplCopyWithImpl<_$LabelsDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LabelsDataImplToJson(this);
  }
}

abstract class _LabelsData implements LabelsData {
  const factory _LabelsData({
    final String? severity,
    final String? oav_type,
    final String? instance,
    final String? alertname,
  }) = _$LabelsDataImpl;

  factory _LabelsData.fromJson(Map<String, dynamic> json) =
      _$LabelsDataImpl.fromJson;

  @override
  String? get severity; // ignore: non_constant_identifier_names
  @override
  String? get oav_type;
  @override
  String? get instance;
  @override
  String? get alertname;

  /// Create a copy of LabelsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LabelsDataImplCopyWith<_$LabelsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
