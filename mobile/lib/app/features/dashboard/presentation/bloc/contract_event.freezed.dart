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





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContractEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContractEvent()';
}


}

/// @nodoc
class $ContractEventCopyWith<$Res>  {
$ContractEventCopyWith(ContractEvent _, $Res Function(ContractEvent) __);
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CreateContract value)?  createContract,TResult Function( FetchUserContracts value)?  fetchUserContracts,TResult Function( UpdateContractStatus value)?  updateContractStatus,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CreateContract() when createContract != null:
return createContract(_that);case FetchUserContracts() when fetchUserContracts != null:
return fetchUserContracts(_that);case UpdateContractStatus() when updateContractStatus != null:
return updateContractStatus(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CreateContract value)  createContract,required TResult Function( FetchUserContracts value)  fetchUserContracts,required TResult Function( UpdateContractStatus value)  updateContractStatus,}){
final _that = this;
switch (_that) {
case CreateContract():
return createContract(_that);case FetchUserContracts():
return fetchUserContracts(_that);case UpdateContractStatus():
return updateContractStatus(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CreateContract value)?  createContract,TResult? Function( FetchUserContracts value)?  fetchUserContracts,TResult? Function( UpdateContractStatus value)?  updateContractStatus,}){
final _that = this;
switch (_that) {
case CreateContract() when createContract != null:
return createContract(_that);case FetchUserContracts() when fetchUserContracts != null:
return fetchUserContracts(_that);case UpdateContractStatus() when updateContractStatus != null:
return updateContractStatus(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ContractEntity contract)?  createContract,TResult Function( String userId,  String role)?  fetchUserContracts,TResult Function( String id,  String status)?  updateContractStatus,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CreateContract() when createContract != null:
return createContract(_that.contract);case FetchUserContracts() when fetchUserContracts != null:
return fetchUserContracts(_that.userId,_that.role);case UpdateContractStatus() when updateContractStatus != null:
return updateContractStatus(_that.id,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ContractEntity contract)  createContract,required TResult Function( String userId,  String role)  fetchUserContracts,required TResult Function( String id,  String status)  updateContractStatus,}) {final _that = this;
switch (_that) {
case CreateContract():
return createContract(_that.contract);case FetchUserContracts():
return fetchUserContracts(_that.userId,_that.role);case UpdateContractStatus():
return updateContractStatus(_that.id,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ContractEntity contract)?  createContract,TResult? Function( String userId,  String role)?  fetchUserContracts,TResult? Function( String id,  String status)?  updateContractStatus,}) {final _that = this;
switch (_that) {
case CreateContract() when createContract != null:
return createContract(_that.contract);case FetchUserContracts() when fetchUserContracts != null:
return fetchUserContracts(_that.userId,_that.role);case UpdateContractStatus() when updateContractStatus != null:
return updateContractStatus(_that.id,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class CreateContract implements ContractEvent {
  const CreateContract(this.contract);
  

 final  ContractEntity contract;

/// Create a copy of ContractEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
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
@useResult
$Res call({
 ContractEntity contract
});


$ContractEntityCopyWith<$Res> get contract;

}
/// @nodoc
class _$CreateContractCopyWithImpl<$Res>
    implements $CreateContractCopyWith<$Res> {
  _$CreateContractCopyWithImpl(this._self, this._then);

  final CreateContract _self;
  final $Res Function(CreateContract) _then;

/// Create a copy of ContractEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contract = null,}) {
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

/// @nodoc


class FetchUserContracts implements ContractEvent {
  const FetchUserContracts({required this.userId, required this.role});
  

 final  String userId;
 final  String role;

/// Create a copy of ContractEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchUserContractsCopyWith<FetchUserContracts> get copyWith => _$FetchUserContractsCopyWithImpl<FetchUserContracts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchUserContracts&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,userId,role);

@override
String toString() {
  return 'ContractEvent.fetchUserContracts(userId: $userId, role: $role)';
}


}

/// @nodoc
abstract mixin class $FetchUserContractsCopyWith<$Res> implements $ContractEventCopyWith<$Res> {
  factory $FetchUserContractsCopyWith(FetchUserContracts value, $Res Function(FetchUserContracts) _then) = _$FetchUserContractsCopyWithImpl;
@useResult
$Res call({
 String userId, String role
});




}
/// @nodoc
class _$FetchUserContractsCopyWithImpl<$Res>
    implements $FetchUserContractsCopyWith<$Res> {
  _$FetchUserContractsCopyWithImpl(this._self, this._then);

  final FetchUserContracts _self;
  final $Res Function(FetchUserContracts) _then;

/// Create a copy of ContractEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? role = null,}) {
  return _then(FetchUserContracts(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UpdateContractStatus implements ContractEvent {
  const UpdateContractStatus({required this.id, required this.status});
  

 final  String id;
 final  String status;

/// Create a copy of ContractEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateContractStatusCopyWith<UpdateContractStatus> get copyWith => _$UpdateContractStatusCopyWithImpl<UpdateContractStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateContractStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,status);

@override
String toString() {
  return 'ContractEvent.updateContractStatus(id: $id, status: $status)';
}


}

/// @nodoc
abstract mixin class $UpdateContractStatusCopyWith<$Res> implements $ContractEventCopyWith<$Res> {
  factory $UpdateContractStatusCopyWith(UpdateContractStatus value, $Res Function(UpdateContractStatus) _then) = _$UpdateContractStatusCopyWithImpl;
@useResult
$Res call({
 String id, String status
});




}
/// @nodoc
class _$UpdateContractStatusCopyWithImpl<$Res>
    implements $UpdateContractStatusCopyWith<$Res> {
  _$UpdateContractStatusCopyWithImpl(this._self, this._then);

  final UpdateContractStatus _self;
  final $Res Function(UpdateContractStatus) _then;

/// Create a copy of ContractEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,}) {
  return _then(UpdateContractStatus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
