// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_consumer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegisterConsumerState {

 bool get isPasswordHidden; double? get latitude; double? get longitude; bool get isLocationLoading;
/// Create a copy of RegisterConsumerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterConsumerStateCopyWith<RegisterConsumerState> get copyWith => _$RegisterConsumerStateCopyWithImpl<RegisterConsumerState>(this as RegisterConsumerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterConsumerState&&(identical(other.isPasswordHidden, isPasswordHidden) || other.isPasswordHidden == isPasswordHidden)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isLocationLoading, isLocationLoading) || other.isLocationLoading == isLocationLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isPasswordHidden,latitude,longitude,isLocationLoading);

@override
String toString() {
  return 'RegisterConsumerState(isPasswordHidden: $isPasswordHidden, latitude: $latitude, longitude: $longitude, isLocationLoading: $isLocationLoading)';
}


}

/// @nodoc
abstract mixin class $RegisterConsumerStateCopyWith<$Res>  {
  factory $RegisterConsumerStateCopyWith(RegisterConsumerState value, $Res Function(RegisterConsumerState) _then) = _$RegisterConsumerStateCopyWithImpl;
@useResult
$Res call({
 bool isPasswordHidden, double? latitude, double? longitude, bool isLocationLoading
});




}
/// @nodoc
class _$RegisterConsumerStateCopyWithImpl<$Res>
    implements $RegisterConsumerStateCopyWith<$Res> {
  _$RegisterConsumerStateCopyWithImpl(this._self, this._then);

  final RegisterConsumerState _self;
  final $Res Function(RegisterConsumerState) _then;

/// Create a copy of RegisterConsumerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isPasswordHidden = null,Object? latitude = freezed,Object? longitude = freezed,Object? isLocationLoading = null,}) {
  return _then(_self.copyWith(
isPasswordHidden: null == isPasswordHidden ? _self.isPasswordHidden : isPasswordHidden // ignore: cast_nullable_to_non_nullable
as bool,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isLocationLoading: null == isLocationLoading ? _self.isLocationLoading : isLocationLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterConsumerState].
extension RegisterConsumerStatePatterns on RegisterConsumerState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( Loading value)?  loading,TResult Function( Success value)?  success,TResult Function( Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Success() when success != null:
return success(_that);case Failure() when failure != null:
return failure(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( Loading value)  loading,required TResult Function( Success value)  success,required TResult Function( Failure value)  failure,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case Loading():
return loading(_that);case Success():
return success(_that);case Failure():
return failure(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( Loading value)?  loading,TResult? Function( Success value)?  success,TResult? Function( Failure value)?  failure,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Success() when success != null:
return success(_that);case Failure() when failure != null:
return failure(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool isPasswordHidden,  double? latitude,  double? longitude,  bool isLocationLoading)?  initial,TResult Function( bool isPasswordHidden,  double? latitude,  double? longitude,  bool isLocationLoading)?  loading,TResult Function( bool isPasswordHidden,  double? latitude,  double? longitude,  bool isLocationLoading)?  success,TResult Function( String error,  bool isPasswordHidden,  double? latitude,  double? longitude,  bool isLocationLoading)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that.isPasswordHidden,_that.latitude,_that.longitude,_that.isLocationLoading);case Loading() when loading != null:
return loading(_that.isPasswordHidden,_that.latitude,_that.longitude,_that.isLocationLoading);case Success() when success != null:
return success(_that.isPasswordHidden,_that.latitude,_that.longitude,_that.isLocationLoading);case Failure() when failure != null:
return failure(_that.error,_that.isPasswordHidden,_that.latitude,_that.longitude,_that.isLocationLoading);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool isPasswordHidden,  double? latitude,  double? longitude,  bool isLocationLoading)  initial,required TResult Function( bool isPasswordHidden,  double? latitude,  double? longitude,  bool isLocationLoading)  loading,required TResult Function( bool isPasswordHidden,  double? latitude,  double? longitude,  bool isLocationLoading)  success,required TResult Function( String error,  bool isPasswordHidden,  double? latitude,  double? longitude,  bool isLocationLoading)  failure,}) {final _that = this;
switch (_that) {
case Initial():
return initial(_that.isPasswordHidden,_that.latitude,_that.longitude,_that.isLocationLoading);case Loading():
return loading(_that.isPasswordHidden,_that.latitude,_that.longitude,_that.isLocationLoading);case Success():
return success(_that.isPasswordHidden,_that.latitude,_that.longitude,_that.isLocationLoading);case Failure():
return failure(_that.error,_that.isPasswordHidden,_that.latitude,_that.longitude,_that.isLocationLoading);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool isPasswordHidden,  double? latitude,  double? longitude,  bool isLocationLoading)?  initial,TResult? Function( bool isPasswordHidden,  double? latitude,  double? longitude,  bool isLocationLoading)?  loading,TResult? Function( bool isPasswordHidden,  double? latitude,  double? longitude,  bool isLocationLoading)?  success,TResult? Function( String error,  bool isPasswordHidden,  double? latitude,  double? longitude,  bool isLocationLoading)?  failure,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that.isPasswordHidden,_that.latitude,_that.longitude,_that.isLocationLoading);case Loading() when loading != null:
return loading(_that.isPasswordHidden,_that.latitude,_that.longitude,_that.isLocationLoading);case Success() when success != null:
return success(_that.isPasswordHidden,_that.latitude,_that.longitude,_that.isLocationLoading);case Failure() when failure != null:
return failure(_that.error,_that.isPasswordHidden,_that.latitude,_that.longitude,_that.isLocationLoading);case _:
  return null;

}
}

}

