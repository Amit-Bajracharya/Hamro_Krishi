// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consumer_market_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConsumerMarketEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsumerMarketEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConsumerMarketEvent()';
}


}

/// @nodoc
class $ConsumerMarketEventCopyWith<$Res>  {
$ConsumerMarketEventCopyWith(ConsumerMarketEvent _, $Res Function(ConsumerMarketEvent) __);
}


/// Adds pattern-matching-related methods to [ConsumerMarketEvent].
extension ConsumerMarketEventPatterns on ConsumerMarketEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchMarketplace value)?  fetchMarketplace,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchMarketplace() when fetchMarketplace != null:
return fetchMarketplace(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchMarketplace value)  fetchMarketplace,}){
final _that = this;
switch (_that) {
case FetchMarketplace():
return fetchMarketplace(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchMarketplace value)?  fetchMarketplace,}){
final _that = this;
switch (_that) {
case FetchMarketplace() when fetchMarketplace != null:
return fetchMarketplace(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchMarketplace,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchMarketplace() when fetchMarketplace != null:
return fetchMarketplace();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchMarketplace,}) {final _that = this;
switch (_that) {
case FetchMarketplace():
return fetchMarketplace();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchMarketplace,}) {final _that = this;
switch (_that) {
case FetchMarketplace() when fetchMarketplace != null:
return fetchMarketplace();case _:
  return null;

}
}

}

/// @nodoc


class FetchMarketplace implements ConsumerMarketEvent {
  const FetchMarketplace();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMarketplace);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConsumerMarketEvent.fetchMarketplace()';
}


}




/// @nodoc
mixin _$ConsumerMarketState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsumerMarketState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConsumerMarketState()';
}


}

/// @nodoc
class $ConsumerMarketStateCopyWith<$Res>  {
$ConsumerMarketStateCopyWith(ConsumerMarketState _, $Res Function(ConsumerMarketState) __);
}


/// Adds pattern-matching-related methods to [ConsumerMarketState].
extension ConsumerMarketStatePatterns on ConsumerMarketState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ConsumerMarketInitial value)?  initial,TResult Function( ConsumerMarketLoading value)?  loading,TResult Function( ConsumerMarketLoaded value)?  loaded,TResult Function( ConsumerMarketError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ConsumerMarketInitial() when initial != null:
return initial(_that);case ConsumerMarketLoading() when loading != null:
return loading(_that);case ConsumerMarketLoaded() when loaded != null:
return loaded(_that);case ConsumerMarketError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ConsumerMarketInitial value)  initial,required TResult Function( ConsumerMarketLoading value)  loading,required TResult Function( ConsumerMarketLoaded value)  loaded,required TResult Function( ConsumerMarketError value)  error,}){
final _that = this;
switch (_that) {
case ConsumerMarketInitial():
return initial(_that);case ConsumerMarketLoading():
return loading(_that);case ConsumerMarketLoaded():
return loaded(_that);case ConsumerMarketError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ConsumerMarketInitial value)?  initial,TResult? Function( ConsumerMarketLoading value)?  loading,TResult? Function( ConsumerMarketLoaded value)?  loaded,TResult? Function( ConsumerMarketError value)?  error,}){
final _that = this;
switch (_that) {
case ConsumerMarketInitial() when initial != null:
return initial(_that);case ConsumerMarketLoading() when loading != null:
return loading(_that);case ConsumerMarketLoaded() when loaded != null:
return loaded(_that);case ConsumerMarketError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<MarketItemEntity> marketItems,  List<ProductEntity> farmerProducts)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ConsumerMarketInitial() when initial != null:
return initial();case ConsumerMarketLoading() when loading != null:
return loading();case ConsumerMarketLoaded() when loaded != null:
return loaded(_that.marketItems,_that.farmerProducts);case ConsumerMarketError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<MarketItemEntity> marketItems,  List<ProductEntity> farmerProducts)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ConsumerMarketInitial():
return initial();case ConsumerMarketLoading():
return loading();case ConsumerMarketLoaded():
return loaded(_that.marketItems,_that.farmerProducts);case ConsumerMarketError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<MarketItemEntity> marketItems,  List<ProductEntity> farmerProducts)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ConsumerMarketInitial() when initial != null:
return initial();case ConsumerMarketLoading() when loading != null:
return loading();case ConsumerMarketLoaded() when loaded != null:
return loaded(_that.marketItems,_that.farmerProducts);case ConsumerMarketError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ConsumerMarketInitial implements ConsumerMarketState {
  const ConsumerMarketInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsumerMarketInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConsumerMarketState.initial()';
}


}




