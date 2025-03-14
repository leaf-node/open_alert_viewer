// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alerts_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RefreshIconState {
  RefreshIconStatus get status => throw _privateConstructorUsedError;
  bool get alreadyFetching => throw _privateConstructorUsedError;
  bool get forceRefreshNow => throw _privateConstructorUsedError;

  /// Create a copy of RefreshIconState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RefreshIconStateCopyWith<RefreshIconState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefreshIconStateCopyWith<$Res> {
  factory $RefreshIconStateCopyWith(
    RefreshIconState value,
    $Res Function(RefreshIconState) then,
  ) = _$RefreshIconStateCopyWithImpl<$Res, RefreshIconState>;
  @useResult
  $Res call({
    RefreshIconStatus status,
    bool alreadyFetching,
    bool forceRefreshNow,
  });
}

/// @nodoc
class _$RefreshIconStateCopyWithImpl<$Res, $Val extends RefreshIconState>
    implements $RefreshIconStateCopyWith<$Res> {
  _$RefreshIconStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RefreshIconState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? alreadyFetching = null,
    Object? forceRefreshNow = null,
  }) {
    return _then(
      _value.copyWith(
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as RefreshIconStatus,
            alreadyFetching:
                null == alreadyFetching
                    ? _value.alreadyFetching
                    : alreadyFetching // ignore: cast_nullable_to_non_nullable
                        as bool,
            forceRefreshNow:
                null == forceRefreshNow
                    ? _value.forceRefreshNow
                    : forceRefreshNow // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RefreshIconStateImplCopyWith<$Res>
    implements $RefreshIconStateCopyWith<$Res> {
  factory _$$RefreshIconStateImplCopyWith(
    _$RefreshIconStateImpl value,
    $Res Function(_$RefreshIconStateImpl) then,
  ) = __$$RefreshIconStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    RefreshIconStatus status,
    bool alreadyFetching,
    bool forceRefreshNow,
  });
}

/// @nodoc
class __$$RefreshIconStateImplCopyWithImpl<$Res>
    extends _$RefreshIconStateCopyWithImpl<$Res, _$RefreshIconStateImpl>
    implements _$$RefreshIconStateImplCopyWith<$Res> {
  __$$RefreshIconStateImplCopyWithImpl(
    _$RefreshIconStateImpl _value,
    $Res Function(_$RefreshIconStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RefreshIconState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? alreadyFetching = null,
    Object? forceRefreshNow = null,
  }) {
    return _then(
      _$RefreshIconStateImpl(
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as RefreshIconStatus,
        alreadyFetching:
            null == alreadyFetching
                ? _value.alreadyFetching
                : alreadyFetching // ignore: cast_nullable_to_non_nullable
                    as bool,
        forceRefreshNow:
            null == forceRefreshNow
                ? _value.forceRefreshNow
                : forceRefreshNow // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$RefreshIconStateImpl implements _RefreshIconState {
  const _$RefreshIconStateImpl({
    required this.status,
    required this.alreadyFetching,
    required this.forceRefreshNow,
  });

  @override
  final RefreshIconStatus status;
  @override
  final bool alreadyFetching;
  @override
  final bool forceRefreshNow;

  @override
  String toString() {
    return 'RefreshIconState(status: $status, alreadyFetching: $alreadyFetching, forceRefreshNow: $forceRefreshNow)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshIconStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.alreadyFetching, alreadyFetching) ||
                other.alreadyFetching == alreadyFetching) &&
            (identical(other.forceRefreshNow, forceRefreshNow) ||
                other.forceRefreshNow == forceRefreshNow));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, alreadyFetching, forceRefreshNow);

  /// Create a copy of RefreshIconState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshIconStateImplCopyWith<_$RefreshIconStateImpl> get copyWith =>
      __$$RefreshIconStateImplCopyWithImpl<_$RefreshIconStateImpl>(
        this,
        _$identity,
      );
}

abstract class _RefreshIconState implements RefreshIconState {
  const factory _RefreshIconState({
    required final RefreshIconStatus status,
    required final bool alreadyFetching,
    required final bool forceRefreshNow,
  }) = _$RefreshIconStateImpl;

  @override
  RefreshIconStatus get status;
  @override
  bool get alreadyFetching;
  @override
  bool get forceRefreshNow;

  /// Create a copy of RefreshIconState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefreshIconStateImplCopyWith<_$RefreshIconStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AlertsCubitState {
  Map<String, Object> get settings => throw _privateConstructorUsedError;
  FetchingStatus get status => throw _privateConstructorUsedError;
  RefreshIconState get refresh => throw _privateConstructorUsedError;
  List<Alert> get alerts => throw _privateConstructorUsedError;
  List<Alert> get filteredAlerts => throw _privateConstructorUsedError;
  List<AlertSourceData> get sources => throw _privateConstructorUsedError;
  bool get showNotificationStatusWidget => throw _privateConstructorUsedError;
  bool get showVisibilityStatusWidget => throw _privateConstructorUsedError;
  bool get showSoundStatusWidget => throw _privateConstructorUsedError;
  bool get showFilterStatusWidget => throw _privateConstructorUsedError;
  String get emptyPaneMessage => throw _privateConstructorUsedError;

  /// Create a copy of AlertsCubitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlertsCubitStateCopyWith<AlertsCubitState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertsCubitStateCopyWith<$Res> {
  factory $AlertsCubitStateCopyWith(
    AlertsCubitState value,
    $Res Function(AlertsCubitState) then,
  ) = _$AlertsCubitStateCopyWithImpl<$Res, AlertsCubitState>;
  @useResult
  $Res call({
    Map<String, Object> settings,
    FetchingStatus status,
    RefreshIconState refresh,
    List<Alert> alerts,
    List<Alert> filteredAlerts,
    List<AlertSourceData> sources,
    bool showNotificationStatusWidget,
    bool showVisibilityStatusWidget,
    bool showSoundStatusWidget,
    bool showFilterStatusWidget,
    String emptyPaneMessage,
  });

  $RefreshIconStateCopyWith<$Res> get refresh;
}

/// @nodoc
class _$AlertsCubitStateCopyWithImpl<$Res, $Val extends AlertsCubitState>
    implements $AlertsCubitStateCopyWith<$Res> {
  _$AlertsCubitStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AlertsCubitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settings = null,
    Object? status = null,
    Object? refresh = null,
    Object? alerts = null,
    Object? filteredAlerts = null,
    Object? sources = null,
    Object? showNotificationStatusWidget = null,
    Object? showVisibilityStatusWidget = null,
    Object? showSoundStatusWidget = null,
    Object? showFilterStatusWidget = null,
    Object? emptyPaneMessage = null,
  }) {
    return _then(
      _value.copyWith(
            settings:
                null == settings
                    ? _value.settings
                    : settings // ignore: cast_nullable_to_non_nullable
                        as Map<String, Object>,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as FetchingStatus,
            refresh:
                null == refresh
                    ? _value.refresh
                    : refresh // ignore: cast_nullable_to_non_nullable
                        as RefreshIconState,
            alerts:
                null == alerts
                    ? _value.alerts
                    : alerts // ignore: cast_nullable_to_non_nullable
                        as List<Alert>,
            filteredAlerts:
                null == filteredAlerts
                    ? _value.filteredAlerts
                    : filteredAlerts // ignore: cast_nullable_to_non_nullable
                        as List<Alert>,
            sources:
                null == sources
                    ? _value.sources
                    : sources // ignore: cast_nullable_to_non_nullable
                        as List<AlertSourceData>,
            showNotificationStatusWidget:
                null == showNotificationStatusWidget
                    ? _value.showNotificationStatusWidget
                    : showNotificationStatusWidget // ignore: cast_nullable_to_non_nullable
                        as bool,
            showVisibilityStatusWidget:
                null == showVisibilityStatusWidget
                    ? _value.showVisibilityStatusWidget
                    : showVisibilityStatusWidget // ignore: cast_nullable_to_non_nullable
                        as bool,
            showSoundStatusWidget:
                null == showSoundStatusWidget
                    ? _value.showSoundStatusWidget
                    : showSoundStatusWidget // ignore: cast_nullable_to_non_nullable
                        as bool,
            showFilterStatusWidget:
                null == showFilterStatusWidget
                    ? _value.showFilterStatusWidget
                    : showFilterStatusWidget // ignore: cast_nullable_to_non_nullable
                        as bool,
            emptyPaneMessage:
                null == emptyPaneMessage
                    ? _value.emptyPaneMessage
                    : emptyPaneMessage // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }

  /// Create a copy of AlertsCubitState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RefreshIconStateCopyWith<$Res> get refresh {
    return $RefreshIconStateCopyWith<$Res>(_value.refresh, (value) {
      return _then(_value.copyWith(refresh: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AlertsCubitStateImplCopyWith<$Res>
    implements $AlertsCubitStateCopyWith<$Res> {
  factory _$$AlertsCubitStateImplCopyWith(
    _$AlertsCubitStateImpl value,
    $Res Function(_$AlertsCubitStateImpl) then,
  ) = __$$AlertsCubitStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Map<String, Object> settings,
    FetchingStatus status,
    RefreshIconState refresh,
    List<Alert> alerts,
    List<Alert> filteredAlerts,
    List<AlertSourceData> sources,
    bool showNotificationStatusWidget,
    bool showVisibilityStatusWidget,
    bool showSoundStatusWidget,
    bool showFilterStatusWidget,
    String emptyPaneMessage,
  });

  @override
  $RefreshIconStateCopyWith<$Res> get refresh;
}

/// @nodoc
class __$$AlertsCubitStateImplCopyWithImpl<$Res>
    extends _$AlertsCubitStateCopyWithImpl<$Res, _$AlertsCubitStateImpl>
    implements _$$AlertsCubitStateImplCopyWith<$Res> {
  __$$AlertsCubitStateImplCopyWithImpl(
    _$AlertsCubitStateImpl _value,
    $Res Function(_$AlertsCubitStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AlertsCubitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settings = null,
    Object? status = null,
    Object? refresh = null,
    Object? alerts = null,
    Object? filteredAlerts = null,
    Object? sources = null,
    Object? showNotificationStatusWidget = null,
    Object? showVisibilityStatusWidget = null,
    Object? showSoundStatusWidget = null,
    Object? showFilterStatusWidget = null,
    Object? emptyPaneMessage = null,
  }) {
    return _then(
      _$AlertsCubitStateImpl(
        settings:
            null == settings
                ? _value._settings
                : settings // ignore: cast_nullable_to_non_nullable
                    as Map<String, Object>,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as FetchingStatus,
        refresh:
            null == refresh
                ? _value.refresh
                : refresh // ignore: cast_nullable_to_non_nullable
                    as RefreshIconState,
        alerts:
            null == alerts
                ? _value._alerts
                : alerts // ignore: cast_nullable_to_non_nullable
                    as List<Alert>,
        filteredAlerts:
            null == filteredAlerts
                ? _value._filteredAlerts
                : filteredAlerts // ignore: cast_nullable_to_non_nullable
                    as List<Alert>,
        sources:
            null == sources
                ? _value._sources
                : sources // ignore: cast_nullable_to_non_nullable
                    as List<AlertSourceData>,
        showNotificationStatusWidget:
            null == showNotificationStatusWidget
                ? _value.showNotificationStatusWidget
                : showNotificationStatusWidget // ignore: cast_nullable_to_non_nullable
                    as bool,
        showVisibilityStatusWidget:
            null == showVisibilityStatusWidget
                ? _value.showVisibilityStatusWidget
                : showVisibilityStatusWidget // ignore: cast_nullable_to_non_nullable
                    as bool,
        showSoundStatusWidget:
            null == showSoundStatusWidget
                ? _value.showSoundStatusWidget
                : showSoundStatusWidget // ignore: cast_nullable_to_non_nullable
                    as bool,
        showFilterStatusWidget:
            null == showFilterStatusWidget
                ? _value.showFilterStatusWidget
                : showFilterStatusWidget // ignore: cast_nullable_to_non_nullable
                    as bool,
        emptyPaneMessage:
            null == emptyPaneMessage
                ? _value.emptyPaneMessage
                : emptyPaneMessage // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$AlertsCubitStateImpl implements _AlertsCubitState {
  const _$AlertsCubitStateImpl({
    required final Map<String, Object> settings,
    required this.status,
    required this.refresh,
    required final List<Alert> alerts,
    required final List<Alert> filteredAlerts,
    required final List<AlertSourceData> sources,
    required this.showNotificationStatusWidget,
    required this.showVisibilityStatusWidget,
    required this.showSoundStatusWidget,
    required this.showFilterStatusWidget,
    required this.emptyPaneMessage,
  }) : _settings = settings,
       _alerts = alerts,
       _filteredAlerts = filteredAlerts,
       _sources = sources;

  final Map<String, Object> _settings;
  @override
  Map<String, Object> get settings {
    if (_settings is EqualUnmodifiableMapView) return _settings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_settings);
  }

  @override
  final FetchingStatus status;
  @override
  final RefreshIconState refresh;
  final List<Alert> _alerts;
  @override
  List<Alert> get alerts {
    if (_alerts is EqualUnmodifiableListView) return _alerts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alerts);
  }

  final List<Alert> _filteredAlerts;
  @override
  List<Alert> get filteredAlerts {
    if (_filteredAlerts is EqualUnmodifiableListView) return _filteredAlerts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredAlerts);
  }

  final List<AlertSourceData> _sources;
  @override
  List<AlertSourceData> get sources {
    if (_sources is EqualUnmodifiableListView) return _sources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sources);
  }

  @override
  final bool showNotificationStatusWidget;
  @override
  final bool showVisibilityStatusWidget;
  @override
  final bool showSoundStatusWidget;
  @override
  final bool showFilterStatusWidget;
  @override
  final String emptyPaneMessage;

  @override
  String toString() {
    return 'AlertsCubitState(settings: $settings, status: $status, refresh: $refresh, alerts: $alerts, filteredAlerts: $filteredAlerts, sources: $sources, showNotificationStatusWidget: $showNotificationStatusWidget, showVisibilityStatusWidget: $showVisibilityStatusWidget, showSoundStatusWidget: $showSoundStatusWidget, showFilterStatusWidget: $showFilterStatusWidget, emptyPaneMessage: $emptyPaneMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertsCubitStateImpl &&
            const DeepCollectionEquality().equals(other._settings, _settings) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.refresh, refresh) || other.refresh == refresh) &&
            const DeepCollectionEquality().equals(other._alerts, _alerts) &&
            const DeepCollectionEquality().equals(
              other._filteredAlerts,
              _filteredAlerts,
            ) &&
            const DeepCollectionEquality().equals(other._sources, _sources) &&
            (identical(
                  other.showNotificationStatusWidget,
                  showNotificationStatusWidget,
                ) ||
                other.showNotificationStatusWidget ==
                    showNotificationStatusWidget) &&
            (identical(
                  other.showVisibilityStatusWidget,
                  showVisibilityStatusWidget,
                ) ||
                other.showVisibilityStatusWidget ==
                    showVisibilityStatusWidget) &&
            (identical(other.showSoundStatusWidget, showSoundStatusWidget) ||
                other.showSoundStatusWidget == showSoundStatusWidget) &&
            (identical(other.showFilterStatusWidget, showFilterStatusWidget) ||
                other.showFilterStatusWidget == showFilterStatusWidget) &&
            (identical(other.emptyPaneMessage, emptyPaneMessage) ||
                other.emptyPaneMessage == emptyPaneMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_settings),
    status,
    refresh,
    const DeepCollectionEquality().hash(_alerts),
    const DeepCollectionEquality().hash(_filteredAlerts),
    const DeepCollectionEquality().hash(_sources),
    showNotificationStatusWidget,
    showVisibilityStatusWidget,
    showSoundStatusWidget,
    showFilterStatusWidget,
    emptyPaneMessage,
  );

  /// Create a copy of AlertsCubitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertsCubitStateImplCopyWith<_$AlertsCubitStateImpl> get copyWith =>
      __$$AlertsCubitStateImplCopyWithImpl<_$AlertsCubitStateImpl>(
        this,
        _$identity,
      );
}

abstract class _AlertsCubitState implements AlertsCubitState {
  const factory _AlertsCubitState({
    required final Map<String, Object> settings,
    required final FetchingStatus status,
    required final RefreshIconState refresh,
    required final List<Alert> alerts,
    required final List<Alert> filteredAlerts,
    required final List<AlertSourceData> sources,
    required final bool showNotificationStatusWidget,
    required final bool showVisibilityStatusWidget,
    required final bool showSoundStatusWidget,
    required final bool showFilterStatusWidget,
    required final String emptyPaneMessage,
  }) = _$AlertsCubitStateImpl;

  @override
  Map<String, Object> get settings;
  @override
  FetchingStatus get status;
  @override
  RefreshIconState get refresh;
  @override
  List<Alert> get alerts;
  @override
  List<Alert> get filteredAlerts;
  @override
  List<AlertSourceData> get sources;
  @override
  bool get showNotificationStatusWidget;
  @override
  bool get showVisibilityStatusWidget;
  @override
  bool get showSoundStatusWidget;
  @override
  bool get showFilterStatusWidget;
  @override
  String get emptyPaneMessage;

  /// Create a copy of AlertsCubitState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlertsCubitStateImplCopyWith<_$AlertsCubitStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
