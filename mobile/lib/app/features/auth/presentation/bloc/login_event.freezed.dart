// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginEvent()';
}


}

/// @nodoc
class $LoginEventCopyWith<$Res>  {
$LoginEventCopyWith(LoginEvent _, $Res Function(LoginEvent) __);
}


/// Adds pattern-matching-related methods to [LoginEvent].
extension LoginEventPatterns on LoginEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoginSubmitted value)?  loginSubmitted,TResult Function( TogglePasswordVisibility value)?  togglePasswordVisibility,TResult Function( LogoutRequested value)?  logoutRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoginSubmitted() when loginSubmitted != null:
return loginSubmitted(_that);case TogglePasswordVisibility() when togglePasswordVisibility != null:
return togglePasswordVisibility(_that);case LogoutRequested() when logoutRequested != null:
return logoutRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoginSubmitted value)  loginSubmitted,required TResult Function( TogglePasswordVisibility value)  togglePasswordVisibility,required TResult Function( LogoutRequested value)  logoutRequested,}){
final _that = this;
switch (_that) {
case LoginSubmitted():
return loginSubmitted(_that);case TogglePasswordVisibility():
return togglePasswordVisibility(_that);case LogoutRequested():
return logoutRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoginSubmitted value)?  loginSubmitted,TResult? Function( TogglePasswordVisibility value)?  togglePasswordVisibility,TResult? Function( LogoutRequested value)?  logoutRequested,}){
final _that = this;
switch (_that) {
case LoginSubmitted() when loginSubmitted != null:
return loginSubmitted(_that);case TogglePasswordVisibility() when togglePasswordVisibility != null:
return togglePasswordVisibility(_that);case LogoutRequested() when logoutRequested != null:
return logoutRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String identity,  String password)?  loginSubmitted,TResult Function()?  togglePasswordVisibility,TResult Function()?  logoutRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoginSubmitted() when loginSubmitted != null:
return loginSubmitted(_that.identity,_that.password);case TogglePasswordVisibility() when togglePasswordVisibility != null:
return togglePasswordVisibility();case LogoutRequested() when logoutRequested != null:
return logoutRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String identity,  String password)  loginSubmitted,required TResult Function()  togglePasswordVisibility,required TResult Function()  logoutRequested,}) {final _that = this;
switch (_that) {
case LoginSubmitted():
return loginSubmitted(_that.identity,_that.password);case TogglePasswordVisibility():
return togglePasswordVisibility();case LogoutRequested():
return logoutRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String identity,  String password)?  loginSubmitted,TResult? Function()?  togglePasswordVisibility,TResult? Function()?  logoutRequested,}) {final _that = this;
switch (_that) {
case LoginSubmitted() when loginSubmitted != null:
return loginSubmitted(_that.identity,_that.password);case TogglePasswordVisibility() when togglePasswordVisibility != null:
return togglePasswordVisibility();case LogoutRequested() when logoutRequested != null:
return logoutRequested();case _:
  return null;

}
}

}

/// @nodoc


class LoginSubmitted implements LoginEvent {
  const LoginSubmitted({required this.identity, required this.password});
  

 final  String identity;
 final  String password;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginSubmittedCopyWith<LoginSubmitted> get copyWith => _$LoginSubmittedCopyWithImpl<LoginSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginSubmitted&&(identical(other.identity, identity) || other.identity == identity)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,identity,password);

@override
String toString() {
  return 'LoginEvent.loginSubmitted(identity: $identity, password: $password)';
}


}

/// @nodoc
abstract mixin class $LoginSubmittedCopyWith<$Res> implements $LoginEventCopyWith<$Res> {
  factory $LoginSubmittedCopyWith(LoginSubmitted value, $Res Function(LoginSubmitted) _then) = _$LoginSubmittedCopyWithImpl;
@useResult
$Res call({
 String identity, String password
});




}
/// @nodoc
class _$LoginSubmittedCopyWithImpl<$Res>
    implements $LoginSubmittedCopyWith<$Res> {
  _$LoginSubmittedCopyWithImpl(this._self, this._then);

  final LoginSubmitted _self;
  final $Res Function(LoginSubmitted) _then;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? identity = null,Object? password = null,}) {
  return _then(LoginSubmitted(
identity: null == identity ? _self.identity : identity // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TogglePasswordVisibility implements LoginEvent {
  const TogglePasswordVisibility();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TogglePasswordVisibility);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginEvent.togglePasswordVisibility()';
}


}




/// @nodoc


class LogoutRequested implements LoginEvent {
  const LogoutRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogoutRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginEvent.logoutRequested()';
}


}




// dart format on
