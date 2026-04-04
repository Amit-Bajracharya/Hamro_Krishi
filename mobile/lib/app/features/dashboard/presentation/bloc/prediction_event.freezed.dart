// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prediction_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PredictionEvent {

 String get productName;
/// Create a copy of PredictionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PredictionEventCopyWith<PredictionEvent> get copyWith => _$PredictionEventCopyWithImpl<PredictionEvent>(this as PredictionEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PredictionEvent&&(identical(other.productName, productName) || other.productName == productName));
}


@override
int get hashCode => Object.hash(runtimeType,productName);

@override
String toString() {
  return 'PredictionEvent(productName: $productName)';
}


}

/// @nodoc
abstract mixin class $PredictionEventCopyWith<$Res>  {
  factory $PredictionEventCopyWith(PredictionEvent value, $Res Function(PredictionEvent) _then) = _$PredictionEventCopyWithImpl;
@useResult
$Res call({
 String productName
});




}
/// @nodoc
class _$PredictionEventCopyWithImpl<$Res>
    implements $PredictionEventCopyWith<$Res> {
  _$PredictionEventCopyWithImpl(this._self, this._then);

  final PredictionEvent _self;
  final $Res Function(PredictionEvent) _then;

/// Create a copy of PredictionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productName = null,}) {
  return _then(_self.copyWith(
productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PredictionEvent].
extension PredictionEventPatterns on PredictionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchPrediction value)?  fetchPrediction,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchPrediction() when fetchPrediction != null:
return fetchPrediction(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchPrediction value)  fetchPrediction,}){
final _that = this;
switch (_that) {
case FetchPrediction():
return fetchPrediction(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchPrediction value)?  fetchPrediction,}){
final _that = this;
switch (_that) {
case FetchPrediction() when fetchPrediction != null:
return fetchPrediction(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String productName)?  fetchPrediction,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchPrediction() when fetchPrediction != null:
return fetchPrediction(_that.productName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String productName)  fetchPrediction,}) {final _that = this;
switch (_that) {
case FetchPrediction():
return fetchPrediction(_that.productName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String productName)?  fetchPrediction,}) {final _that = this;
switch (_that) {
case FetchPrediction() when fetchPrediction != null:
return fetchPrediction(_that.productName);case _:
  return null;

}
}

}

/// @nodoc


class FetchPrediction implements PredictionEvent {
  const FetchPrediction({required this.productName});
  

@override final  String productName;

/// Create a copy of PredictionEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchPredictionCopyWith<FetchPrediction> get copyWith => _$FetchPredictionCopyWithImpl<FetchPrediction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchPrediction&&(identical(other.productName, productName) || other.productName == productName));
}


@override
int get hashCode => Object.hash(runtimeType,productName);

@override
String toString() {
  return 'PredictionEvent.fetchPrediction(productName: $productName)';
}


}

/// @nodoc
abstract mixin class $FetchPredictionCopyWith<$Res> implements $PredictionEventCopyWith<$Res> {
  factory $FetchPredictionCopyWith(FetchPrediction value, $Res Function(FetchPrediction) _then) = _$FetchPredictionCopyWithImpl;
@override @useResult
$Res call({
 String productName
});




}
/// @nodoc
class _$FetchPredictionCopyWithImpl<$Res>
    implements $FetchPredictionCopyWith<$Res> {
  _$FetchPredictionCopyWithImpl(this._self, this._then);

  final FetchPrediction _self;
  final $Res Function(FetchPrediction) _then;

/// Create a copy of PredictionEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productName = null,}) {
  return _then(FetchPrediction(
productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
