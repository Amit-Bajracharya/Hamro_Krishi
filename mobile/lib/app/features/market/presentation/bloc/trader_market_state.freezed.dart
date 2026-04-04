// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trader_market_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TraderMarketState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TraderMarketState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TraderMarketState()';
}


}

/// @nodoc
class $TraderMarketStateCopyWith<$Res>  {
$TraderMarketStateCopyWith(TraderMarketState _, $Res Function(TraderMarketState) __);
}


/// Adds pattern-matching-related methods to [TraderMarketState].
extension TraderMarketStatePatterns on TraderMarketState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MarketInitial value)?  initial,TResult Function( MarketLoading value)?  loading,TResult Function( MarketLoaded value)?  loaded,TResult Function( MarketError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MarketInitial() when initial != null:
return initial(_that);case MarketLoading() when loading != null:
return loading(_that);case MarketLoaded() when loaded != null:
return loaded(_that);case MarketError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MarketInitial value)  initial,required TResult Function( MarketLoading value)  loading,required TResult Function( MarketLoaded value)  loaded,required TResult Function( MarketError value)  error,}){
final _that = this;
switch (_that) {
case MarketInitial():
return initial(_that);case MarketLoading():
return loading(_that);case MarketLoaded():
return loaded(_that);case MarketError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MarketInitial value)?  initial,TResult? Function( MarketLoading value)?  loading,TResult? Function( MarketLoaded value)?  loaded,TResult? Function( MarketError value)?  error,}){
final _that = this;
switch (_that) {
case MarketInitial() when initial != null:
return initial(_that);case MarketLoading() when loading != null:
return loading(_that);case MarketLoaded() when loaded != null:
return loaded(_that);case MarketError() when error != null:
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
case MarketInitial() when initial != null:
return initial();case MarketLoading() when loading != null:
return loading();case MarketLoaded() when loaded != null:
return loaded(_that.farmerCount,_that.products);case MarketError() when error != null:
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
case MarketInitial():
return initial();case MarketLoading():
return loading();case MarketLoaded():
return loaded(_that.farmerCount,_that.products);case MarketError():
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
case MarketInitial() when initial != null:
return initial();case MarketLoading() when loading != null:
return loading();case MarketLoaded() when loaded != null:
return loaded(_that.farmerCount,_that.products);case MarketError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class MarketInitial implements TraderMarketState {
  const MarketInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TraderMarketState.initial()';
}


}




/// @nodoc


class MarketLoading implements TraderMarketState {
  const MarketLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TraderMarketState.loading()';
}


}




/// @nodoc


class MarketLoaded implements TraderMarketState {
  const MarketLoaded({required this.farmerCount, required final  List<ProductEntity> products}): _products = products;
  

 final  int farmerCount;
 final  List<ProductEntity> _products;
 List<ProductEntity> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}


/// Create a copy of TraderMarketState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketLoadedCopyWith<MarketLoaded> get copyWith => _$MarketLoadedCopyWithImpl<MarketLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketLoaded&&(identical(other.farmerCount, farmerCount) || other.farmerCount == farmerCount)&&const DeepCollectionEquality().equals(other._products, _products));
}


@override
int get hashCode => Object.hash(runtimeType,farmerCount,const DeepCollectionEquality().hash(_products));

@override
String toString() {
  return 'TraderMarketState.loaded(farmerCount: $farmerCount, products: $products)';
}


}

/// @nodoc
abstract mixin class $MarketLoadedCopyWith<$Res> implements $TraderMarketStateCopyWith<$Res> {
  factory $MarketLoadedCopyWith(MarketLoaded value, $Res Function(MarketLoaded) _then) = _$MarketLoadedCopyWithImpl;
@useResult
$Res call({
 int farmerCount, List<ProductEntity> products
});




}
/// @nodoc
class _$MarketLoadedCopyWithImpl<$Res>
    implements $MarketLoadedCopyWith<$Res> {
  _$MarketLoadedCopyWithImpl(this._self, this._then);

  final MarketLoaded _self;
  final $Res Function(MarketLoaded) _then;

/// Create a copy of TraderMarketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? farmerCount = null,Object? products = null,}) {
  return _then(MarketLoaded(
farmerCount: null == farmerCount ? _self.farmerCount : farmerCount // ignore: cast_nullable_to_non_nullable
as int,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,
  ));
}


}

/// @nodoc


class MarketError implements TraderMarketState {
  const MarketError(this.message);
  

 final  String message;

/// Create a copy of TraderMarketState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketErrorCopyWith<MarketError> get copyWith => _$MarketErrorCopyWithImpl<MarketError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TraderMarketState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $MarketErrorCopyWith<$Res> implements $TraderMarketStateCopyWith<$Res> {
  factory $MarketErrorCopyWith(MarketError value, $Res Function(MarketError) _then) = _$MarketErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$MarketErrorCopyWithImpl<$Res>
    implements $MarketErrorCopyWith<$Res> {
  _$MarketErrorCopyWithImpl(this._self, this._then);

  final MarketError _self;
  final $Res Function(MarketError) _then;

/// Create a copy of TraderMarketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(MarketError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
