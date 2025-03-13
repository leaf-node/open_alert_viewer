// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alerts_ici.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IciAlertsData {

 List<IciResultsData>? get results;
/// Create a copy of IciAlertsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IciAlertsDataCopyWith<IciAlertsData> get copyWith => _$IciAlertsDataCopyWithImpl<IciAlertsData>(this as IciAlertsData, _$identity);

  /// Serializes this IciAlertsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IciAlertsData&&const DeepCollectionEquality().equals(other.results, results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(results));

@override
String toString() {
  return 'IciAlertsData(results: $results)';
}


}

/// @nodoc
abstract mixin class $IciAlertsDataCopyWith<$Res>  {
  factory $IciAlertsDataCopyWith(IciAlertsData value, $Res Function(IciAlertsData) _then) = _$IciAlertsDataCopyWithImpl;
@useResult
$Res call({
 List<IciResultsData>? results
});




}
/// @nodoc
class _$IciAlertsDataCopyWithImpl<$Res>
    implements $IciAlertsDataCopyWith<$Res> {
  _$IciAlertsDataCopyWithImpl(this._self, this._then);

  final IciAlertsData _self;
  final $Res Function(IciAlertsData) _then;

/// Create a copy of IciAlertsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? results = freezed,}) {
  return _then(_self.copyWith(
results: freezed == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<IciResultsData>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _IciAlertsData implements IciAlertsData {
  const _IciAlertsData({final  List<IciResultsData>? results}): _results = results;
  factory _IciAlertsData.fromJson(Map<String, dynamic> json) => _$IciAlertsDataFromJson(json);

 final  List<IciResultsData>? _results;
@override List<IciResultsData>? get results {
  final value = _results;
  if (value == null) return null;
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of IciAlertsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IciAlertsDataCopyWith<_IciAlertsData> get copyWith => __$IciAlertsDataCopyWithImpl<_IciAlertsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IciAlertsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IciAlertsData&&const DeepCollectionEquality().equals(other._results, _results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_results));

@override
String toString() {
  return 'IciAlertsData(results: $results)';
}


}

/// @nodoc
abstract mixin class _$IciAlertsDataCopyWith<$Res> implements $IciAlertsDataCopyWith<$Res> {
  factory _$IciAlertsDataCopyWith(_IciAlertsData value, $Res Function(_IciAlertsData) _then) = __$IciAlertsDataCopyWithImpl;
@override @useResult
$Res call({
 List<IciResultsData>? results
});




}
/// @nodoc
class __$IciAlertsDataCopyWithImpl<$Res>
    implements _$IciAlertsDataCopyWith<$Res> {
  __$IciAlertsDataCopyWithImpl(this._self, this._then);

  final _IciAlertsData _self;
  final $Res Function(_IciAlertsData) _then;

/// Create a copy of IciAlertsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? results = freezed,}) {
  return _then(_IciAlertsData(
results: freezed == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<IciResultsData>?,
  ));
}


}


/// @nodoc
mixin _$IciResultsData {

 AttrsData? get attrs; JoinsData? get joins;
/// Create a copy of IciResultsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IciResultsDataCopyWith<IciResultsData> get copyWith => _$IciResultsDataCopyWithImpl<IciResultsData>(this as IciResultsData, _$identity);

  /// Serializes this IciResultsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IciResultsData&&(identical(other.attrs, attrs) || other.attrs == attrs)&&(identical(other.joins, joins) || other.joins == joins));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,attrs,joins);

@override
String toString() {
  return 'IciResultsData(attrs: $attrs, joins: $joins)';
}


}

/// @nodoc
abstract mixin class $IciResultsDataCopyWith<$Res>  {
  factory $IciResultsDataCopyWith(IciResultsData value, $Res Function(IciResultsData) _then) = _$IciResultsDataCopyWithImpl;
@useResult
$Res call({
 AttrsData? attrs, JoinsData? joins
});


$AttrsDataCopyWith<$Res>? get attrs;$JoinsDataCopyWith<$Res>? get joins;

}
/// @nodoc
class _$IciResultsDataCopyWithImpl<$Res>
    implements $IciResultsDataCopyWith<$Res> {
  _$IciResultsDataCopyWithImpl(this._self, this._then);

  final IciResultsData _self;
  final $Res Function(IciResultsData) _then;

/// Create a copy of IciResultsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? attrs = freezed,Object? joins = freezed,}) {
  return _then(_self.copyWith(
attrs: freezed == attrs ? _self.attrs : attrs // ignore: cast_nullable_to_non_nullable
as AttrsData?,joins: freezed == joins ? _self.joins : joins // ignore: cast_nullable_to_non_nullable
as JoinsData?,
  ));
}
/// Create a copy of IciResultsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttrsDataCopyWith<$Res>? get attrs {
    if (_self.attrs == null) {
    return null;
  }

  return $AttrsDataCopyWith<$Res>(_self.attrs!, (value) {
    return _then(_self.copyWith(attrs: value));
  });
}/// Create a copy of IciResultsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JoinsDataCopyWith<$Res>? get joins {
    if (_self.joins == null) {
    return null;
  }

  return $JoinsDataCopyWith<$Res>(_self.joins!, (value) {
    return _then(_self.copyWith(joins: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _IciResultsData implements IciResultsData {
  const _IciResultsData({this.attrs, this.joins});
  factory _IciResultsData.fromJson(Map<String, dynamic> json) => _$IciResultsDataFromJson(json);

@override final  AttrsData? attrs;
@override final  JoinsData? joins;

/// Create a copy of IciResultsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IciResultsDataCopyWith<_IciResultsData> get copyWith => __$IciResultsDataCopyWithImpl<_IciResultsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IciResultsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IciResultsData&&(identical(other.attrs, attrs) || other.attrs == attrs)&&(identical(other.joins, joins) || other.joins == joins));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,attrs,joins);

@override
String toString() {
  return 'IciResultsData(attrs: $attrs, joins: $joins)';
}


}

/// @nodoc
abstract mixin class _$IciResultsDataCopyWith<$Res> implements $IciResultsDataCopyWith<$Res> {
  factory _$IciResultsDataCopyWith(_IciResultsData value, $Res Function(_IciResultsData) _then) = __$IciResultsDataCopyWithImpl;
@override @useResult
$Res call({
 AttrsData? attrs, JoinsData? joins
});


@override $AttrsDataCopyWith<$Res>? get attrs;@override $JoinsDataCopyWith<$Res>? get joins;

}
/// @nodoc
class __$IciResultsDataCopyWithImpl<$Res>
    implements _$IciResultsDataCopyWith<$Res> {
  __$IciResultsDataCopyWithImpl(this._self, this._then);

  final _IciResultsData _self;
  final $Res Function(_IciResultsData) _then;

/// Create a copy of IciResultsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? attrs = freezed,Object? joins = freezed,}) {
  return _then(_IciResultsData(
attrs: freezed == attrs ? _self.attrs : attrs // ignore: cast_nullable_to_non_nullable
as AttrsData?,joins: freezed == joins ? _self.joins : joins // ignore: cast_nullable_to_non_nullable
as JoinsData?,
  ));
}

/// Create a copy of IciResultsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttrsDataCopyWith<$Res>? get attrs {
    if (_self.attrs == null) {
    return null;
  }

  return $AttrsDataCopyWith<$Res>(_self.attrs!, (value) {
    return _then(_self.copyWith(attrs: value));
  });
}/// Create a copy of IciResultsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JoinsDataCopyWith<$Res>? get joins {
    if (_self.joins == null) {
    return null;
  }

  return $JoinsDataCopyWith<$Res>(_self.joins!, (value) {
    return _then(_self.copyWith(joins: value));
  });
}
}


/// @nodoc
mixin _$AttrsData {

 String? get display_name; num? get state;// ignore: non_constant_identifier_names
 num? get downtime_depth; num? get acknowledgement;// ignore: non_constant_identifier_names
 num? get last_state_change;// ignore: non_constant_identifier_names
 num? get last_hard_state_change;// ignore: non_constant_identifier_names
 num? get last_check;// ignore: non_constant_identifier_names
 LastCheckResultData? get last_check_result;// ignore: non_constant_identifier_names
 num? get state_type;
/// Create a copy of AttrsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttrsDataCopyWith<AttrsData> get copyWith => _$AttrsDataCopyWithImpl<AttrsData>(this as AttrsData, _$identity);

  /// Serializes this AttrsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttrsData&&(identical(other.display_name, display_name) || other.display_name == display_name)&&(identical(other.state, state) || other.state == state)&&(identical(other.downtime_depth, downtime_depth) || other.downtime_depth == downtime_depth)&&(identical(other.acknowledgement, acknowledgement) || other.acknowledgement == acknowledgement)&&(identical(other.last_state_change, last_state_change) || other.last_state_change == last_state_change)&&(identical(other.last_hard_state_change, last_hard_state_change) || other.last_hard_state_change == last_hard_state_change)&&(identical(other.last_check, last_check) || other.last_check == last_check)&&(identical(other.last_check_result, last_check_result) || other.last_check_result == last_check_result)&&(identical(other.state_type, state_type) || other.state_type == state_type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,display_name,state,downtime_depth,acknowledgement,last_state_change,last_hard_state_change,last_check,last_check_result,state_type);

@override
String toString() {
  return 'AttrsData(display_name: $display_name, state: $state, downtime_depth: $downtime_depth, acknowledgement: $acknowledgement, last_state_change: $last_state_change, last_hard_state_change: $last_hard_state_change, last_check: $last_check, last_check_result: $last_check_result, state_type: $state_type)';
}


}

/// @nodoc
abstract mixin class $AttrsDataCopyWith<$Res>  {
  factory $AttrsDataCopyWith(AttrsData value, $Res Function(AttrsData) _then) = _$AttrsDataCopyWithImpl;
@useResult
$Res call({
 String? display_name, num? state, num? downtime_depth, num? acknowledgement, num? last_state_change, num? last_hard_state_change, num? last_check, LastCheckResultData? last_check_result, num? state_type
});


$LastCheckResultDataCopyWith<$Res>? get last_check_result;

}
/// @nodoc
class _$AttrsDataCopyWithImpl<$Res>
    implements $AttrsDataCopyWith<$Res> {
  _$AttrsDataCopyWithImpl(this._self, this._then);

  final AttrsData _self;
  final $Res Function(AttrsData) _then;

/// Create a copy of AttrsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? display_name = freezed,Object? state = freezed,Object? downtime_depth = freezed,Object? acknowledgement = freezed,Object? last_state_change = freezed,Object? last_hard_state_change = freezed,Object? last_check = freezed,Object? last_check_result = freezed,Object? state_type = freezed,}) {
  return _then(_self.copyWith(
display_name: freezed == display_name ? _self.display_name : display_name // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as num?,downtime_depth: freezed == downtime_depth ? _self.downtime_depth : downtime_depth // ignore: cast_nullable_to_non_nullable
as num?,acknowledgement: freezed == acknowledgement ? _self.acknowledgement : acknowledgement // ignore: cast_nullable_to_non_nullable
as num?,last_state_change: freezed == last_state_change ? _self.last_state_change : last_state_change // ignore: cast_nullable_to_non_nullable
as num?,last_hard_state_change: freezed == last_hard_state_change ? _self.last_hard_state_change : last_hard_state_change // ignore: cast_nullable_to_non_nullable
as num?,last_check: freezed == last_check ? _self.last_check : last_check // ignore: cast_nullable_to_non_nullable
as num?,last_check_result: freezed == last_check_result ? _self.last_check_result : last_check_result // ignore: cast_nullable_to_non_nullable
as LastCheckResultData?,state_type: freezed == state_type ? _self.state_type : state_type // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}
/// Create a copy of AttrsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LastCheckResultDataCopyWith<$Res>? get last_check_result {
    if (_self.last_check_result == null) {
    return null;
  }

  return $LastCheckResultDataCopyWith<$Res>(_self.last_check_result!, (value) {
    return _then(_self.copyWith(last_check_result: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _AttrsData implements AttrsData {
  const _AttrsData({this.display_name, this.state, this.downtime_depth, this.acknowledgement, this.last_state_change, this.last_hard_state_change, this.last_check, this.last_check_result, this.state_type});
  factory _AttrsData.fromJson(Map<String, dynamic> json) => _$AttrsDataFromJson(json);

@override final  String? display_name;
@override final  num? state;
// ignore: non_constant_identifier_names
@override final  num? downtime_depth;
@override final  num? acknowledgement;
// ignore: non_constant_identifier_names
@override final  num? last_state_change;
// ignore: non_constant_identifier_names
@override final  num? last_hard_state_change;
// ignore: non_constant_identifier_names
@override final  num? last_check;
// ignore: non_constant_identifier_names
@override final  LastCheckResultData? last_check_result;
// ignore: non_constant_identifier_names
@override final  num? state_type;

/// Create a copy of AttrsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttrsDataCopyWith<_AttrsData> get copyWith => __$AttrsDataCopyWithImpl<_AttrsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttrsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttrsData&&(identical(other.display_name, display_name) || other.display_name == display_name)&&(identical(other.state, state) || other.state == state)&&(identical(other.downtime_depth, downtime_depth) || other.downtime_depth == downtime_depth)&&(identical(other.acknowledgement, acknowledgement) || other.acknowledgement == acknowledgement)&&(identical(other.last_state_change, last_state_change) || other.last_state_change == last_state_change)&&(identical(other.last_hard_state_change, last_hard_state_change) || other.last_hard_state_change == last_hard_state_change)&&(identical(other.last_check, last_check) || other.last_check == last_check)&&(identical(other.last_check_result, last_check_result) || other.last_check_result == last_check_result)&&(identical(other.state_type, state_type) || other.state_type == state_type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,display_name,state,downtime_depth,acknowledgement,last_state_change,last_hard_state_change,last_check,last_check_result,state_type);

@override
String toString() {
  return 'AttrsData(display_name: $display_name, state: $state, downtime_depth: $downtime_depth, acknowledgement: $acknowledgement, last_state_change: $last_state_change, last_hard_state_change: $last_hard_state_change, last_check: $last_check, last_check_result: $last_check_result, state_type: $state_type)';
}


}

/// @nodoc
abstract mixin class _$AttrsDataCopyWith<$Res> implements $AttrsDataCopyWith<$Res> {
  factory _$AttrsDataCopyWith(_AttrsData value, $Res Function(_AttrsData) _then) = __$AttrsDataCopyWithImpl;
@override @useResult
$Res call({
 String? display_name, num? state, num? downtime_depth, num? acknowledgement, num? last_state_change, num? last_hard_state_change, num? last_check, LastCheckResultData? last_check_result, num? state_type
});


@override $LastCheckResultDataCopyWith<$Res>? get last_check_result;

}
/// @nodoc
class __$AttrsDataCopyWithImpl<$Res>
    implements _$AttrsDataCopyWith<$Res> {
  __$AttrsDataCopyWithImpl(this._self, this._then);

  final _AttrsData _self;
  final $Res Function(_AttrsData) _then;

/// Create a copy of AttrsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? display_name = freezed,Object? state = freezed,Object? downtime_depth = freezed,Object? acknowledgement = freezed,Object? last_state_change = freezed,Object? last_hard_state_change = freezed,Object? last_check = freezed,Object? last_check_result = freezed,Object? state_type = freezed,}) {
  return _then(_AttrsData(
display_name: freezed == display_name ? _self.display_name : display_name // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as num?,downtime_depth: freezed == downtime_depth ? _self.downtime_depth : downtime_depth // ignore: cast_nullable_to_non_nullable
as num?,acknowledgement: freezed == acknowledgement ? _self.acknowledgement : acknowledgement // ignore: cast_nullable_to_non_nullable
as num?,last_state_change: freezed == last_state_change ? _self.last_state_change : last_state_change // ignore: cast_nullable_to_non_nullable
as num?,last_hard_state_change: freezed == last_hard_state_change ? _self.last_hard_state_change : last_hard_state_change // ignore: cast_nullable_to_non_nullable
as num?,last_check: freezed == last_check ? _self.last_check : last_check // ignore: cast_nullable_to_non_nullable
as num?,last_check_result: freezed == last_check_result ? _self.last_check_result : last_check_result // ignore: cast_nullable_to_non_nullable
as LastCheckResultData?,state_type: freezed == state_type ? _self.state_type : state_type // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}

/// Create a copy of AttrsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LastCheckResultDataCopyWith<$Res>? get last_check_result {
    if (_self.last_check_result == null) {
    return null;
  }

  return $LastCheckResultDataCopyWith<$Res>(_self.last_check_result!, (value) {
    return _then(_self.copyWith(last_check_result: value));
  });
}
}


/// @nodoc
mixin _$LastCheckResultData {

 String? get output;
/// Create a copy of LastCheckResultData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LastCheckResultDataCopyWith<LastCheckResultData> get copyWith => _$LastCheckResultDataCopyWithImpl<LastCheckResultData>(this as LastCheckResultData, _$identity);

  /// Serializes this LastCheckResultData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LastCheckResultData&&(identical(other.output, output) || other.output == output));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,output);

@override
String toString() {
  return 'LastCheckResultData(output: $output)';
}


}

/// @nodoc
abstract mixin class $LastCheckResultDataCopyWith<$Res>  {
  factory $LastCheckResultDataCopyWith(LastCheckResultData value, $Res Function(LastCheckResultData) _then) = _$LastCheckResultDataCopyWithImpl;
@useResult
$Res call({
 String? output
});




}
/// @nodoc
class _$LastCheckResultDataCopyWithImpl<$Res>
    implements $LastCheckResultDataCopyWith<$Res> {
  _$LastCheckResultDataCopyWithImpl(this._self, this._then);

  final LastCheckResultData _self;
  final $Res Function(LastCheckResultData) _then;

/// Create a copy of LastCheckResultData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? output = freezed,}) {
  return _then(_self.copyWith(
output: freezed == output ? _self.output : output // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _LastCheckResultData implements LastCheckResultData {
  const _LastCheckResultData({this.output});
  factory _LastCheckResultData.fromJson(Map<String, dynamic> json) => _$LastCheckResultDataFromJson(json);

@override final  String? output;

/// Create a copy of LastCheckResultData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LastCheckResultDataCopyWith<_LastCheckResultData> get copyWith => __$LastCheckResultDataCopyWithImpl<_LastCheckResultData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LastCheckResultDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LastCheckResultData&&(identical(other.output, output) || other.output == output));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,output);

@override
String toString() {
  return 'LastCheckResultData(output: $output)';
}


}

/// @nodoc
abstract mixin class _$LastCheckResultDataCopyWith<$Res> implements $LastCheckResultDataCopyWith<$Res> {
  factory _$LastCheckResultDataCopyWith(_LastCheckResultData value, $Res Function(_LastCheckResultData) _then) = __$LastCheckResultDataCopyWithImpl;
@override @useResult
$Res call({
 String? output
});




}
/// @nodoc
class __$LastCheckResultDataCopyWithImpl<$Res>
    implements _$LastCheckResultDataCopyWith<$Res> {
  __$LastCheckResultDataCopyWithImpl(this._self, this._then);

  final _LastCheckResultData _self;
  final $Res Function(_LastCheckResultData) _then;

/// Create a copy of LastCheckResultData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? output = freezed,}) {
  return _then(_LastCheckResultData(
output: freezed == output ? _self.output : output // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$JoinsData {

 HostsData? get host;
/// Create a copy of JoinsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JoinsDataCopyWith<JoinsData> get copyWith => _$JoinsDataCopyWithImpl<JoinsData>(this as JoinsData, _$identity);

  /// Serializes this JoinsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinsData&&(identical(other.host, host) || other.host == host));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,host);

@override
String toString() {
  return 'JoinsData(host: $host)';
}


}

/// @nodoc
abstract mixin class $JoinsDataCopyWith<$Res>  {
  factory $JoinsDataCopyWith(JoinsData value, $Res Function(JoinsData) _then) = _$JoinsDataCopyWithImpl;
@useResult
$Res call({
 HostsData? host
});


$HostsDataCopyWith<$Res>? get host;

}
/// @nodoc
class _$JoinsDataCopyWithImpl<$Res>
    implements $JoinsDataCopyWith<$Res> {
  _$JoinsDataCopyWithImpl(this._self, this._then);

  final JoinsData _self;
  final $Res Function(JoinsData) _then;

/// Create a copy of JoinsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? host = freezed,}) {
  return _then(_self.copyWith(
host: freezed == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as HostsData?,
  ));
}
/// Create a copy of JoinsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HostsDataCopyWith<$Res>? get host {
    if (_self.host == null) {
    return null;
  }

  return $HostsDataCopyWith<$Res>(_self.host!, (value) {
    return _then(_self.copyWith(host: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _JoinsData implements JoinsData {
  const _JoinsData({this.host});
  factory _JoinsData.fromJson(Map<String, dynamic> json) => _$JoinsDataFromJson(json);

@override final  HostsData? host;

/// Create a copy of JoinsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JoinsDataCopyWith<_JoinsData> get copyWith => __$JoinsDataCopyWithImpl<_JoinsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JoinsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JoinsData&&(identical(other.host, host) || other.host == host));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,host);

@override
String toString() {
  return 'JoinsData(host: $host)';
}


}

/// @nodoc
abstract mixin class _$JoinsDataCopyWith<$Res> implements $JoinsDataCopyWith<$Res> {
  factory _$JoinsDataCopyWith(_JoinsData value, $Res Function(_JoinsData) _then) = __$JoinsDataCopyWithImpl;
@override @useResult
$Res call({
 HostsData? host
});


@override $HostsDataCopyWith<$Res>? get host;

}
/// @nodoc
class __$JoinsDataCopyWithImpl<$Res>
    implements _$JoinsDataCopyWith<$Res> {
  __$JoinsDataCopyWithImpl(this._self, this._then);

  final _JoinsData _self;
  final $Res Function(_JoinsData) _then;

/// Create a copy of JoinsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? host = freezed,}) {
  return _then(_JoinsData(
host: freezed == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as HostsData?,
  ));
}

/// Create a copy of JoinsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HostsDataCopyWith<$Res>? get host {
    if (_self.host == null) {
    return null;
  }

  return $HostsDataCopyWith<$Res>(_self.host!, (value) {
    return _then(_self.copyWith(host: value));
  });
}
}


/// @nodoc
mixin _$HostsData {

 String? get name;
/// Create a copy of HostsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HostsDataCopyWith<HostsData> get copyWith => _$HostsDataCopyWithImpl<HostsData>(this as HostsData, _$identity);

  /// Serializes this HostsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HostsData&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'HostsData(name: $name)';
}


}

/// @nodoc
abstract mixin class $HostsDataCopyWith<$Res>  {
  factory $HostsDataCopyWith(HostsData value, $Res Function(HostsData) _then) = _$HostsDataCopyWithImpl;
@useResult
$Res call({
 String? name
});




}
/// @nodoc
class _$HostsDataCopyWithImpl<$Res>
    implements $HostsDataCopyWith<$Res> {
  _$HostsDataCopyWithImpl(this._self, this._then);

  final HostsData _self;
  final $Res Function(HostsData) _then;

/// Create a copy of HostsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _HostsData implements HostsData {
  const _HostsData({this.name});
  factory _HostsData.fromJson(Map<String, dynamic> json) => _$HostsDataFromJson(json);

@override final  String? name;

/// Create a copy of HostsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HostsDataCopyWith<_HostsData> get copyWith => __$HostsDataCopyWithImpl<_HostsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HostsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HostsData&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'HostsData(name: $name)';
}


}

/// @nodoc
abstract mixin class _$HostsDataCopyWith<$Res> implements $HostsDataCopyWith<$Res> {
  factory _$HostsDataCopyWith(_HostsData value, $Res Function(_HostsData) _then) = __$HostsDataCopyWithImpl;
@override @useResult
$Res call({
 String? name
});




}
/// @nodoc
class __$HostsDataCopyWithImpl<$Res>
    implements _$HostsDataCopyWith<$Res> {
  __$HostsDataCopyWithImpl(this._self, this._then);

  final _HostsData _self;
  final $Res Function(_HostsData) _then;

/// Create a copy of HostsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,}) {
  return _then(_HostsData(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
