// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alerts_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RefreshIconState {

 RefreshIconStatus get status; bool get alreadyFetching; bool get forceRefreshNow;
/// Create a copy of RefreshIconState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefreshIconStateCopyWith<RefreshIconState> get copyWith => _$RefreshIconStateCopyWithImpl<RefreshIconState>(this as RefreshIconState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshIconState&&(identical(other.status, status) || other.status == status)&&(identical(other.alreadyFetching, alreadyFetching) || other.alreadyFetching == alreadyFetching)&&(identical(other.forceRefreshNow, forceRefreshNow) || other.forceRefreshNow == forceRefreshNow));
}


@override
int get hashCode => Object.hash(runtimeType,status,alreadyFetching,forceRefreshNow);

@override
String toString() {
  return 'RefreshIconState(status: $status, alreadyFetching: $alreadyFetching, forceRefreshNow: $forceRefreshNow)';
}


}

/// @nodoc
abstract mixin class $RefreshIconStateCopyWith<$Res>  {
  factory $RefreshIconStateCopyWith(RefreshIconState value, $Res Function(RefreshIconState) _then) = _$RefreshIconStateCopyWithImpl;
@useResult
$Res call({
 RefreshIconStatus status, bool alreadyFetching, bool forceRefreshNow
});




}
/// @nodoc
class _$RefreshIconStateCopyWithImpl<$Res>
    implements $RefreshIconStateCopyWith<$Res> {
  _$RefreshIconStateCopyWithImpl(this._self, this._then);

  final RefreshIconState _self;
  final $Res Function(RefreshIconState) _then;

/// Create a copy of RefreshIconState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? alreadyFetching = null,Object? forceRefreshNow = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RefreshIconStatus,alreadyFetching: null == alreadyFetching ? _self.alreadyFetching : alreadyFetching // ignore: cast_nullable_to_non_nullable
as bool,forceRefreshNow: null == forceRefreshNow ? _self.forceRefreshNow : forceRefreshNow // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _RefreshIconState implements RefreshIconState {
  const _RefreshIconState({required this.status, required this.alreadyFetching, required this.forceRefreshNow});
  

@override final  RefreshIconStatus status;
@override final  bool alreadyFetching;
@override final  bool forceRefreshNow;

/// Create a copy of RefreshIconState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefreshIconStateCopyWith<_RefreshIconState> get copyWith => __$RefreshIconStateCopyWithImpl<_RefreshIconState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshIconState&&(identical(other.status, status) || other.status == status)&&(identical(other.alreadyFetching, alreadyFetching) || other.alreadyFetching == alreadyFetching)&&(identical(other.forceRefreshNow, forceRefreshNow) || other.forceRefreshNow == forceRefreshNow));
}


@override
int get hashCode => Object.hash(runtimeType,status,alreadyFetching,forceRefreshNow);

@override
String toString() {
  return 'RefreshIconState(status: $status, alreadyFetching: $alreadyFetching, forceRefreshNow: $forceRefreshNow)';
}


}

