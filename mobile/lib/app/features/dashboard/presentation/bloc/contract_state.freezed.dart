// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contract_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContractState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContractState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContractState()';
}


}

/// @nodoc
class $ContractStateCopyWith<$Res>  {
$ContractStateCopyWith(ContractState _, $Res Function(ContractState) __);
}


/// Adds pattern-matching-related methods to [ContractState].
extension ContractStatePatterns on ContractState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ContractInitial value)?  initial,TResult Function( ContractLoading value)?  loading,TResult Function( ContractSubmitting value)?  submitting,TResult Function( ContractSuccess value)?  success,TResult Function( ContractsLoaded value)?  contractsLoaded,TResult Function( ContractFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ContractInitial() when initial != null:
return initial(_that);case ContractLoading() when loading != null:
return loading(_that);case ContractSubmitting() when submitting != null:
return submitting(_that);case ContractSuccess() when success != null:
return success(_that);case ContractsLoaded() when contractsLoaded != null:
return contractsLoaded(_that);case ContractFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ContractInitial value)  initial,required TResult Function( ContractLoading value)  loading,required TResult Function( ContractSubmitting value)  submitting,required TResult Function( ContractSuccess value)  success,required TResult Function( ContractsLoaded value)  contractsLoaded,required TResult Function( ContractFailure value)  failure,}){
final _that = this;
switch (_that) {
case ContractInitial():
return initial(_that);case ContractLoading():
return loading(_that);case ContractSubmitting():
return submitting(_that);case ContractSuccess():
return success(_that);case ContractsLoaded():
return contractsLoaded(_that);case ContractFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ContractInitial value)?  initial,TResult? Function( ContractLoading value)?  loading,TResult? Function( ContractSubmitting value)?  submitting,TResult? Function( ContractSuccess value)?  success,TResult? Function( ContractsLoaded value)?  contractsLoaded,TResult? Function( ContractFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ContractInitial() when initial != null:
return initial(_that);case ContractLoading() when loading != null:
return loading(_that);case ContractSubmitting() when submitting != null:
return submitting(_that);case ContractSuccess() when success != null:
return success(_that);case ContractsLoaded() when contractsLoaded != null:
return contractsLoaded(_that);case ContractFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  submitting,TResult Function( ContractEntity contract)?  success,TResult Function( List<ContractEntity> contracts)?  contractsLoaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ContractInitial() when initial != null:
return initial();case ContractLoading() when loading != null:
return loading();case ContractSubmitting() when submitting != null:
return submitting();case ContractSuccess() when success != null:
return success(_that.contract);case ContractsLoaded() when contractsLoaded != null:
return contractsLoaded(_that.contracts);case ContractFailure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  submitting,required TResult Function( ContractEntity contract)  success,required TResult Function( List<ContractEntity> contracts)  contractsLoaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case ContractInitial():
return initial();case ContractLoading():
return loading();case ContractSubmitting():
return submitting();case ContractSuccess():
return success(_that.contract);case ContractsLoaded():
return contractsLoaded(_that.contracts);case ContractFailure():
return failure(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  submitting,TResult? Function( ContractEntity contract)?  success,TResult? Function( List<ContractEntity> contracts)?  contractsLoaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case ContractInitial() when initial != null:
return initial();case ContractLoading() when loading != null:
return loading();case ContractSubmitting() when submitting != null:
return submitting();case ContractSuccess() when success != null:
return success(_that.contract);case ContractsLoaded() when contractsLoaded != null:
return contractsLoaded(_that.contracts);case ContractFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ContractInitial implements ContractState {
  const ContractInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContractInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContractState.initial()';
}


}




/// @nodoc


class ContractLoading implements ContractState {
  const ContractLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContractLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContractState.loading()';
}


}




/// @nodoc


class ContractSubmitting implements ContractState {
  const ContractSubmitting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContractSubmitting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContractState.submitting()';
}


}




/// @nodoc


class ContractSuccess implements ContractState {
  const ContractSuccess(this.contract);
  