/// @nodoc


class Initial implements RegisterConsumerState {
  const Initial({this.isPasswordHidden = true, this.latitude, this.longitude, this.isLocationLoading = false});
  

@override@JsonKey() final  bool isPasswordHidden;
@override final  double? latitude;
@override final  double? longitude;
@override@JsonKey() final  bool isLocationLoading;

/// Create a copy of RegisterConsumerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitialCopyWith<Initial> get copyWith => _$InitialCopyWithImpl<Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial&&(identical(other.isPasswordHidden, isPasswordHidden) || other.isPasswordHidden == isPasswordHidden)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isLocationLoading, isLocationLoading) || other.isLocationLoading == isLocationLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isPasswordHidden,latitude,longitude,isLocationLoading);

@override
String toString() {
  return 'RegisterConsumerState.initial(isPasswordHidden: $isPasswordHidden, latitude: $latitude, longitude: $longitude, isLocationLoading: $isLocationLoading)';
}


}

/// @nodoc
abstract mixin class $InitialCopyWith<$Res> implements $RegisterConsumerStateCopyWith<$Res> {
  factory $InitialCopyWith(Initial value, $Res Function(Initial) _then) = _$InitialCopyWithImpl;
@override @useResult
$Res call({
 bool isPasswordHidden, double? latitude, double? longitude, bool isLocationLoading
});




}
/// @nodoc
class _$InitialCopyWithImpl<$Res>
    implements $InitialCopyWith<$Res> {
  _$InitialCopyWithImpl(this._self, this._then);

  final Initial _self;
  final $Res Function(Initial) _then;

/// Create a copy of RegisterConsumerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isPasswordHidden = null,Object? latitude = freezed,Object? longitude = freezed,Object? isLocationLoading = null,}) {
  return _then(Initial(
isPasswordHidden: null == isPasswordHidden ? _self.isPasswordHidden : isPasswordHidden // ignore: cast_nullable_to_non_nullable
as bool,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isLocationLoading: null == isLocationLoading ? _self.isLocationLoading : isLocationLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class Loading implements RegisterConsumerState {
  const Loading({required this.isPasswordHidden, this.latitude, this.longitude, this.isLocationLoading = false});
  

@override final  bool isPasswordHidden;
@override final  double? latitude;
@override final  double? longitude;
@override@JsonKey() final  bool isLocationLoading;

/// Create a copy of RegisterConsumerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadingCopyWith<Loading> get copyWith => _$LoadingCopyWithImpl<Loading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading&&(identical(other.isPasswordHidden, isPasswordHidden) || other.isPasswordHidden == isPasswordHidden)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isLocationLoading, isLocationLoading) || other.isLocationLoading == isLocationLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isPasswordHidden,latitude,longitude,isLocationLoading);

@override
String toString() {
  return 'RegisterConsumerState.loading(isPasswordHidden: $isPasswordHidden, latitude: $latitude, longitude: $longitude, isLocationLoading: $isLocationLoading)';
}


}

/// @nodoc
abstract mixin class $LoadingCopyWith<$Res> implements $RegisterConsumerStateCopyWith<$Res> {
  factory $LoadingCopyWith(Loading value, $Res Function(Loading) _then) = _$LoadingCopyWithImpl;
@override @useResult
$Res call({
 bool isPasswordHidden, double? latitude, double? longitude, bool isLocationLoading
});




}
/// @nodoc
class _$LoadingCopyWithImpl<$Res>
    implements $LoadingCopyWith<$Res> {
  _$LoadingCopyWithImpl(this._self, this._then);

  final Loading _self;
  final $Res Function(Loading) _then;

/// Create a copy of RegisterConsumerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isPasswordHidden = null,Object? latitude = freezed,Object? longitude = freezed,Object? isLocationLoading = null,}) {
  return _then(Loading(
isPasswordHidden: null == isPasswordHidden ? _self.isPasswordHidden : isPasswordHidden // ignore: cast_nullable_to_non_nullable
as bool,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isLocationLoading: null == isLocationLoading ? _self.isLocationLoading : isLocationLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class Success implements RegisterConsumerState {
  const Success({required this.isPasswordHidden, this.latitude, this.longitude, this.isLocationLoading = false});
  

@override final  bool isPasswordHidden;
@override final  double? latitude;
@override final  double? longitude;
@override@JsonKey() final  bool isLocationLoading;

/// Create a copy of RegisterConsumerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessCopyWith<Success> get copyWith => _$SuccessCopyWithImpl<Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Success&&(identical(other.isPasswordHidden, isPasswordHidden) || other.isPasswordHidden == isPasswordHidden)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isLocationLoading, isLocationLoading) || other.isLocationLoading == isLocationLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isPasswordHidden,latitude,longitude,isLocationLoading);

@override
String toString() {
  return 'RegisterConsumerState.success(isPasswordHidden: $isPasswordHidden, latitude: $latitude, longitude: $longitude, isLocationLoading: $isLocationLoading)';
}


}

/// @nodoc
abstract mixin class $SuccessCopyWith<$Res> implements $RegisterConsumerStateCopyWith<$Res> {
  factory $SuccessCopyWith(Success value, $Res Function(Success) _then) = _$SuccessCopyWithImpl;
@override @useResult
$Res call({
 bool isPasswordHidden, double? latitude, double? longitude, bool isLocationLoading
});




}
/// @nodoc
class _$SuccessCopyWithImpl<$Res>
    implements $SuccessCopyWith<$Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success _self;
  final $Res Function(Success) _then;

/// Create a copy of RegisterConsumerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isPasswordHidden = null,Object? latitude = freezed,Object? longitude = freezed,Object? isLocationLoading = null,}) {
  return _then(Success(
isPasswordHidden: null == isPasswordHidden ? _self.isPasswordHidden : isPasswordHidden // ignore: cast_nullable_to_non_nullable
as bool,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isLocationLoading: null == isLocationLoading ? _self.isLocationLoading : isLocationLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class Failure implements RegisterConsumerState {
  const Failure({required this.error, required this.isPasswordHidden, this.latitude, this.longitude, this.isLocationLoading = false});
  

 final  String error;
@override final  bool isPasswordHidden;
@override final  double? latitude;
@override final  double? longitude;
@override@JsonKey() final  bool isLocationLoading;

/// Create a copy of RegisterConsumerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCopyWith<Failure> get copyWith => _$FailureCopyWithImpl<Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure&&(identical(other.error, error) || other.error == error)&&(identical(other.isPasswordHidden, isPasswordHidden) || other.isPasswordHidden == isPasswordHidden)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isLocationLoading, isLocationLoading) || other.isLocationLoading == isLocationLoading));
}


@override
int get hashCode => Object.hash(runtimeType,error,isPasswordHidden,latitude,longitude,isLocationLoading);

@override
String toString() {
  return 'RegisterConsumerState.failure(error: $error, isPasswordHidden: $isPasswordHidden, latitude: $latitude, longitude: $longitude, isLocationLoading: $isLocationLoading)';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res> implements $RegisterConsumerStateCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) = _$FailureCopyWithImpl;
@override @useResult
$Res call({
 String error, bool isPasswordHidden, double? latitude, double? longitude, bool isLocationLoading
});




}
/// @nodoc
class _$FailureCopyWithImpl<$Res>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

/// Create a copy of RegisterConsumerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? error = null,Object? isPasswordHidden = null,Object? latitude = freezed,Object? longitude = freezed,Object? isLocationLoading = null,}) {
  return _then(Failure(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,isPasswordHidden: null == isPasswordHidden ? _self.isPasswordHidden : isPasswordHidden // ignore: cast_nullable_to_non_nullable
as bool,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isLocationLoading: null == isLocationLoading ? _self.isLocationLoading : isLocationLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
