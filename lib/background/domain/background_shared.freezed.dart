// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'background_shared.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IsolateMessage _$IsolateMessageFromJson(Map<String, dynamic> json) {
  return _IsolateMessage.fromJson(json);
}

/// @nodoc
mixin _$IsolateMessage {
  MessageName get name => throw _privateConstructorUsedError;
  MessageDestination? get destination => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  List<Alert>? get alerts => throw _privateConstructorUsedError;
  AlertSourceDataUpdate? get sourceData => throw _privateConstructorUsedError;
  bool? get forceRefreshNow => throw _privateConstructorUsedError;
  bool? get alreadyFetching => throw _privateConstructorUsedError;

  /// Serializes this IsolateMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IsolateMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IsolateMessageCopyWith<IsolateMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IsolateMessageCopyWith<$Res> {
  factory $IsolateMessageCopyWith(
          IsolateMessage value, $Res Function(IsolateMessage) then) =
      _$IsolateMessageCopyWithImpl<$Res, IsolateMessage>;
  @useResult
  $Res call(
      {MessageName name,
      MessageDestination? destination,
      int? id,
      List<Alert>? alerts,
      AlertSourceDataUpdate? sourceData,
      bool? forceRefreshNow,
      bool? alreadyFetching});

  $AlertSourceDataUpdateCopyWith<$Res>? get sourceData;
}

/// @nodoc
class _$IsolateMessageCopyWithImpl<$Res, $Val extends IsolateMessage>
    implements $IsolateMessageCopyWith<$Res> {
  _$IsolateMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IsolateMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? destination = freezed,
    Object? id = freezed,
    Object? alerts = freezed,
    Object? sourceData = freezed,
    Object? forceRefreshNow = freezed,
    Object? alreadyFetching = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as MessageName,
      destination: freezed == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as MessageDestination?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      alerts: freezed == alerts
          ? _value.alerts
          : alerts // ignore: cast_nullable_to_non_nullable
              as List<Alert>?,
      sourceData: freezed == sourceData
          ? _value.sourceData
          : sourceData // ignore: cast_nullable_to_non_nullable
              as AlertSourceDataUpdate?,
      forceRefreshNow: freezed == forceRefreshNow
          ? _value.forceRefreshNow
          : forceRefreshNow // ignore: cast_nullable_to_non_nullable
              as bool?,
      alreadyFetching: freezed == alreadyFetching
          ? _value.alreadyFetching
          : alreadyFetching // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  /// Create a copy of IsolateMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AlertSourceDataUpdateCopyWith<$Res>? get sourceData {
    if (_value.sourceData == null) {
      return null;
    }

    return $AlertSourceDataUpdateCopyWith<$Res>(_value.sourceData!, (value) {
      return _then(_value.copyWith(sourceData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IsolateMessageImplCopyWith<$Res>
    implements $IsolateMessageCopyWith<$Res> {
  factory _$$IsolateMessageImplCopyWith(_$IsolateMessageImpl value,
          $Res Function(_$IsolateMessageImpl) then) =
      __$$IsolateMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MessageName name,
      MessageDestination? destination,
      int? id,
      List<Alert>? alerts,
      AlertSourceDataUpdate? sourceData,
      bool? forceRefreshNow,
      bool? alreadyFetching});

  @override
  $AlertSourceDataUpdateCopyWith<$Res>? get sourceData;
}

/// @nodoc
class __$$IsolateMessageImplCopyWithImpl<$Res>
    extends _$IsolateMessageCopyWithImpl<$Res, _$IsolateMessageImpl>
    implements _$$IsolateMessageImplCopyWith<$Res> {
  __$$IsolateMessageImplCopyWithImpl(
      _$IsolateMessageImpl _value, $Res Function(_$IsolateMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of IsolateMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? destination = freezed,
    Object? id = freezed,
    Object? alerts = freezed,
    Object? sourceData = freezed,
    Object? forceRefreshNow = freezed,
    Object? alreadyFetching = freezed,
  }) {
    return _then(_$IsolateMessageImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as MessageName,
      destination: freezed == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as MessageDestination?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      alerts: freezed == alerts
          ? _value._alerts
          : alerts // ignore: cast_nullable_to_non_nullable
              as List<Alert>?,
      sourceData: freezed == sourceData
          ? _value.sourceData
          : sourceData // ignore: cast_nullable_to_non_nullable
              as AlertSourceDataUpdate?,
      forceRefreshNow: freezed == forceRefreshNow
          ? _value.forceRefreshNow
          : forceRefreshNow // ignore: cast_nullable_to_non_nullable
              as bool?,
      alreadyFetching: freezed == alreadyFetching
          ? _value.alreadyFetching
          : alreadyFetching // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IsolateMessageImpl implements _IsolateMessage {
  const _$IsolateMessageImpl(
      {required this.name,
      this.destination,
      this.id,
      final List<Alert>? alerts,
      this.sourceData,
      this.forceRefreshNow,
      this.alreadyFetching})
      : _alerts = alerts;

  factory _$IsolateMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$IsolateMessageImplFromJson(json);

  @override
  final MessageName name;
  @override
  final MessageDestination? destination;
  @override
  final int? id;
  final List<Alert>? _alerts;
  @override
  List<Alert>? get alerts {
    final value = _alerts;
    if (value == null) return null;
    if (_alerts is EqualUnmodifiableListView) return _alerts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final AlertSourceDataUpdate? sourceData;
  @override
  final bool? forceRefreshNow;
  @override
  final bool? alreadyFetching;

  @override
  String toString() {
    return 'IsolateMessage(name: $name, destination: $destination, id: $id, alerts: $alerts, sourceData: $sourceData, forceRefreshNow: $forceRefreshNow, alreadyFetching: $alreadyFetching)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IsolateMessageImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._alerts, _alerts) &&
            (identical(other.sourceData, sourceData) ||
                other.sourceData == sourceData) &&
            (identical(other.forceRefreshNow, forceRefreshNow) ||
                other.forceRefreshNow == forceRefreshNow) &&
            (identical(other.alreadyFetching, alreadyFetching) ||
                other.alreadyFetching == alreadyFetching));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      destination,
      id,
      const DeepCollectionEquality().hash(_alerts),
      sourceData,
      forceRefreshNow,
      alreadyFetching);

  /// Create a copy of IsolateMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IsolateMessageImplCopyWith<_$IsolateMessageImpl> get copyWith =>
      __$$IsolateMessageImplCopyWithImpl<_$IsolateMessageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IsolateMessageImplToJson(
      this,
    );
  }
}

abstract class _IsolateMessage implements IsolateMessage {
  const factory _IsolateMessage(
      {required final MessageName name,
      final MessageDestination? destination,
      final int? id,
      final List<Alert>? alerts,
      final AlertSourceDataUpdate? sourceData,
      final bool? forceRefreshNow,
      final bool? alreadyFetching}) = _$IsolateMessageImpl;

  factory _IsolateMessage.fromJson(Map<String, dynamic> json) =
      _$IsolateMessageImpl.fromJson;

  @override
  MessageName get name;
  @override
  MessageDestination? get destination;
  @override
  int? get id;
  @override
  List<Alert>? get alerts;
  @override
  AlertSourceDataUpdate? get sourceData;
  @override
  bool? get forceRefreshNow;
  @override
  bool? get alreadyFetching;

  /// Create a copy of IsolateMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IsolateMessageImplCopyWith<_$IsolateMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
