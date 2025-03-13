// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alerts_prom.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PromAlertsData {

 String? get startsAt; String? get updatedAt; String? get endsAt; String? get generatorURL; AnnotationsData? get annotations; LabelsData? get labels; StatusData? get status;
/// Create a copy of PromAlertsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PromAlertsDataCopyWith<PromAlertsData> get copyWith => _$PromAlertsDataCopyWithImpl<PromAlertsData>(this as PromAlertsData, _$identity);

  /// Serializes this PromAlertsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PromAlertsData&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.generatorURL, generatorURL) || other.generatorURL == generatorURL)&&(identical(other.annotations, annotations) || other.annotations == annotations)&&(identical(other.labels, labels) || other.labels == labels)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startsAt,updatedAt,endsAt,generatorURL,annotations,labels,status);

@override
String toString() {
  return 'PromAlertsData(startsAt: $startsAt, updatedAt: $updatedAt, endsAt: $endsAt, generatorURL: $generatorURL, annotations: $annotations, labels: $labels, status: $status)';
}


}

/// @nodoc
abstract mixin class $PromAlertsDataCopyWith<$Res>  {
  factory $PromAlertsDataCopyWith(PromAlertsData value, $Res Function(PromAlertsData) _then) = _$PromAlertsDataCopyWithImpl;
@useResult
$Res call({
 String? startsAt, String? updatedAt, String? endsAt, String? generatorURL, AnnotationsData? annotations, LabelsData? labels, StatusData? status
});


$AnnotationsDataCopyWith<$Res>? get annotations;$LabelsDataCopyWith<$Res>? get labels;$StatusDataCopyWith<$Res>? get status;

}
/// @nodoc
class _$PromAlertsDataCopyWithImpl<$Res>
    implements $PromAlertsDataCopyWith<$Res> {
  _$PromAlertsDataCopyWithImpl(this._self, this._then);

  final PromAlertsData _self;
  final $Res Function(PromAlertsData) _then;

/// Create a copy of PromAlertsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startsAt = freezed,Object? updatedAt = freezed,Object? endsAt = freezed,Object? generatorURL = freezed,Object? annotations = freezed,Object? labels = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String?,generatorURL: freezed == generatorURL ? _self.generatorURL : generatorURL // ignore: cast_nullable_to_non_nullable
as String?,annotations: freezed == annotations ? _self.annotations : annotations // ignore: cast_nullable_to_non_nullable
as AnnotationsData?,labels: freezed == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as LabelsData?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StatusData?,
  ));
}
/// Create a copy of PromAlertsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnnotationsDataCopyWith<$Res>? get annotations {
    if (_self.annotations == null) {
    return null;
  }

  return $AnnotationsDataCopyWith<$Res>(_self.annotations!, (value) {
    return _then(_self.copyWith(annotations: value));
  });
}/// Create a copy of PromAlertsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LabelsDataCopyWith<$Res>? get labels {
    if (_self.labels == null) {
    return null;
  }

  return $LabelsDataCopyWith<$Res>(_self.labels!, (value) {
    return _then(_self.copyWith(labels: value));
  });
}/// Create a copy of PromAlertsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatusDataCopyWith<$Res>? get status {
    if (_self.status == null) {
    return null;
  }

  return $StatusDataCopyWith<$Res>(_self.status!, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _PromAlertsData implements PromAlertsData {
  const _PromAlertsData({this.startsAt, this.updatedAt, this.endsAt, this.generatorURL, this.annotations, this.labels, this.status});
  factory _PromAlertsData.fromJson(Map<String, dynamic> json) => _$PromAlertsDataFromJson(json);

@override final  String? startsAt;
@override final  String? updatedAt;
@override final  String? endsAt;
@override final  String? generatorURL;
@override final  AnnotationsData? annotations;
@override final  LabelsData? labels;
@override final  StatusData? status;

/// Create a copy of PromAlertsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PromAlertsDataCopyWith<_PromAlertsData> get copyWith => __$PromAlertsDataCopyWithImpl<_PromAlertsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PromAlertsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PromAlertsData&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.generatorURL, generatorURL) || other.generatorURL == generatorURL)&&(identical(other.annotations, annotations) || other.annotations == annotations)&&(identical(other.labels, labels) || other.labels == labels)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startsAt,updatedAt,endsAt,generatorURL,annotations,labels,status);

@override
String toString() {
  return 'PromAlertsData(startsAt: $startsAt, updatedAt: $updatedAt, endsAt: $endsAt, generatorURL: $generatorURL, annotations: $annotations, labels: $labels, status: $status)';
}


}

/// @nodoc
abstract mixin class _$PromAlertsDataCopyWith<$Res> implements $PromAlertsDataCopyWith<$Res> {
  factory _$PromAlertsDataCopyWith(_PromAlertsData value, $Res Function(_PromAlertsData) _then) = __$PromAlertsDataCopyWithImpl;
@override @useResult
$Res call({
 String? startsAt, String? updatedAt, String? endsAt, String? generatorURL, AnnotationsData? annotations, LabelsData? labels, StatusData? status
});


@override $AnnotationsDataCopyWith<$Res>? get annotations;@override $LabelsDataCopyWith<$Res>? get labels;@override $StatusDataCopyWith<$Res>? get status;

}
/// @nodoc
class __$PromAlertsDataCopyWithImpl<$Res>
    implements _$PromAlertsDataCopyWith<$Res> {
  __$PromAlertsDataCopyWithImpl(this._self, this._then);

  final _PromAlertsData _self;
  final $Res Function(_PromAlertsData) _then;

/// Create a copy of PromAlertsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startsAt = freezed,Object? updatedAt = freezed,Object? endsAt = freezed,Object? generatorURL = freezed,Object? annotations = freezed,Object? labels = freezed,Object? status = freezed,}) {
  return _then(_PromAlertsData(
startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String?,generatorURL: freezed == generatorURL ? _self.generatorURL : generatorURL // ignore: cast_nullable_to_non_nullable
as String?,annotations: freezed == annotations ? _self.annotations : annotations // ignore: cast_nullable_to_non_nullable
as AnnotationsData?,labels: freezed == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as LabelsData?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StatusData?,
  ));
}

/// Create a copy of PromAlertsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnnotationsDataCopyWith<$Res>? get annotations {
    if (_self.annotations == null) {
    return null;
  }

  return $AnnotationsDataCopyWith<$Res>(_self.annotations!, (value) {
    return _then(_self.copyWith(annotations: value));
  });
}/// Create a copy of PromAlertsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LabelsDataCopyWith<$Res>? get labels {
    if (_self.labels == null) {
    return null;
  }

  return $LabelsDataCopyWith<$Res>(_self.labels!, (value) {
    return _then(_self.copyWith(labels: value));
  });
}/// Create a copy of PromAlertsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatusDataCopyWith<$Res>? get status {
    if (_self.status == null) {
    return null;
  }

  return $StatusDataCopyWith<$Res>(_self.status!, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// @nodoc
mixin _$AnnotationsData {

 String? get summary;
/// Create a copy of AnnotationsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnotationsDataCopyWith<AnnotationsData> get copyWith => _$AnnotationsDataCopyWithImpl<AnnotationsData>(this as AnnotationsData, _$identity);

  /// Serializes this AnnotationsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnotationsData&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,summary);

@override
String toString() {
  return 'AnnotationsData(summary: $summary)';
}


}

/// @nodoc
abstract mixin class $AnnotationsDataCopyWith<$Res>  {
  factory $AnnotationsDataCopyWith(AnnotationsData value, $Res Function(AnnotationsData) _then) = _$AnnotationsDataCopyWithImpl;
@useResult
$Res call({
 String? summary
});




}
/// @nodoc
class _$AnnotationsDataCopyWithImpl<$Res>
    implements $AnnotationsDataCopyWith<$Res> {
  _$AnnotationsDataCopyWithImpl(this._self, this._then);

  final AnnotationsData _self;
  final $Res Function(AnnotationsData) _then;

/// Create a copy of AnnotationsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = freezed,}) {
  return _then(_self.copyWith(
summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AnnotationsData implements AnnotationsData {
  const _AnnotationsData({this.summary});
  factory _AnnotationsData.fromJson(Map<String, dynamic> json) => _$AnnotationsDataFromJson(json);

@override final  String? summary;

/// Create a copy of AnnotationsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnnotationsDataCopyWith<_AnnotationsData> get copyWith => __$AnnotationsDataCopyWithImpl<_AnnotationsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnnotationsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnnotationsData&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,summary);

@override
String toString() {
  return 'AnnotationsData(summary: $summary)';
}


}

/// @nodoc
abstract mixin class _$AnnotationsDataCopyWith<$Res> implements $AnnotationsDataCopyWith<$Res> {
  factory _$AnnotationsDataCopyWith(_AnnotationsData value, $Res Function(_AnnotationsData) _then) = __$AnnotationsDataCopyWithImpl;
@override @useResult
$Res call({
 String? summary
});




}
/// @nodoc
class __$AnnotationsDataCopyWithImpl<$Res>
    implements _$AnnotationsDataCopyWith<$Res> {
  __$AnnotationsDataCopyWithImpl(this._self, this._then);

  final _AnnotationsData _self;
  final $Res Function(_AnnotationsData) _then;

/// Create a copy of AnnotationsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = freezed,}) {
  return _then(_AnnotationsData(
summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$StatusData {

 List<Object>? get silencedBy;
/// Create a copy of StatusData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatusDataCopyWith<StatusData> get copyWith => _$StatusDataCopyWithImpl<StatusData>(this as StatusData, _$identity);

  /// Serializes this StatusData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatusData&&const DeepCollectionEquality().equals(other.silencedBy, silencedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(silencedBy));

@override
String toString() {
  return 'StatusData(silencedBy: $silencedBy)';
}


}

/// @nodoc
abstract mixin class $StatusDataCopyWith<$Res>  {
  factory $StatusDataCopyWith(StatusData value, $Res Function(StatusData) _then) = _$StatusDataCopyWithImpl;
@useResult
$Res call({
 List<Object>? silencedBy
});




}
/// @nodoc
class _$StatusDataCopyWithImpl<$Res>
    implements $StatusDataCopyWith<$Res> {
  _$StatusDataCopyWithImpl(this._self, this._then);

  final StatusData _self;
  final $Res Function(StatusData) _then;

/// Create a copy of StatusData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? silencedBy = freezed,}) {
  return _then(_self.copyWith(
silencedBy: freezed == silencedBy ? _self.silencedBy : silencedBy // ignore: cast_nullable_to_non_nullable
as List<Object>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _StatusData implements StatusData {
  const _StatusData({final  List<Object>? silencedBy}): _silencedBy = silencedBy;
  factory _StatusData.fromJson(Map<String, dynamic> json) => _$StatusDataFromJson(json);

 final  List<Object>? _silencedBy;
@override List<Object>? get silencedBy {
  final value = _silencedBy;
  if (value == null) return null;
  if (_silencedBy is EqualUnmodifiableListView) return _silencedBy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of StatusData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatusDataCopyWith<_StatusData> get copyWith => __$StatusDataCopyWithImpl<_StatusData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatusDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatusData&&const DeepCollectionEquality().equals(other._silencedBy, _silencedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_silencedBy));

@override
String toString() {
  return 'StatusData(silencedBy: $silencedBy)';
}


}

/// @nodoc
abstract mixin class _$StatusDataCopyWith<$Res> implements $StatusDataCopyWith<$Res> {
  factory _$StatusDataCopyWith(_StatusData value, $Res Function(_StatusData) _then) = __$StatusDataCopyWithImpl;
@override @useResult
$Res call({
 List<Object>? silencedBy
});




}
/// @nodoc
class __$StatusDataCopyWithImpl<$Res>
    implements _$StatusDataCopyWith<$Res> {
  __$StatusDataCopyWithImpl(this._self, this._then);

  final _StatusData _self;
  final $Res Function(_StatusData) _then;

/// Create a copy of StatusData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? silencedBy = freezed,}) {
  return _then(_StatusData(
silencedBy: freezed == silencedBy ? _self._silencedBy : silencedBy // ignore: cast_nullable_to_non_nullable
as List<Object>?,
  ));
}


}


/// @nodoc
mixin _$LabelsData {

 String? get severity;// ignore: non_constant_identifier_names
 String? get oav_type; String? get instance; String? get alertname;
/// Create a copy of LabelsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabelsDataCopyWith<LabelsData> get copyWith => _$LabelsDataCopyWithImpl<LabelsData>(this as LabelsData, _$identity);

  /// Serializes this LabelsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LabelsData&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.oav_type, oav_type) || other.oav_type == oav_type)&&(identical(other.instance, instance) || other.instance == instance)&&(identical(other.alertname, alertname) || other.alertname == alertname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,severity,oav_type,instance,alertname);

@override
String toString() {
  return 'LabelsData(severity: $severity, oav_type: $oav_type, instance: $instance, alertname: $alertname)';
}


}

/// @nodoc
abstract mixin class $LabelsDataCopyWith<$Res>  {
  factory $LabelsDataCopyWith(LabelsData value, $Res Function(LabelsData) _then) = _$LabelsDataCopyWithImpl;
@useResult
$Res call({
 String? severity, String? oav_type, String? instance, String? alertname
});




}
/// @nodoc
class _$LabelsDataCopyWithImpl<$Res>
    implements $LabelsDataCopyWith<$Res> {
  _$LabelsDataCopyWithImpl(this._self, this._then);

  final LabelsData _self;
  final $Res Function(LabelsData) _then;

/// Create a copy of LabelsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? severity = freezed,Object? oav_type = freezed,Object? instance = freezed,Object? alertname = freezed,}) {
  return _then(_self.copyWith(
severity: freezed == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String?,oav_type: freezed == oav_type ? _self.oav_type : oav_type // ignore: cast_nullable_to_non_nullable
as String?,instance: freezed == instance ? _self.instance : instance // ignore: cast_nullable_to_non_nullable
as String?,alertname: freezed == alertname ? _self.alertname : alertname // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _LabelsData implements LabelsData {
  const _LabelsData({this.severity, this.oav_type, this.instance, this.alertname});
  factory _LabelsData.fromJson(Map<String, dynamic> json) => _$LabelsDataFromJson(json);

@override final  String? severity;
// ignore: non_constant_identifier_names
@override final  String? oav_type;
@override final  String? instance;
@override final  String? alertname;

/// Create a copy of LabelsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LabelsDataCopyWith<_LabelsData> get copyWith => __$LabelsDataCopyWithImpl<_LabelsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LabelsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LabelsData&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.oav_type, oav_type) || other.oav_type == oav_type)&&(identical(other.instance, instance) || other.instance == instance)&&(identical(other.alertname, alertname) || other.alertname == alertname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,severity,oav_type,instance,alertname);

@override
String toString() {
  return 'LabelsData(severity: $severity, oav_type: $oav_type, instance: $instance, alertname: $alertname)';
}


}

/// @nodoc
abstract mixin class _$LabelsDataCopyWith<$Res> implements $LabelsDataCopyWith<$Res> {
  factory _$LabelsDataCopyWith(_LabelsData value, $Res Function(_LabelsData) _then) = __$LabelsDataCopyWithImpl;
@override @useResult
$Res call({
 String? severity, String? oav_type, String? instance, String? alertname
});




}
/// @nodoc
class __$LabelsDataCopyWithImpl<$Res>
    implements _$LabelsDataCopyWith<$Res> {
  __$LabelsDataCopyWithImpl(this._self, this._then);

  final _LabelsData _self;
  final $Res Function(_LabelsData) _then;

/// Create a copy of LabelsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? severity = freezed,Object? oav_type = freezed,Object? instance = freezed,Object? alertname = freezed,}) {
  return _then(_LabelsData(
severity: freezed == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String?,oav_type: freezed == oav_type ? _self.oav_type : oav_type // ignore: cast_nullable_to_non_nullable
as String?,instance: freezed == instance ? _self.instance : instance // ignore: cast_nullable_to_non_nullable
as String?,alertname: freezed == alertname ? _self.alertname : alertname // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