/// @nodoc
abstract mixin class _$RefreshIconStateCopyWith<$Res> implements $RefreshIconStateCopyWith<$Res> {
  factory _$RefreshIconStateCopyWith(_RefreshIconState value, $Res Function(_RefreshIconState) _then) = __$RefreshIconStateCopyWithImpl;
@override @useResult
$Res call({
 RefreshIconStatus status, bool alreadyFetching, bool forceRefreshNow
});




}
/// @nodoc
class __$RefreshIconStateCopyWithImpl<$Res>
    implements _$RefreshIconStateCopyWith<$Res> {
  __$RefreshIconStateCopyWithImpl(this._self, this._then);

  final _RefreshIconState _self;
  final $Res Function(_RefreshIconState) _then;

/// Create a copy of RefreshIconState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? alreadyFetching = null,Object? forceRefreshNow = null,}) {
  return _then(_RefreshIconState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RefreshIconStatus,alreadyFetching: null == alreadyFetching ? _self.alreadyFetching : alreadyFetching // ignore: cast_nullable_to_non_nullable
as bool,forceRefreshNow: null == forceRefreshNow ? _self.forceRefreshNow : forceRefreshNow // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$AlertsCubitState {

 Map<String, Object> get settings; FetchingStatus get status; RefreshIconState get refresh; List<Alert> get alerts; List<Alert> get filteredAlerts; List<AlertSourceData> get sources; bool get showNotificationStatusWidget; bool get showVisibilityStatusWidget; bool get showSoundStatusWidget; bool get showFilterStatusWidget; String get emptyPaneMessage;
/// Create a copy of AlertsCubitState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlertsCubitStateCopyWith<AlertsCubitState> get copyWith => _$AlertsCubitStateCopyWithImpl<AlertsCubitState>(this as AlertsCubitState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlertsCubitState&&const DeepCollectionEquality().equals(other.settings, settings)&&(identical(other.status, status) || other.status == status)&&(identical(other.refresh, refresh) || other.refresh == refresh)&&const DeepCollectionEquality().equals(other.alerts, alerts)&&const DeepCollectionEquality().equals(other.filteredAlerts, filteredAlerts)&&const DeepCollectionEquality().equals(other.sources, sources)&&(identical(other.showNotificationStatusWidget, showNotificationStatusWidget) || other.showNotificationStatusWidget == showNotificationStatusWidget)&&(identical(other.showVisibilityStatusWidget, showVisibilityStatusWidget) || other.showVisibilityStatusWidget == showVisibilityStatusWidget)&&(identical(other.showSoundStatusWidget, showSoundStatusWidget) || other.showSoundStatusWidget == showSoundStatusWidget)&&(identical(other.showFilterStatusWidget, showFilterStatusWidget) || other.showFilterStatusWidget == showFilterStatusWidget)&&(identical(other.emptyPaneMessage, emptyPaneMessage) || other.emptyPaneMessage == emptyPaneMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(settings),status,refresh,const DeepCollectionEquality().hash(alerts),const DeepCollectionEquality().hash(filteredAlerts),const DeepCollectionEquality().hash(sources),showNotificationStatusWidget,showVisibilityStatusWidget,showSoundStatusWidget,showFilterStatusWidget,emptyPaneMessage);

@override
String toString() {
  return 'AlertsCubitState(settings: $settings, status: $status, refresh: $refresh, alerts: $alerts, filteredAlerts: $filteredAlerts, sources: $sources, showNotificationStatusWidget: $showNotificationStatusWidget, showVisibilityStatusWidget: $showVisibilityStatusWidget, showSoundStatusWidget: $showSoundStatusWidget, showFilterStatusWidget: $showFilterStatusWidget, emptyPaneMessage: $emptyPaneMessage)';
}


}

/// @nodoc
abstract mixin class $AlertsCubitStateCopyWith<$Res>  {
  factory $AlertsCubitStateCopyWith(AlertsCubitState value, $Res Function(AlertsCubitState) _then) = _$AlertsCubitStateCopyWithImpl;
@useResult
$Res call({
 Map<String, Object> settings, FetchingStatus status, RefreshIconState refresh, List<Alert> alerts, List<Alert> filteredAlerts, List<AlertSourceData> sources, bool showNotificationStatusWidget, bool showVisibilityStatusWidget, bool showSoundStatusWidget, bool showFilterStatusWidget, String emptyPaneMessage
});


$RefreshIconStateCopyWith<$Res> get refresh;

}
/// @nodoc
class _$AlertsCubitStateCopyWithImpl<$Res>
    implements $AlertsCubitStateCopyWith<$Res> {
  _$AlertsCubitStateCopyWithImpl(this._self, this._then);

  final AlertsCubitState _self;
  final $Res Function(AlertsCubitState) _then;

/// Create a copy of AlertsCubitState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? settings = null,Object? status = null,Object? refresh = null,Object? alerts = null,Object? filteredAlerts = null,Object? sources = null,Object? showNotificationStatusWidget = null,Object? showVisibilityStatusWidget = null,Object? showSoundStatusWidget = null,Object? showFilterStatusWidget = null,Object? emptyPaneMessage = null,}) {
  return _then(_self.copyWith(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as Map<String, Object>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FetchingStatus,refresh: null == refresh ? _self.refresh : refresh // ignore: cast_nullable_to_non_nullable
as RefreshIconState,alerts: null == alerts ? _self.alerts : alerts // ignore: cast_nullable_to_non_nullable
as List<Alert>,filteredAlerts: null == filteredAlerts ? _self.filteredAlerts : filteredAlerts // ignore: cast_nullable_to_non_nullable
as List<Alert>,sources: null == sources ? _self.sources : sources // ignore: cast_nullable_to_non_nullable
as List<AlertSourceData>,showNotificationStatusWidget: null == showNotificationStatusWidget ? _self.showNotificationStatusWidget : showNotificationStatusWidget // ignore: cast_nullable_to_non_nullable
as bool,showVisibilityStatusWidget: null == showVisibilityStatusWidget ? _self.showVisibilityStatusWidget : showVisibilityStatusWidget // ignore: cast_nullable_to_non_nullable
as bool,showSoundStatusWidget: null == showSoundStatusWidget ? _self.showSoundStatusWidget : showSoundStatusWidget // ignore: cast_nullable_to_non_nullable
as bool,showFilterStatusWidget: null == showFilterStatusWidget ? _self.showFilterStatusWidget : showFilterStatusWidget // ignore: cast_nullable_to_non_nullable
as bool,emptyPaneMessage: null == emptyPaneMessage ? _self.emptyPaneMessage : emptyPaneMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of AlertsCubitState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RefreshIconStateCopyWith<$Res> get refresh {
  
  return $RefreshIconStateCopyWith<$Res>(_self.refresh, (value) {
    return _then(_self.copyWith(refresh: value));
  });
}
}


/// @nodoc


class _AlertsCubitState implements AlertsCubitState {
  const _AlertsCubitState({required final  Map<String, Object> settings, required this.status, required this.refresh, required final  List<Alert> alerts, required final  List<Alert> filteredAlerts, required final  List<AlertSourceData> sources, required this.showNotificationStatusWidget, required this.showVisibilityStatusWidget, required this.showSoundStatusWidget, required this.showFilterStatusWidget, required this.emptyPaneMessage}): _settings = settings,_alerts = alerts,_filteredAlerts = filteredAlerts,_sources = sources;
  

 final  Map<String, Object> _settings;
@override Map<String, Object> get settings {
  if (_settings is EqualUnmodifiableMapView) return _settings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_settings);
}

@override final  FetchingStatus status;
@override final  RefreshIconState refresh;
 final  List<Alert> _alerts;
@override List<Alert> get alerts {
  if (_alerts is EqualUnmodifiableListView) return _alerts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_alerts);
}

 final  List<Alert> _filteredAlerts;
@override List<Alert> get filteredAlerts {
  if (_filteredAlerts is EqualUnmodifiableListView) return _filteredAlerts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredAlerts);
}

 final  List<AlertSourceData> _sources;
@override List<AlertSourceData> get sources {
  if (_sources is EqualUnmodifiableListView) return _sources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sources);
}