 final  ContractEntity contract;

/// Create a copy of ContractState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContractSuccessCopyWith<ContractSuccess> get copyWith => _$ContractSuccessCopyWithImpl<ContractSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContractSuccess&&(identical(other.contract, contract) || other.contract == contract));
}


@override
int get hashCode => Object.hash(runtimeType,contract);

@override
String toString() {
  return 'ContractState.success(contract: $contract)';
}


}

/// @nodoc
abstract mixin class $ContractSuccessCopyWith<$Res> implements $ContractStateCopyWith<$Res> {
  factory $ContractSuccessCopyWith(ContractSuccess value, $Res Function(ContractSuccess) _then) = _$ContractSuccessCopyWithImpl;
@useResult
$Res call({
 ContractEntity contract
});


$ContractEntityCopyWith<$Res> get contract;

}
/// @nodoc
class _$ContractSuccessCopyWithImpl<$Res>
    implements $ContractSuccessCopyWith<$Res> {
  _$ContractSuccessCopyWithImpl(this._self, this._then);

  final ContractSuccess _self;
  final $Res Function(ContractSuccess) _then;

/// Create a copy of ContractState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contract = null,}) {
  return _then(ContractSuccess(
null == contract ? _self.contract : contract // ignore: cast_nullable_to_non_nullable
as ContractEntity,
  ));
}

/// Create a copy of ContractState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContractEntityCopyWith<$Res> get contract {
  
  return $ContractEntityCopyWith<$Res>(_self.contract, (value) {
    return _then(_self.copyWith(contract: value));
  });
}
}

/// @nodoc


class ContractsLoaded implements ContractState {
  const ContractsLoaded(final  List<ContractEntity> contracts): _contracts = contracts;
  

 final  List<ContractEntity> _contracts;
 List<ContractEntity> get contracts {
  if (_contracts is EqualUnmodifiableListView) return _contracts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contracts);
}


/// Create a copy of ContractState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContractsLoadedCopyWith<ContractsLoaded> get copyWith => _$ContractsLoadedCopyWithImpl<ContractsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContractsLoaded&&const DeepCollectionEquality().equals(other._contracts, _contracts));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_contracts));

@override
String toString() {
  return 'ContractState.contractsLoaded(contracts: $contracts)';
}


}

/// @nodoc
abstract mixin class $ContractsLoadedCopyWith<$Res> implements $ContractStateCopyWith<$Res> {
  factory $ContractsLoadedCopyWith(ContractsLoaded value, $Res Function(ContractsLoaded) _then) = _$ContractsLoadedCopyWithImpl;
@useResult
$Res call({
 List<ContractEntity> contracts
});




}
/// @nodoc
class _$ContractsLoadedCopyWithImpl<$Res>
    implements $ContractsLoadedCopyWith<$Res> {
  _$ContractsLoadedCopyWithImpl(this._self, this._then);

  final ContractsLoaded _self;
  final $Res Function(ContractsLoaded) _then;

/// Create a copy of ContractState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contracts = null,}) {
  return _then(ContractsLoaded(
null == contracts ? _self._contracts : contracts // ignore: cast_nullable_to_non_nullable
as List<ContractEntity>,
  ));
}


}

/// @nodoc


class ContractFailure implements ContractState {
  const ContractFailure(this.message);
  

 final  String message;

/// Create a copy of ContractState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContractFailureCopyWith<ContractFailure> get copyWith => _$ContractFailureCopyWithImpl<ContractFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContractFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ContractState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $ContractFailureCopyWith<$Res> implements $ContractStateCopyWith<$Res> {
  factory $ContractFailureCopyWith(ContractFailure value, $Res Function(ContractFailure) _then) = _$ContractFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ContractFailureCopyWithImpl<$Res>
    implements $ContractFailureCopyWith<$Res> {
  _$ContractFailureCopyWithImpl(this._self, this._then);

  final ContractFailure _self;
  final $Res Function(ContractFailure) _then;

/// Create a copy of ContractState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ContractFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
