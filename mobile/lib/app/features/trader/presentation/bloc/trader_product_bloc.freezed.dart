// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trader_product_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TraderProductEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TraderProductEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TraderProductEvent()';
}


}

/// @nodoc
class $TraderProductEventCopyWith<$Res>  {
$TraderProductEventCopyWith(TraderProductEvent _, $Res Function(TraderProductEvent) __);
}


/// Adds pattern-matching-related methods to [TraderProductEvent].
extension TraderProductEventPatterns on TraderProductEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchTraderProducts value)?  fetchTraderProducts,TResult Function( FetchTraderContracts value)?  fetchTraderContracts,TResult Function( AddTraderProduct value)?  addTraderProduct,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchTraderProducts() when fetchTraderProducts != null:
return fetchTraderProducts(_that);case FetchTraderContracts() when fetchTraderContracts != null:
return fetchTraderContracts(_that);case AddTraderProduct() when addTraderProduct != null:
return addTraderProduct(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchTraderProducts value)  fetchTraderProducts,required TResult Function( FetchTraderContracts value)  fetchTraderContracts,required TResult Function( AddTraderProduct value)  addTraderProduct,}){
final _that = this;
switch (_that) {
case FetchTraderProducts():
return fetchTraderProducts(_that);case FetchTraderContracts():
return fetchTraderContracts(_that);case AddTraderProduct():
return addTraderProduct(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchTraderProducts value)?  fetchTraderProducts,TResult? Function( FetchTraderContracts value)?  fetchTraderContracts,TResult? Function( AddTraderProduct value)?  addTraderProduct,}){
final _that = this;
switch (_that) {
case FetchTraderProducts() when fetchTraderProducts != null:
return fetchTraderProducts(_that);case FetchTraderContracts() when fetchTraderContracts != null:
return fetchTraderContracts(_that);case AddTraderProduct() when addTraderProduct != null:
return addTraderProduct(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String traderId)?  fetchTraderProducts,TResult Function( String traderId)?  fetchTraderContracts,TResult Function( TraderProductEntity product)?  addTraderProduct,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchTraderProducts() when fetchTraderProducts != null:
return fetchTraderProducts(_that.traderId);case FetchTraderContracts() when fetchTraderContracts != null:
return fetchTraderContracts(_that.traderId);case AddTraderProduct() when addTraderProduct != null:
return addTraderProduct(_that.product);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String traderId)  fetchTraderProducts,required TResult Function( String traderId)  fetchTraderContracts,required TResult Function( TraderProductEntity product)  addTraderProduct,}) {final _that = this;
switch (_that) {
case FetchTraderProducts():
return fetchTraderProducts(_that.traderId);case FetchTraderContracts():
return fetchTraderContracts(_that.traderId);case AddTraderProduct():
return addTraderProduct(_that.product);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String traderId)?  fetchTraderProducts,TResult? Function( String traderId)?  fetchTraderContracts,TResult? Function( TraderProductEntity product)?  addTraderProduct,}) {final _that = this;
switch (_that) {
case FetchTraderProducts() when fetchTraderProducts != null:
return fetchTraderProducts(_that.traderId);case FetchTraderContracts() when fetchTraderContracts != null:
return fetchTraderContracts(_that.traderId);case AddTraderProduct() when addTraderProduct != null:
return addTraderProduct(_that.product);case _:
  return null;

}
}

}

/// @nodoc


class FetchTraderProducts implements TraderProductEvent {
  const FetchTraderProducts({required this.traderId});
  

 final  String traderId;

/// Create a copy of TraderProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchTraderProductsCopyWith<FetchTraderProducts> get copyWith => _$FetchTraderProductsCopyWithImpl<FetchTraderProducts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchTraderProducts&&(identical(other.traderId, traderId) || other.traderId == traderId));
}


@override
int get hashCode => Object.hash(runtimeType,traderId);

