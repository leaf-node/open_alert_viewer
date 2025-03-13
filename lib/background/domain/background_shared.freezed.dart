// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'background_shared.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IsolateMessage {

 MessageName get name; MessageDestination? get destination; int? get id; List<Alert>? get alerts; AlertSourceDataUpdate? get sourceData; bool? get forceRefreshNow; bool? get alreadyFetching;
/// Create a copy of IsolateMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IsolateMessageCopyWith<IsolateMessage> get copyWith => _$IsolateMessageCopyWithImpl<IsolateMessage>(this as IsolateMessage, _$identity);

  /// Serializes this IsolateMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IsolateMessage&&(identical(other.name, name) || other.name == name)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.alerts, alerts)&&(identical(other.sourceData, sourceData) || other.sourceData == sourceData)&&(identical(other.forceRefreshNow, forceRefreshNow) || other.forceRefreshNow == forceRefreshNow)&&(identical(other.alreadyFetching, alreadyFetching) || other.alreadyFetching == alreadyFetching));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,destination,id,const DeepCollectionEquality().hash(alerts),sourceData,forceRefreshNow,alreadyFetching);

@override
String toString() {
  return 'IsolateMessage(name: $name, destination: $destination, id: $id, alerts: $alerts, sourceData: $sourceData, forceRefreshNow: $forceRefreshNow, alreadyFetching: $alreadyFetching)';
}


}

/// @nodoc
abstract mixin class $IsolateMessageCopyWith<$Res>  {
  factory $IsolateMessageCopyWith(IsolateMessage value, $Res Function(IsolateMessage) _then) = _$IsolateMessageCopyWithImpl;
@useResult
$Res call({
 MessageName name, MessageDestination? destination, int? id, List<Alert>? alerts, AlertSourceDataUpdate? sourceData, bool? forceRefreshNow, bool? alreadyFetching
});


$AlertSourceDataUpdateCopyWith<$Res>? get sourceData;

}
/// @nodoc
class _$IsolateMessageCopyWithImpl<$Res>
    implements $IsolateMessageCopyWith<$Res> {
  _$IsolateMessageCopyWithImpl(this._self, this._then);

  final IsolateMessage _self;
  final $Res Function(IsolateMessage) _then;

/// Create a copy of IsolateMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? destination = freezed,Object? id = freezed,Object? alerts = freezed,Object? sourceData = freezed,Object? forceRefreshNow = freezed,Object? alreadyFetching = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as MessageName,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as MessageDestination?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,alerts: freezed == alerts ? _self.alerts : alerts // ignore: cast_nullable_to_non_nullable
as List<Alert>?,sourceData: freezed == sourceData ? _self.sourceData : sourceData // ignore: cast_nullable_to_non_nullable
as AlertSourceDataUpdate?,forceRefreshNow: freezed == forceRefreshNow ? _self.forceRefreshNow : forceRefreshNow // ignore: cast_nullable_to_non_nullable
as bool?,alreadyFetching: freezed == alreadyFetching ? _self.alreadyFetching : alreadyFetching // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}
/// Create a copy of IsolateMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AlertSourceDataUpdateCopyWith<$Res>? get sourceData {
    if (_self.sourceData == null) {
    return null;
  }

  return $AlertSourceDataUpdateCopyWith<$Res>(_self.sourceData!, (value) {
    return _then(_self.copyWith(sourceData: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _IsolateMessage implements IsolateMessage {
  const _IsolateMessage({required this.name, this.destination, this.id, final  List<Alert>? alerts, this.sourceData, this.forceRefreshNow, this.alreadyFetching}): _alerts = alerts;
  factory _IsolateMessage.fromJson(Map<String, dynamic> json) => _$IsolateMessageFromJson(json);

@override final  MessageName name;
@override final  MessageDestination? destination;
@override final  int? id;
 final  List<Alert>? _alerts;
@override List<Alert>? get alerts {
  final value = _alerts;
  if (value == null) return null;
  if (_alerts is EqualUnmodifiableListView) return _alerts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  AlertSourceDataUpdate? sourceData;
@override final  bool? forceRefreshNow;
@override final  bool? alreadyFetching;

/// Create a copy of IsolateMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IsolateMessageCopyWith<_IsolateMessage> get copyWith => __$IsolateMessageCopyWithImpl<_IsolateMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IsolateMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IsolateMessage&&(identical(other.name, name) || other.name == name)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._alerts, _alerts)&&(identical(other.sourceData, sourceData) || other.sourceData == sourceData)&&(identical(other.forceRefreshNow, forceRefreshNow) || other.forceRefreshNow == forceRefreshNow)&&(identical(other.alreadyFetching, alreadyFetching) || other.alreadyFetching == alreadyFetching));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,destination,id,const DeepCollectionEquality().hash(_alerts),sourceData,forceRefreshNow,alreadyFetching);

@override
String toString() {
  return 'IsolateMessage(name: $name, destination: $destination, id: $id, alerts: $alerts, sourceData: $sourceData, forceRefreshNow: $forceRefreshNow, alreadyFetching: $alreadyFetching)';
}


}

/// @nodoc
abstract mixin class _$IsolateMessageCopyWith<$Res> implements $IsolateMessageCopyWith<$Res> {
  factory _$IsolateMessageCopyWith(_IsolateMessage value, $Res Function(_IsolateMessage) _then) = __$IsolateMessageCopyWithImpl;
@override @useResult
$Res call({
 MessageName name, MessageDestination? destination, int? id, List<Alert>? alerts, AlertSourceDataUpdate? sourceData, bool? forceRefreshNow, bool? alreadyFetching
});


@override $AlertSourceDataUpdateCopyWith<$Res>? get sourceData;

}
/// @nodoc
class __$IsolateMessageCopyWithImpl<$Res>
    implements _$IsolateMessageCopyWith<$Res> {
  __$IsolateMessageCopyWithImpl(this._self, this._then);

  final _IsolateMessage _self;
  final $Res Function(_IsolateMessage) _then;

/// Create a copy of IsolateMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? destination = freezed,Object? id = freezed,Object? alerts = freezed,Object? sourceData = freezed,Object? forceRefreshNow = freezed,Object? alreadyFetching = freezed,}) {
  return _then(_IsolateMessage(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as MessageName,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as MessageDestination?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,alerts: freezed == alerts ? _self._alerts : alerts // ignore: cast_nullable_to_non_nullable
as List<Alert>?,sourceData: freezed == sourceData ? _self.sourceData : sourceData // ignore: cast_nullable_to_non_nullable
as AlertSourceDataUpdate?,forceRefreshNow: freezed == forceRefreshNow ? _self.forceRefreshNow : forceRefreshNow // ignore: cast_nullable_to_non_nullable
as bool?,alreadyFetching: freezed == alreadyFetching ? _self.alreadyFetching : alreadyFetching // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

/// Create a copy of IsolateMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AlertSourceDataUpdateCopyWith<$Res>? get sourceData {
    if (_self.sourceData == null) {
    return null;
  }

  return $AlertSourceDataUpdateCopyWith<$Res>(_self.sourceData!, (value) {
    return _then(_self.copyWith(sourceData: value));
  });
}
}

// dart format on
