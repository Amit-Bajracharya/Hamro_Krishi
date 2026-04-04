// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_trader_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegisterTraderEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterTraderEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterTraderEvent()';
}


}

/// @nodoc
class $RegisterTraderEventCopyWith<$Res>  {
$RegisterTraderEventCopyWith(RegisterTraderEvent _, $Res Function(RegisterTraderEvent) __);
}


/// Adds pattern-matching-related methods to [RegisterTraderEvent].
extension RegisterTraderEventPatterns on RegisterTraderEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RegisterSubmitted value)?  registerSubmitted,TResult Function( TogglePasswordVisibility value)?  togglePasswordVisibility,TResult Function( FetchLocation value)?  fetchLocation,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RegisterSubmitted() when registerSubmitted != null:
return registerSubmitted(_that);case TogglePasswordVisibility() when togglePasswordVisibility != null:
return togglePasswordVisibility(_that);case FetchLocation() when fetchLocation != null:
return fetchLocation(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RegisterSubmitted value)  registerSubmitted,required TResult Function( TogglePasswordVisibility value)  togglePasswordVisibility,required TResult Function( FetchLocation value)  fetchLocation,}){
final _that = this;
switch (_that) {
case RegisterSubmitted():
return registerSubmitted(_that);case TogglePasswordVisibility():
return togglePasswordVisibility(_that);case FetchLocation():
return fetchLocation(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RegisterSubmitted value)?  registerSubmitted,TResult? Function( TogglePasswordVisibility value)?  togglePasswordVisibility,TResult? Function( FetchLocation value)?  fetchLocation,}){
final _that = this;
switch (_that) {
case RegisterSubmitted() when registerSubmitted != null:
return registerSubmitted(_that);case TogglePasswordVisibility() when togglePasswordVisibility != null:
return togglePasswordVisibility(_that);case FetchLocation() when fetchLocation != null:
return fetchLocation(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String name,  String email,  String password,  String phone,  double latitude,  double longitude,  String businessName,  String operatingRegions)?  registerSubmitted,TResult Function()?  togglePasswordVisibility,TResult Function()?  fetchLocation,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RegisterSubmitted() when registerSubmitted != null:
return registerSubmitted(_that.name,_that.email,_that.password,_that.phone,_that.latitude,_that.longitude,_that.businessName,_that.operatingRegions);case TogglePasswordVisibility() when togglePasswordVisibility != null:
return togglePasswordVisibility();case FetchLocation() when fetchLocation != null:
return fetchLocation();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String name,  String email,  String password,  String phone,  double latitude,  double longitude,  String businessName,  String operatingRegions)  registerSubmitted,required TResult Function()  togglePasswordVisibility,required TResult Function()  fetchLocation,}) {final _that = this;
switch (_that) {
case RegisterSubmitted():
return registerSubmitted(_that.name,_that.email,_that.password,_that.phone,_that.latitude,_that.longitude,_that.businessName,_that.operatingRegions);case TogglePasswordVisibility():
return togglePasswordVisibility();case FetchLocation():
return fetchLocation();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String name,  String email,  String password,  String phone,  double latitude,  double longitude,  String businessName,  String operatingRegions)?  registerSubmitted,TResult? Function()?  togglePasswordVisibility,TResult? Function()?  fetchLocation,}) {final _that = this;
switch (_that) {
case RegisterSubmitted() when registerSubmitted != null:
return registerSubmitted(_that.name,_that.email,_that.password,_that.phone,_that.latitude,_that.longitude,_that.businessName,_that.operatingRegions);case TogglePasswordVisibility() when togglePasswordVisibility != null:
return togglePasswordVisibility();case FetchLocation() when fetchLocation != null:
return fetchLocation();case _:
  return null;

}
}

}

/// @nodoc


class RegisterSubmitted implements RegisterTraderEvent {
  const RegisterSubmitted({required this.name, required this.email, required this.password, required this.phone, required this.latitude, required this.longitude, required this.businessName, required this.operatingRegions});
  

 final  String name;
 final  String email;
 final  String password;
 final  String phone;
 final  double latitude;
 final  double longitude;
 final  String businessName;
 final  String operatingRegions;

/// Create a copy of RegisterTraderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterSubmittedCopyWith<RegisterSubmitted> get copyWith => _$RegisterSubmittedCopyWithImpl<RegisterSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterSubmitted&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.operatingRegions, operatingRegions) || other.operatingRegions == operatingRegions));
}


@override
int get hashCode => Object.hash(runtimeType,name,email,password,phone,latitude,longitude,businessName,operatingRegions);

@override
String toString() {
  return 'RegisterTraderEvent.registerSubmitted(name: $name, email: $email, password: $password, phone: $phone, latitude: $latitude, longitude: $longitude, businessName: $businessName, operatingRegions: $operatingRegions)';
}


}

/// @nodoc
abstract mixin class $RegisterSubmittedCopyWith<$Res> implements $RegisterTraderEventCopyWith<$Res> {
  factory $RegisterSubmittedCopyWith(RegisterSubmitted value, $Res Function(RegisterSubmitted) _then) = _$RegisterSubmittedCopyWithImpl;
@useResult
$Res call({
 String name, String email, String password, String phone, double latitude, double longitude, String businessName, String operatingRegions
});




}
/// @nodoc
class _$RegisterSubmittedCopyWithImpl<$Res>
    implements $RegisterSubmittedCopyWith<$Res> {
  _$RegisterSubmittedCopyWithImpl(this._self, this._then);

  final RegisterSubmitted _self;
  final $Res Function(RegisterSubmitted) _then;

/// Create a copy of RegisterTraderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,Object? password = null,Object? phone = null,Object? latitude = null,Object? longitude = null,Object? businessName = null,Object? operatingRegions = null,}) {
  return _then(RegisterSubmitted(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,operatingRegions: null == operatingRegions ? _self.operatingRegions : operatingRegions // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TogglePasswordVisibility implements RegisterTraderEvent {
  const TogglePasswordVisibility();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TogglePasswordVisibility);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterTraderEvent.togglePasswordVisibility()';
}


}




/// @nodoc


class FetchLocation implements RegisterTraderEvent {
  const FetchLocation();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchLocation);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterTraderEvent.fetchLocation()';
}


}




// dart format on
