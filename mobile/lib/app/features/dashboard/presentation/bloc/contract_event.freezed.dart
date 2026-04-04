// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contract_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContractEvent {

 ContractEntity get contract;
/// Create a copy of ContractEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContractEventCopyWith<ContractEvent> get copyWith => _$ContractEventCopyWithImpl<ContractEvent>(this as ContractEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContractEvent&&(identical(other.contract, contract) || other.contract == contract));
}


@override
int get hashCode => Object.hash(runtimeType,contract);

@override
String toString() {
  return 'ContractEvent(contract: $contract)';
}


}

/// @nodoc
abstract mixin class $ContractEventCopyWith<$Res>  {
  factory $ContractEventCopyWith(ContractEvent value, $Res Function(ContractEvent) _then) = _$ContractEventCopyWithImpl;
@useResult
$Res call({
 ContractEntity contract
});


$ContractEntityCopyWith<$Res> get contract;

}
/// @nodoc
class _$ContractEventCopyWithImpl<$Res>
    implements $ContractEventCopyWith<$Res> {
  _$ContractEventCopyWithImpl(this._self, this._then);

  final ContractEvent _self;
  final $Res Function(ContractEvent) _then;

/// Create a copy of ContractEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contract = null,}) {
  return _then(_self.copyWith(
contract: null == contract ? _self.contract : contract // ignore: cast_nullable_to_non_nullable
as ContractEntity,
  ));
}
/// Create a copy of ContractEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContractEntityCopyWith<$Res> get contract {
  
  return $ContractEntityCopyWith<$Res>(_self.contract, (value) {
    return _then(_self.copyWith(contract: value));
  });
}
}


/// Adds pattern-matching-related methods to [ContractEvent].
extension ContractEventPatterns on ContractEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CreateContract value)?  createContract,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CreateContract() when createContract != null:
return createContract(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CreateContract value)  createContract,}){
final _that = this;
switch (_that) {
case CreateContract():
return createContract(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CreateContract value)?  createContract,}){
final _that = this;
switch (_that) {
case CreateContract() when createContract != null:
return createContract(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ContractEntity contract)?  createContract,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CreateContract() when createContract != null:
return createContract(_that.contract);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ContractEntity contract)  createContract,}) {final _that = this;
switch (_that) {
case CreateContract():
return createContract(_that.contract);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ContractEntity contract)?  createContract,}) {final _that = this;
switch (_that) {
case CreateContract() when createContract != null:
return createContract(_that.contract);case _:
  return null;

}
}

}

/// @nodoc


class CreateContract implements ContractEvent {
  const CreateContract(this.contract);
  

@override final  ContractEntity contract;

/// Create a copy of ContractEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateContractCopyWith<CreateContract> get copyWith => _$CreateContractCopyWithImpl<CreateContract>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateContract&&(identical(other.contract, contract) || other.contract == contract));
}


@override
int get hashCode => Object.hash(runtimeType,contract);

@override
String toString() {
  return 'ContractEvent.createContract(contract: $contract)';
}


}

/// @nodoc
abstract mixin class $CreateContractCopyWith<$Res> implements $ContractEventCopyWith<$Res> {
  factory $CreateContractCopyWith(CreateContract value, $Res Function(CreateContract) _then) = _$CreateContractCopyWithImpl;
@override @useResult
$Res call({
 ContractEntity contract
});


@override $ContractEntityCopyWith<$Res> get contract;

}
/// @nodoc
class _$CreateContractCopyWithImpl<$Res>
    implements $CreateContractCopyWith<$Res> {
  _$CreateContractCopyWithImpl(this._self, this._then);

  final CreateContract _self;
  final $Res Function(CreateContract) _then;

/// Create a copy of ContractEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contract = null,}) {
  return _then(CreateContract(
null == contract ? _self.contract : contract // ignore: cast_nullable_to_non_nullable
as ContractEntity,
  ));
}

/// Create a copy of ContractEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContractEntityCopyWith<$Res> get contract {
  
  return $ContractEntityCopyWith<$Res>(_self.contract, (value) {
    return _then(_self.copyWith(contract: value));
  });
}
}

// dart format on