@override
String toString() {
  return 'TraderProductEvent.fetchTraderProducts(traderId: $traderId)';
}


}

/// @nodoc
abstract mixin class $FetchTraderProductsCopyWith<$Res> implements $TraderProductEventCopyWith<$Res> {
  factory $FetchTraderProductsCopyWith(FetchTraderProducts value, $Res Function(FetchTraderProducts) _then) = _$FetchTraderProductsCopyWithImpl;
@useResult
$Res call({
 String traderId
});




}
/// @nodoc
class _$FetchTraderProductsCopyWithImpl<$Res>
    implements $FetchTraderProductsCopyWith<$Res> {
  _$FetchTraderProductsCopyWithImpl(this._self, this._then);

  final FetchTraderProducts _self;
  final $Res Function(FetchTraderProducts) _then;

/// Create a copy of TraderProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? traderId = null,}) {
  return _then(FetchTraderProducts(
traderId: null == traderId ? _self.traderId : traderId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FetchTraderContracts implements TraderProductEvent {
  const FetchTraderContracts({required this.traderId});
  

 final  String traderId;

/// Create a copy of TraderProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchTraderContractsCopyWith<FetchTraderContracts> get copyWith => _$FetchTraderContractsCopyWithImpl<FetchTraderContracts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchTraderContracts&&(identical(other.traderId, traderId) || other.traderId == traderId));
}


@override
int get hashCode => Object.hash(runtimeType,traderId);

@override
String toString() {
  return 'TraderProductEvent.fetchTraderContracts(traderId: $traderId)';
}


}

/// @nodoc
abstract mixin class $FetchTraderContractsCopyWith<$Res> implements $TraderProductEventCopyWith<$Res> {
  factory $FetchTraderContractsCopyWith(FetchTraderContracts value, $Res Function(FetchTraderContracts) _then) = _$FetchTraderContractsCopyWithImpl;
@useResult
$Res call({
 String traderId
});




}
/// @nodoc
class _$FetchTraderContractsCopyWithImpl<$Res>
    implements $FetchTraderContractsCopyWith<$Res> {
  _$FetchTraderContractsCopyWithImpl(this._self, this._then);

  final FetchTraderContracts _self;
  final $Res Function(FetchTraderContracts) _then;

/// Create a copy of TraderProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? traderId = null,}) {
  return _then(FetchTraderContracts(
traderId: null == traderId ? _self.traderId : traderId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AddTraderProduct implements TraderProductEvent {
  const AddTraderProduct({required this.product});
  

 final  TraderProductEntity product;

/// Create a copy of TraderProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddTraderProductCopyWith<AddTraderProduct> get copyWith => _$AddTraderProductCopyWithImpl<AddTraderProduct>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddTraderProduct&&(identical(other.product, product) || other.product == product));
}


@override
int get hashCode => Object.hash(runtimeType,product);

@override
String toString() {
  return 'TraderProductEvent.addTraderProduct(product: $product)';
}


}

/// @nodoc
abstract mixin class $AddTraderProductCopyWith<$Res> implements $TraderProductEventCopyWith<$Res> {
  factory $AddTraderProductCopyWith(AddTraderProduct value, $Res Function(AddTraderProduct) _then) = _$AddTraderProductCopyWithImpl;
@useResult
$Res call({
 TraderProductEntity product
});


$TraderProductEntityCopyWith<$Res> get product;

}
/// @nodoc
class _$AddTraderProductCopyWithImpl<$Res>
    implements $AddTraderProductCopyWith<$Res> {
  _$AddTraderProductCopyWithImpl(this._self, this._then);

  final AddTraderProduct _self;
  final $Res Function(AddTraderProduct) _then;

/// Create a copy of TraderProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,}) {
  return _then(AddTraderProduct(
product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as TraderProductEntity,
  ));
}

/// Create a copy of TraderProductEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TraderProductEntityCopyWith<$Res> get product {
  
  return $TraderProductEntityCopyWith<$Res>(_self.product, (value) {
    return _then(_self.copyWith(product: value));
  });
}
}

/// @nodoc
mixin _$TraderProductState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TraderProductState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TraderProductState()';
}


}