@override final  bool showNotificationStatusWidget;
@override final  bool showVisibilityStatusWidget;
@override final  bool showSoundStatusWidget;
@override final  bool showFilterStatusWidget;
@override final  String emptyPaneMessage;

/// Create a copy of AlertsCubitState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlertsCubitStateCopyWith<_AlertsCubitState> get copyWith => __$AlertsCubitStateCopyWithImpl<_AlertsCubitState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlertsCubitState&&const DeepCollectionEquality().equals(other._settings, _settings)&&(identical(other.status, status) || other.status == status)&&(identical(other.refresh, refresh) || other.refresh == refresh)&&const DeepCollectionEquality().equals(other._alerts, _alerts)&&const DeepCollectionEquality().equals(other._filteredAlerts, _filteredAlerts)&&const DeepCollectionEquality().equals(other._sources, _sources)&&(identical(other.showNotificationStatusWidget, showNotificationStatusWidget) || other.showNotificationStatusWidget == showNotificationStatusWidget)&&(identical(other.showVisibilityStatusWidget, showVisibilityStatusWidget) || other.showVisibilityStatusWidget == showVisibilityStatusWidget)&&(identical(other.showSoundStatusWidget, showSoundStatusWidget) || other.showSoundStatusWidget == showSoundStatusWidget)&&(identical(other.showFilterStatusWidget, showFilterStatusWidget) || other.showFilterStatusWidget == showFilterStatusWidget)&&(identical(other.emptyPaneMessage, emptyPaneMessage) || other.emptyPaneMessage == emptyPaneMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_settings),status,refresh,const DeepCollectionEquality().hash(_alerts),const DeepCollectionEquality().hash(_filteredAlerts),const DeepCollectionEquality().hash(_sources),showNotificationStatusWidget,showVisibilityStatusWidget,showSoundStatusWidget,showFilterStatusWidget,emptyPaneMessage);

