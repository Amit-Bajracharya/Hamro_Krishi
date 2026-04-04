// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trader_dashboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TraderDashboardState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TraderDashboardState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TraderDashboardState()';
}


}

/// @nodoc
class $TraderDashboardStateCopyWith<$Res>  {
$TraderDashboardStateCopyWith(TraderDashboardState _, $Res Function(TraderDashboardState) __);
}


/// Adds pattern-matching-related methods to [TraderDashboardState].
extension TraderDashboardStatePatterns on TraderDashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TraderDashboardInitial value)?  initial,TResult Function( TraderDashboardLoading value)?  loading,TResult Function( TraderDashboardLoaded value)?  loaded,TResult Function( TraderDashboardError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TraderDashboardInitial() when initial != null:
return initial(_that);case TraderDashboardLoading() when loading != null:
return loading(_that);case TraderDashboardLoaded() when loaded != null:
return loaded(_that);case TraderDashboardError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TraderDashboardInitial value)  initial,required TResult Function( TraderDashboardLoading value)  loading,required TResult Function( TraderDashboardLoaded value)  loaded,required TResult Function( TraderDashboardError value)  error,}){
final _that = this;
switch (_that) {
case TraderDashboardInitial():
return initial(_that);case TraderDashboardLoading():
return loading(_that);case TraderDashboardLoaded():
return loaded(_that);case TraderDashboardError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TraderDashboardInitial value)?  initial,TResult? Function( TraderDashboardLoading value)?  loading,TResult? Function( TraderDashboardLoaded value)?  loaded,TResult? Function( TraderDashboardError value)?  error,}){
final _that = this;
switch (_that) {
case TraderDashboardInitial() when initial != null:
return initial(_that);case TraderDashboardLoading() when loading != null:
return loading(_that);case TraderDashboardLoaded() when loaded != null:
return loaded(_that);case TraderDashboardError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( int farmerCount,  List<ProductEntity> products)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TraderDashboardInitial() when initial != null:
return initial();case TraderDashboardLoading() when loading != null:
return loading();case TraderDashboardLoaded() when loaded != null:
return loaded(_that.farmerCount,_that.products);case TraderDashboardError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( int farmerCount,  List<ProductEntity> products)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case TraderDashboardInitial():
return initial();case TraderDashboardLoading():
return loading();case TraderDashboardLoaded():
return loaded(_that.farmerCount,_that.products);case TraderDashboardError():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( int farmerCount,  List<ProductEntity> products)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case TraderDashboardInitial() when initial != null:
return initial();case TraderDashboardLoading() when loading != null:
return loading();case TraderDashboardLoaded() when loaded != null:
return loaded(_that.farmerCount,_that.products);case TraderDashboardError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class TraderDashboardInitial implements TraderDashboardState {
  const TraderDashboardInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TraderDashboardInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TraderDashboardState.initial()';
}


}




/// @nodoc


class TraderDashboardLoading implements TraderDashboardState {
  const TraderDashboardLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TraderDashboardLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TraderDashboardState.loading()';
}


}




/// @nodoc


class TraderDashboardLoaded implements TraderDashboardState {
  const TraderDashboardLoaded({required this.farmerCount, required final  List<ProductEntity> products}): _products = products;
  

 final  int farmerCount;
 final  List<ProductEntity> _products;
 List<ProductEntity> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}


/// Create a copy of TraderDashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TraderDashboardLoadedCopyWith<TraderDashboardLoaded> get copyWith => _$TraderDashboardLoadedCopyWithImpl<TraderDashboardLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TraderDashboardLoaded&&(identical(other.farmerCount, farmerCount) || other.farmerCount == farmerCount)&&const DeepCollectionEquality().equals(other._products, _products));
}


@override
int get hashCode => Object.hash(runtimeType,farmerCount,const DeepCollectionEquality().hash(_products));

@override
String toString() {
  return 'TraderDashboardState.loaded(farmerCount: $farmerCount, products: $products)';
}


}

/// @nodoc
abstract mixin class $TraderDashboardLoadedCopyWith<$Res> implements $TraderDashboardStateCopyWith<$Res> {
  factory $TraderDashboardLoadedCopyWith(TraderDashboardLoaded value, $Res Function(TraderDashboardLoaded) _then) = _$TraderDashboardLoadedCopyWithImpl;
@useResult
$Res call({
 int farmerCount, List<ProductEntity> products
});




}
/// @nodoc
class _$TraderDashboardLoadedCopyWithImpl<$Res>
    implements $TraderDashboardLoadedCopyWith<$Res> {
  _$TraderDashboardLoadedCopyWithImpl(this._self, this._then);

  final TraderDashboardLoaded _self;
  final $Res Function(TraderDashboardLoaded) _then;

/// Create a copy of TraderDashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? farmerCount = null,Object? products = null,}) {
  return _then(TraderDashboardLoaded(
farmerCount: null == farmerCount ? _self.farmerCount : farmerCount // ignore: cast_nullable_to_non_nullable
as int,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,
  ));
}


}

/// @nodoc


class TraderDashboardError implements TraderDashboardState {
  const TraderDashboardError(this.message);
  

 final  String message;

/// Create a copy of TraderDashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TraderDashboardErrorCopyWith<TraderDashboardError> get copyWith => _$TraderDashboardErrorCopyWithImpl<TraderDashboardError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TraderDashboardError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TraderDashboardState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $TraderDashboardErrorCopyWith<$Res> implements $TraderDashboardStateCopyWith<$Res> {
  factory $TraderDashboardErrorCopyWith(TraderDashboardError value, $Res Function(TraderDashboardError) _then) = _$TraderDashboardErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$TraderDashboardErrorCopyWithImpl<$Res>
    implements $TraderDashboardErrorCopyWith<$Res> {
  _$TraderDashboardErrorCopyWithImpl(this._self, this._then);

  final TraderDashboardError _self;
  final $Res Function(TraderDashboardError) _then;

/// Create a copy of TraderDashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(TraderDashboardError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
