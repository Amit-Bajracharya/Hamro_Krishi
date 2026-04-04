// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prediction_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PredictionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PredictionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PredictionState()';
}


}

/// @nodoc
class $PredictionStateCopyWith<$Res>  {
$PredictionStateCopyWith(PredictionState _, $Res Function(PredictionState) __);
}


/// Adds pattern-matching-related methods to [PredictionState].
extension PredictionStatePatterns on PredictionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PredictionInitial value)?  initial,TResult Function( PredictionLoading value)?  loading,TResult Function( PredictionLoaded value)?  loaded,TResult Function( PredictionError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PredictionInitial() when initial != null:
return initial(_that);case PredictionLoading() when loading != null:
return loading(_that);case PredictionLoaded() when loaded != null:
return loaded(_that);case PredictionError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PredictionInitial value)  initial,required TResult Function( PredictionLoading value)  loading,required TResult Function( PredictionLoaded value)  loaded,required TResult Function( PredictionError value)  error,}){
final _that = this;
switch (_that) {
case PredictionInitial():
return initial(_that);case PredictionLoading():
return loading(_that);case PredictionLoaded():
return loaded(_that);case PredictionError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PredictionInitial value)?  initial,TResult? Function( PredictionLoading value)?  loading,TResult? Function( PredictionLoaded value)?  loaded,TResult? Function( PredictionError value)?  error,}){
final _that = this;
switch (_that) {
case PredictionInitial() when initial != null:
return initial(_that);case PredictionLoading() when loading != null:
return loading(_that);case PredictionLoaded() when loaded != null:
return loaded(_that);case PredictionError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Prediction> predictions)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PredictionInitial() when initial != null:
return initial();case PredictionLoading() when loading != null:
return loading();case PredictionLoaded() when loaded != null:
return loaded(_that.predictions);case PredictionError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Prediction> predictions)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case PredictionInitial():
return initial();case PredictionLoading():
return loading();case PredictionLoaded():
return loaded(_that.predictions);case PredictionError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Prediction> predictions)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case PredictionInitial() when initial != null:
return initial();case PredictionLoading() when loading != null:
return loading();case PredictionLoaded() when loaded != null:
return loaded(_that.predictions);case PredictionError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class PredictionInitial implements PredictionState {
  const PredictionInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PredictionInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PredictionState.initial()';
}


}




/// @nodoc


class PredictionLoading implements PredictionState {
  const PredictionLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PredictionLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PredictionState.loading()';
}


}




/// @nodoc


class PredictionLoaded implements PredictionState {
  const PredictionLoaded(final  List<Prediction> predictions): _predictions = predictions;
  

 final  List<Prediction> _predictions;
 List<Prediction> get predictions {
  if (_predictions is EqualUnmodifiableListView) return _predictions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_predictions);
}


/// Create a copy of PredictionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PredictionLoadedCopyWith<PredictionLoaded> get copyWith => _$PredictionLoadedCopyWithImpl<PredictionLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PredictionLoaded&&const DeepCollectionEquality().equals(other._predictions, _predictions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_predictions));

@override
String toString() {
  return 'PredictionState.loaded(predictions: $predictions)';
}


}

/// @nodoc
abstract mixin class $PredictionLoadedCopyWith<$Res> implements $PredictionStateCopyWith<$Res> {
  factory $PredictionLoadedCopyWith(PredictionLoaded value, $Res Function(PredictionLoaded) _then) = _$PredictionLoadedCopyWithImpl;
@useResult
$Res call({
 List<Prediction> predictions
});




}
/// @nodoc
class _$PredictionLoadedCopyWithImpl<$Res>
    implements $PredictionLoadedCopyWith<$Res> {
  _$PredictionLoadedCopyWithImpl(this._self, this._then);

  final PredictionLoaded _self;
  final $Res Function(PredictionLoaded) _then;

/// Create a copy of PredictionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? predictions = null,}) {
  return _then(PredictionLoaded(
null == predictions ? _self._predictions : predictions // ignore: cast_nullable_to_non_nullable
as List<Prediction>,
  ));
}


}

/// @nodoc


class PredictionError implements PredictionState {
  const PredictionError(this.message);
  

 final  String message;

/// Create a copy of PredictionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PredictionErrorCopyWith<PredictionError> get copyWith => _$PredictionErrorCopyWithImpl<PredictionError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PredictionError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PredictionState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $PredictionErrorCopyWith<$Res> implements $PredictionStateCopyWith<$Res> {
  factory $PredictionErrorCopyWith(PredictionError value, $Res Function(PredictionError) _then) = _$PredictionErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$PredictionErrorCopyWithImpl<$Res>
    implements $PredictionErrorCopyWith<$Res> {
  _$PredictionErrorCopyWithImpl(this._self, this._then);

  final PredictionError _self;
  final $Res Function(PredictionError) _then;

/// Create a copy of PredictionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(PredictionError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
