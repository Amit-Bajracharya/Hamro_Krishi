// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_trader_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegisterTraderState {

 bool get isPasswordHidden;
/// Create a copy of RegisterTraderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterTraderStateCopyWith<RegisterTraderState> get copyWith => _$RegisterTraderStateCopyWithImpl<RegisterTraderState>(this as RegisterTraderState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterTraderState&&(identical(other.isPasswordHidden, isPasswordHidden) || other.isPasswordHidden == isPasswordHidden));
}


@override
int get hashCode => Object.hash(runtimeType,isPasswordHidden);

@override
String toString() {
  return 'RegisterTraderState(isPasswordHidden: $isPasswordHidden)';
}


}

/// @nodoc
abstract mixin class $RegisterTraderStateCopyWith<$Res>  {
  factory $RegisterTraderStateCopyWith(RegisterTraderState value, $Res Function(RegisterTraderState) _then) = _$RegisterTraderStateCopyWithImpl;
@useResult
$Res call({
 bool isPasswordHidden
});




}
/// @nodoc
class _$RegisterTraderStateCopyWithImpl<$Res>
    implements $RegisterTraderStateCopyWith<$Res> {
  _$RegisterTraderStateCopyWithImpl(this._self, this._then);

  final RegisterTraderState _self;
  final $Res Function(RegisterTraderState) _then;

/// Create a copy of RegisterTraderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isPasswordHidden = null,}) {
  return _then(_self.copyWith(
isPasswordHidden: null == isPasswordHidden ? _self.isPasswordHidden : isPasswordHidden // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterTraderState].
extension RegisterTraderStatePatterns on RegisterTraderState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool isPasswordHidden)?  initial,TResult Function( bool isPasswordHidden)?  loading,TResult Function( bool isPasswordHidden)?  success,TResult Function( String error,  bool isPasswordHidden)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that.isPasswordHidden);case Loading() when loading != null:
return loading(_that.isPasswordHidden);case Success() when success != null:
return success(_that.isPasswordHidden);case Failure() when failure != null:
return failure(_that.error,_that.isPasswordHidden);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool isPasswordHidden)  initial,required TResult Function( bool isPasswordHidden)  loading,required TResult Function( bool isPasswordHidden)  success,required TResult Function( String error,  bool isPasswordHidden)  failure,}) {final _that = this;
switch (_that) {
case Initial():
return initial(_that.isPasswordHidden);case Loading():
return loading(_that.isPasswordHidden);case Success():
return success(_that.isPasswordHidden);case Failure():
return failure(_that.error,_that.isPasswordHidden);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool isPasswordHidden)?  initial,TResult? Function( bool isPasswordHidden)?  loading,TResult? Function( bool isPasswordHidden)?  success,TResult? Function( String error,  bool isPasswordHidden)?  failure,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that.isPasswordHidden);case Loading() when loading != null:
return loading(_that.isPasswordHidden);case Success() when success != null:
return success(_that.isPasswordHidden);case Failure() when failure != null:
return failure(_that.error,_that.isPasswordHidden);case _:
  return null;

}
}

}

/// @nodoc


class Initial implements RegisterTraderState {
  const Initial({this.isPasswordHidden = true});
  

@override@JsonKey() final  bool isPasswordHidden;

/// Create a copy of RegisterTraderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitialCopyWith<Initial> get copyWith => _$InitialCopyWithImpl<Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial&&(identical(other.isPasswordHidden, isPasswordHidden) || other.isPasswordHidden == isPasswordHidden));
}


@override
int get hashCode => Object.hash(runtimeType,isPasswordHidden);

@override
String toString() {
  return 'RegisterTraderState.initial(isPasswordHidden: $isPasswordHidden)';
}


}