/// @nodoc
class $TraderProductStateCopyWith<$Res>  {
$TraderProductStateCopyWith(TraderProductState _, $Res Function(TraderProductState) __);
}


/// Adds pattern-matching-related methods to [TraderProductState].
extension TraderProductStatePatterns on TraderProductState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TraderProductInitial value)?  initial,TResult Function( TraderProductLoading value)?  loading,TResult Function( TraderProductLoaded value)?  loaded,TResult Function( TraderProductSuccess value)?  success,TResult Function( TraderProductFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TraderProductInitial() when initial != null:
return initial(_that);case TraderProductLoading() when loading != null:
return loading(_that);case TraderProductLoaded() when loaded != null:
return loaded(_that);case TraderProductSuccess() when success != null:
return success(_that);case TraderProductFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TraderProductInitial value)  initial,required TResult Function( TraderProductLoading value)  loading,required TResult Function( TraderProductLoaded value)  loaded,required TResult Function( TraderProductSuccess value)  success,required TResult Function( TraderProductFailure value)  failure,}){
final _that = this;
switch (_that) {
case TraderProductInitial():
return initial(_that);case TraderProductLoading():
return loading(_that);case TraderProductLoaded():
return loaded(_that);case TraderProductSuccess():
return success(_that);case TraderProductFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TraderProductInitial value)?  initial,TResult? Function( TraderProductLoading value)?  loading,TResult? Function( TraderProductLoaded value)?  loaded,TResult? Function( TraderProductSuccess value)?  success,TResult? Function( TraderProductFailure value)?  failure,}){
final _that = this;
switch (_that) {
case TraderProductInitial() when initial != null:
return initial(_that);case TraderProductLoading() when loading != null:
return loading(_that);case TraderProductLoaded() when loaded != null:
return loaded(_that);case TraderProductSuccess() when success != null:
return success(_that);case TraderProductFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<TraderProductEntity> products,  List<ContractEntity> contracts)?  loaded,TResult Function( String message)?  success,TResult Function( String error)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TraderProductInitial() when initial != null:
return initial();case TraderProductLoading() when loading != null:
return loading();case TraderProductLoaded() when loaded != null:
return loaded(_that.products,_that.contracts);case TraderProductSuccess() when success != null:
return success(_that.message);case TraderProductFailure() when failure != null:
return failure(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<TraderProductEntity> products,  List<ContractEntity> contracts)  loaded,required TResult Function( String message)  success,required TResult Function( String error)  failure,}) {final _that = this;
switch (_that) {
case TraderProductInitial():
return initial();case TraderProductLoading():
return loading();case TraderProductLoaded():
return loaded(_that.products,_that.contracts);case TraderProductSuccess():
return success(_that.message);case TraderProductFailure():
return failure(_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<TraderProductEntity> products,  List<ContractEntity> contracts)?  loaded,TResult? Function( String message)?  success,TResult? Function( String error)?  failure,}) {final _that = this;
switch (_that) {
case TraderProductInitial() when initial != null:
return initial();case TraderProductLoading() when loading != null:
return loading();case TraderProductLoaded() when loaded != null:
return loaded(_that.products,_that.contracts);case TraderProductSuccess() when success != null:
return success(_that.message);case TraderProductFailure() when failure != null:
return failure(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class TraderProductInitial implements TraderProductState {
  const TraderProductInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TraderProductInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TraderProductState.initial()';
}


}




/// @nodoc


class TraderProductLoading implements TraderProductState {
  const TraderProductLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TraderProductLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TraderProductState.loading()';
}


}




/// @nodoc


class TraderProductLoaded implements TraderProductState {
  const TraderProductLoaded({required final  List<TraderProductEntity> products, final  List<ContractEntity> contracts = const []}): _products = products,_contracts = contracts;
  

 final  List<TraderProductEntity> _products;
 List<TraderProductEntity> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  List<ContractEntity> _contracts;
@JsonKey() List<ContractEntity> get contracts {
  if (_contracts is EqualUnmodifiableListView) return _contracts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contracts);
}


/// Create a copy of TraderProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TraderProductLoadedCopyWith<TraderProductLoaded> get copyWith => _$TraderProductLoadedCopyWithImpl<TraderProductLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TraderProductLoaded&&const DeepCollectionEquality().equals(other._products, _products)&&const DeepCollectionEquality().equals(other._contracts, _contracts));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),const DeepCollectionEquality().hash(_contracts));

@override
String toString() {
  return 'TraderProductState.loaded(products: $products, contracts: $contracts)';
}


}