/// @nodoc


class ConsumerMarketLoading implements ConsumerMarketState {
  const ConsumerMarketLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsumerMarketLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConsumerMarketState.loading()';
}


}




/// @nodoc


class ConsumerMarketLoaded implements ConsumerMarketState {
  const ConsumerMarketLoaded({required final  List<MarketItemEntity> marketItems, required final  List<ProductEntity> farmerProducts}): _marketItems = marketItems,_farmerProducts = farmerProducts;
  

 final  List<MarketItemEntity> _marketItems;
 List<MarketItemEntity> get marketItems {
  if (_marketItems is EqualUnmodifiableListView) return _marketItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_marketItems);
}

 final  List<ProductEntity> _farmerProducts;
 List<ProductEntity> get farmerProducts {
  if (_farmerProducts is EqualUnmodifiableListView) return _farmerProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_farmerProducts);
}


/// Create a copy of ConsumerMarketState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsumerMarketLoadedCopyWith<ConsumerMarketLoaded> get copyWith => _$ConsumerMarketLoadedCopyWithImpl<ConsumerMarketLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsumerMarketLoaded&&const DeepCollectionEquality().equals(other._marketItems, _marketItems)&&const DeepCollectionEquality().equals(other._farmerProducts, _farmerProducts));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_marketItems),const DeepCollectionEquality().hash(_farmerProducts));

@override
String toString() {
  return 'ConsumerMarketState.loaded(marketItems: $marketItems, farmerProducts: $farmerProducts)';
}


}

/// @nodoc
abstract mixin class $ConsumerMarketLoadedCopyWith<$Res> implements $ConsumerMarketStateCopyWith<$Res> {
  factory $ConsumerMarketLoadedCopyWith(ConsumerMarketLoaded value, $Res Function(ConsumerMarketLoaded) _then) = _$ConsumerMarketLoadedCopyWithImpl;
@useResult
$Res call({
 List<MarketItemEntity> marketItems, List<ProductEntity> farmerProducts
});




}
/// @nodoc
class _$ConsumerMarketLoadedCopyWithImpl<$Res>
    implements $ConsumerMarketLoadedCopyWith<$Res> {
  _$ConsumerMarketLoadedCopyWithImpl(this._self, this._then);

  final ConsumerMarketLoaded _self;
  final $Res Function(ConsumerMarketLoaded) _then;

/// Create a copy of ConsumerMarketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? marketItems = null,Object? farmerProducts = null,}) {
  return _then(ConsumerMarketLoaded(
marketItems: null == marketItems ? _self._marketItems : marketItems // ignore: cast_nullable_to_non_nullable
as List<MarketItemEntity>,farmerProducts: null == farmerProducts ? _self._farmerProducts : farmerProducts // ignore: cast_nullable_to_non_nullable
as List<ProductEntity>,
  ));
}


}

/// @nodoc


class ConsumerMarketError implements ConsumerMarketState {
  const ConsumerMarketError(this.message);
  

 final  String message;

/// Create a copy of ConsumerMarketState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsumerMarketErrorCopyWith<ConsumerMarketError> get copyWith => _$ConsumerMarketErrorCopyWithImpl<ConsumerMarketError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsumerMarketError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ConsumerMarketState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ConsumerMarketErrorCopyWith<$Res> implements $ConsumerMarketStateCopyWith<$Res> {
  factory $ConsumerMarketErrorCopyWith(ConsumerMarketError value, $Res Function(ConsumerMarketError) _then) = _$ConsumerMarketErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ConsumerMarketErrorCopyWithImpl<$Res>
    implements $ConsumerMarketErrorCopyWith<$Res> {
  _$ConsumerMarketErrorCopyWithImpl(this._self, this._then);

  final ConsumerMarketError _self;
  final $Res Function(ConsumerMarketError) _then;

/// Create a copy of ConsumerMarketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ConsumerMarketError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