@override
String toString() {
  return 'AlertsCubitState(settings: $settings, status: $status, refresh: $refresh, alerts: $alerts, filteredAlerts: $filteredAlerts, sources: $sources, showNotificationStatusWidget: $showNotificationStatusWidget, showVisibilityStatusWidget: $showVisibilityStatusWidget, showSoundStatusWidget: $showSoundStatusWidget, showFilterStatusWidget: $showFilterStatusWidget, emptyPaneMessage: $emptyPaneMessage)';
}


}

/// @nodoc
abstract mixin class _$AlertsCubitStateCopyWith<$Res> implements $AlertsCubitStateCopyWith<$Res> {
  factory _$AlertsCubitStateCopyWith(_AlertsCubitState value, $Res Function(_AlertsCubitState) _then) = __$AlertsCubitStateCopyWithImpl;
@override @useResult
$Res call({
 Map<String, Object> settings, FetchingStatus status, RefreshIconState refresh, List<Alert> alerts, List<Alert> filteredAlerts, List<AlertSourceData> sources, bool showNotificationStatusWidget, bool showVisibilityStatusWidget, bool showSoundStatusWidget, bool showFilterStatusWidget, String emptyPaneMessage
});


@override $RefreshIconStateCopyWith<$Res> get refresh;

}
/// @nodoc
class __$AlertsCubitStateCopyWithImpl<$Res>
    implements _$AlertsCubitStateCopyWith<$Res> {
  __$AlertsCubitStateCopyWithImpl(this._self, this._then);

  final _AlertsCubitState _self;
  final $Res Function(_AlertsCubitState) _then;

/// Create a copy of AlertsCubitState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? settings = null,Object? status = null,Object? refresh = null,Object? alerts = null,Object? filteredAlerts = null,Object? sources = null,Object? showNotificationStatusWidget = null,Object? showVisibilityStatusWidget = null,Object? showSoundStatusWidget = null,Object? showFilterStatusWidget = null,Object? emptyPaneMessage = null,}) {
  return _then(_AlertsCubitState(
settings: null == settings ? _self._settings : settings // ignore: cast_nullable_to_non_nullable
as Map<String, Object>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FetchingStatus,refresh: null == refresh ? _self.refresh : refresh // ignore: cast_nullable_to_non_nullable
as RefreshIconState,alerts: null == alerts ? _self._alerts : alerts // ignore: cast_nullable_to_non_nullable
as List<Alert>,filteredAlerts: null == filteredAlerts ? _self._filteredAlerts : filteredAlerts // ignore: cast_nullable_to_non_nullable
as List<Alert>,sources: null == sources ? _self._sources : sources // ignore: cast_nullable_to_non_nullable
as List<AlertSourceData>,showNotificationStatusWidget: null == showNotificationStatusWidget ? _self.showNotificationStatusWidget : showNotificationStatusWidget // ignore: cast_nullable_to_non_nullable
as bool,showVisibilityStatusWidget: null == showVisibilityStatusWidget ? _self.showVisibilityStatusWidget : showVisibilityStatusWidget // ignore: cast_nullable_to_non_nullable
as bool,showSoundStatusWidget: null == showSoundStatusWidget ? _self.showSoundStatusWidget : showSoundStatusWidget // ignore: cast_nullable_to_non_nullable
as bool,showFilterStatusWidget: null == showFilterStatusWidget ? _self.showFilterStatusWidget : showFilterStatusWidget // ignore: cast_nullable_to_non_nullable
as bool,emptyPaneMessage: null == emptyPaneMessage ? _self.emptyPaneMessage : emptyPaneMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of AlertsCubitState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RefreshIconStateCopyWith<$Res> get refresh {
  
  return $RefreshIconStateCopyWith<$Res>(_self.refresh, (value) {
    return _then(_self.copyWith(refresh: value));
  });
}
}

// dart format on