/// @nodoc
abstract mixin class $TraderProductLoadedCopyWith<$Res> implements $TraderProductStateCopyWith<$Res> {
  factory $TraderProductLoadedCopyWith(TraderProductLoaded value, $Res Function(TraderProductLoaded) _then) = _$TraderProductLoadedCopyWithImpl;
@useResult
$Res call({
 List<TraderProductEntity> products, List<ContractEntity> contracts
});




}
/// @nodoc
class _$TraderProductLoadedCopyWithImpl<$Res>
    implements $TraderProductLoadedCopyWith<$Res> {
  _$TraderProductLoadedCopyWithImpl(this._self, this._then);

  final TraderProductLoaded _self;
  final $Res Function(TraderProductLoaded) _then;

/// Create a copy of TraderProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? products = null,Object? contracts = null,}) {
  return _then(TraderProductLoaded(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<TraderProductEntity>,contracts: null == contracts ? _self._contracts : contracts // ignore: cast_nullable_to_non_nullable
as List<ContractEntity>,
  ));
}


}

/// @nodoc


class TraderProductSuccess implements TraderProductState {
  const TraderProductSuccess({required this.message});
  

 final  String message;

/// Create a copy of TraderProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TraderProductSuccessCopyWith<TraderProductSuccess> get copyWith => _$TraderProductSuccessCopyWithImpl<TraderProductSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TraderProductSuccess&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TraderProductState.success(message: $message)';
}


}

/// @nodoc
abstract mixin class $TraderProductSuccessCopyWith<$Res> implements $TraderProductStateCopyWith<$Res> {
  factory $TraderProductSuccessCopyWith(TraderProductSuccess value, $Res Function(TraderProductSuccess) _then) = _$TraderProductSuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$TraderProductSuccessCopyWithImpl<$Res>
    implements $TraderProductSuccessCopyWith<$Res> {
  _$TraderProductSuccessCopyWithImpl(this._self, this._then);

  final TraderProductSuccess _self;
  final $Res Function(TraderProductSuccess) _then;

/// Create a copy of TraderProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(TraderProductSuccess(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TraderProductFailure implements TraderProductState {
  const TraderProductFailure({required this.error});
  

 final  String error;

/// Create a copy of TraderProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TraderProductFailureCopyWith<TraderProductFailure> get copyWith => _$TraderProductFailureCopyWithImpl<TraderProductFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TraderProductFailure&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'TraderProductState.failure(error: $error)';
}


}

/// @nodoc
abstract mixin class $TraderProductFailureCopyWith<$Res> implements $TraderProductStateCopyWith<$Res> {
  factory $TraderProductFailureCopyWith(TraderProductFailure value, $Res Function(TraderProductFailure) _then) = _$TraderProductFailureCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$TraderProductFailureCopyWithImpl<$Res>
    implements $TraderProductFailureCopyWith<$Res> {
  _$TraderProductFailureCopyWithImpl(this._self, this._then);

  final TraderProductFailure _self;
  final $Res Function(TraderProductFailure) _then;

/// Create a copy of TraderProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(TraderProductFailure(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