/// @nodoc
abstract mixin class $InitialCopyWith<$Res> implements $RegisterTraderStateCopyWith<$Res> {
  factory $InitialCopyWith(Initial value, $Res Function(Initial) _then) = _$InitialCopyWithImpl;
@override @useResult
$Res call({
 bool isPasswordHidden
});




}
/// @nodoc
class _$InitialCopyWithImpl<$Res>
    implements $InitialCopyWith<$Res> {
  _$InitialCopyWithImpl(this._self, this._then);

  final Initial _self;
  final $Res Function(Initial) _then;

/// Create a copy of RegisterTraderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isPasswordHidden = null,}) {
  return _then(Initial(
isPasswordHidden: null == isPasswordHidden ? _self.isPasswordHidden : isPasswordHidden // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class Loading implements RegisterTraderState {
  const Loading({required this.isPasswordHidden});
  

@override final  bool isPasswordHidden;

/// Create a copy of RegisterTraderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadingCopyWith<Loading> get copyWith => _$LoadingCopyWithImpl<Loading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading&&(identical(other.isPasswordHidden, isPasswordHidden) || other.isPasswordHidden == isPasswordHidden));
}


@override
int get hashCode => Object.hash(runtimeType,isPasswordHidden);

@override
String toString() {
  return 'RegisterTraderState.loading(isPasswordHidden: $isPasswordHidden)';
}


}

/// @nodoc
abstract mixin class $LoadingCopyWith<$Res> implements $RegisterTraderStateCopyWith<$Res> {
  factory $LoadingCopyWith(Loading value, $Res Function(Loading) _then) = _$LoadingCopyWithImpl;
@override @useResult
$Res call({
 bool isPasswordHidden
});




}
/// @nodoc
class _$LoadingCopyWithImpl<$Res>
    implements $LoadingCopyWith<$Res> {
  _$LoadingCopyWithImpl(this._self, this._then);

  final Loading _self;
  final $Res Function(Loading) _then;

/// Create a copy of RegisterTraderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isPasswordHidden = null,}) {
  return _then(Loading(
isPasswordHidden: null == isPasswordHidden ? _self.isPasswordHidden : isPasswordHidden // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class Success implements RegisterTraderState {
  const Success({required this.isPasswordHidden});
  

@override final  bool isPasswordHidden;

/// Create a copy of RegisterTraderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessCopyWith<Success> get copyWith => _$SuccessCopyWithImpl<Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Success&&(identical(other.isPasswordHidden, isPasswordHidden) || other.isPasswordHidden == isPasswordHidden));
}


@override
int get hashCode => Object.hash(runtimeType,isPasswordHidden);

@override
String toString() {
  return 'RegisterTraderState.success(isPasswordHidden: $isPasswordHidden)';
}


}

/// @nodoc
abstract mixin class $SuccessCopyWith<$Res> implements $RegisterTraderStateCopyWith<$Res> {
  factory $SuccessCopyWith(Success value, $Res Function(Success) _then) = _$SuccessCopyWithImpl;
@override @useResult
$Res call({
 bool isPasswordHidden
});




}
/// @nodoc
class _$SuccessCopyWithImpl<$Res>
    implements $SuccessCopyWith<$Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success _self;
  final $Res Function(Success) _then;

/// Create a copy of RegisterTraderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isPasswordHidden = null,}) {
  return _then(Success(
isPasswordHidden: null == isPasswordHidden ? _self.isPasswordHidden : isPasswordHidden // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class Failure implements RegisterTraderState {
  const Failure({required this.error, required this.isPasswordHidden});
  

 final  String error;
@override final  bool isPasswordHidden;

/// Create a copy of RegisterTraderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCopyWith<Failure> get copyWith => _$FailureCopyWithImpl<Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure&&(identical(other.error, error) || other.error == error)&&(identical(other.isPasswordHidden, isPasswordHidden) || other.isPasswordHidden == isPasswordHidden));
}


@override
int get hashCode => Object.hash(runtimeType,error,isPasswordHidden);

@override
String toString() {
  return 'RegisterTraderState.failure(error: $error, isPasswordHidden: $isPasswordHidden)';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res> implements $RegisterTraderStateCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) = _$FailureCopyWithImpl;
@override @useResult
$Res call({
 String error, bool isPasswordHidden
});




}
/// @nodoc
class _$FailureCopyWithImpl<$Res>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

/// Create a copy of RegisterTraderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? error = null,Object? isPasswordHidden = null,}) {
  return _then(Failure(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,isPasswordHidden: null == isPasswordHidden ? _self.isPasswordHidden : isPasswordHidden // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
