// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contract_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContractModel {

 String? get id;@JsonKey(name: 'farmer_id') String get farmerId;@JsonKey(name: 'middleman_id') String get middlemanId;@JsonKey(name: 'product_id') String get productId;@DoubleConverter() double get quantity;@JsonKey(name: 'farmer_selling_price')@DoubleConverter() double get farmerSellingPrice;@JsonKey(name: 'trader_selling_price')@DoubleConverter() double get traderSellingPrice;@JsonKey(name: 'start_date') DateTime get startDate; String get status;@JsonKey(name: 'trader_name') String? get traderName;@JsonKey(name: 'farmer_name') String? get farmerName;@JsonKey(name: 'product_name') String? get productName;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of ContractModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContractModelCopyWith<ContractModel> get copyWith => _$ContractModelCopyWithImpl<ContractModel>(this as ContractModel, _$identity);

  /// Serializes this ContractModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContractModel&&(identical(other.id, id) || other.id == id)&&(identical(other.farmerId, farmerId) || other.farmerId == farmerId)&&(identical(other.middlemanId, middlemanId) || other.middlemanId == middlemanId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.farmerSellingPrice, farmerSellingPrice) || other.farmerSellingPrice == farmerSellingPrice)&&(identical(other.traderSellingPrice, traderSellingPrice) || other.traderSellingPrice == traderSellingPrice)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.traderName, traderName) || other.traderName == traderName)&&(identical(other.farmerName, farmerName) || other.farmerName == farmerName)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,farmerId,middlemanId,productId,quantity,farmerSellingPrice,traderSellingPrice,startDate,status,traderName,farmerName,productName,createdAt,updatedAt);

@override
String toString() {
  return 'ContractModel(id: $id, farmerId: $farmerId, middlemanId: $middlemanId, productId: $productId, quantity: $quantity, farmerSellingPrice: $farmerSellingPrice, traderSellingPrice: $traderSellingPrice, startDate: $startDate, status: $status, traderName: $traderName, farmerName: $farmerName, productName: $productName, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ContractModelCopyWith<$Res>  {
  factory $ContractModelCopyWith(ContractModel value, $Res Function(ContractModel) _then) = _$ContractModelCopyWithImpl;
@useResult
$Res call({
 String? id,@JsonKey(name: 'farmer_id') String farmerId,@JsonKey(name: 'middleman_id') String middlemanId,@JsonKey(name: 'product_id') String productId,@DoubleConverter() double quantity,@JsonKey(name: 'farmer_selling_price')@DoubleConverter() double farmerSellingPrice,@JsonKey(name: 'trader_selling_price')@DoubleConverter() double traderSellingPrice,@JsonKey(name: 'start_date') DateTime startDate, String status,@JsonKey(name: 'trader_name') String? traderName,@JsonKey(name: 'farmer_name') String? farmerName,@JsonKey(name: 'product_name') String? productName,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$ContractModelCopyWithImpl<$Res>
    implements $ContractModelCopyWith<$Res> {
  _$ContractModelCopyWithImpl(this._self, this._then);

  final ContractModel _self;
  final $Res Function(ContractModel) _then;

/// Create a copy of ContractModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? farmerId = null,Object? middlemanId = null,Object? productId = null,Object? quantity = null,Object? farmerSellingPrice = null,Object? traderSellingPrice = null,Object? startDate = null,Object? status = null,Object? traderName = freezed,Object? farmerName = freezed,Object? productName = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,farmerId: null == farmerId ? _self.farmerId : farmerId // ignore: cast_nullable_to_non_nullable
as String,middlemanId: null == middlemanId ? _self.middlemanId : middlemanId // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,farmerSellingPrice: null == farmerSellingPrice ? _self.farmerSellingPrice : farmerSellingPrice // ignore: cast_nullable_to_non_nullable
as double,traderSellingPrice: null == traderSellingPrice ? _self.traderSellingPrice : traderSellingPrice // ignore: cast_nullable_to_non_nullable
as double,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,traderName: freezed == traderName ? _self.traderName : traderName // ignore: cast_nullable_to_non_nullable
as String?,farmerName: freezed == farmerName ? _self.farmerName : farmerName // ignore: cast_nullable_to_non_nullable
as String?,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ContractModel].
extension ContractModelPatterns on ContractModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContractModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContractModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContractModel value)  $default,){
final _that = this;
switch (_that) {
case _ContractModel():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContractModel value)?  $default,){
final _that = this;
switch (_that) {
case _ContractModel() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'farmer_id')  String farmerId, @JsonKey(name: 'middleman_id')  String middlemanId, @JsonKey(name: 'product_id')  String productId, @DoubleConverter()  double quantity, @JsonKey(name: 'farmer_selling_price')@DoubleConverter()  double farmerSellingPrice, @JsonKey(name: 'trader_selling_price')@DoubleConverter()  double traderSellingPrice, @JsonKey(name: 'start_date')  DateTime startDate,  String status, @JsonKey(name: 'trader_name')  String? traderName, @JsonKey(name: 'farmer_name')  String? farmerName, @JsonKey(name: 'product_name')  String? productName, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContractModel() when $default != null:
return $default(_that.id,_that.farmerId,_that.middlemanId,_that.productId,_that.quantity,_that.farmerSellingPrice,_that.traderSellingPrice,_that.startDate,_that.status,_that.traderName,_that.farmerName,_that.productName,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'farmer_id')  String farmerId, @JsonKey(name: 'middleman_id')  String middlemanId, @JsonKey(name: 'product_id')  String productId, @DoubleConverter()  double quantity, @JsonKey(name: 'farmer_selling_price')@DoubleConverter()  double farmerSellingPrice, @JsonKey(name: 'trader_selling_price')@DoubleConverter()  double traderSellingPrice, @JsonKey(name: 'start_date')  DateTime startDate,  String status, @JsonKey(name: 'trader_name')  String? traderName, @JsonKey(name: 'farmer_name')  String? farmerName, @JsonKey(name: 'product_name')  String? productName, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ContractModel():
return $default(_that.id,_that.farmerId,_that.middlemanId,_that.productId,_that.quantity,_that.farmerSellingPrice,_that.traderSellingPrice,_that.startDate,_that.status,_that.traderName,_that.farmerName,_that.productName,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id, @JsonKey(name: 'farmer_id')  String farmerId, @JsonKey(name: 'middleman_id')  String middlemanId, @JsonKey(name: 'product_id')  String productId, @DoubleConverter()  double quantity, @JsonKey(name: 'farmer_selling_price')@DoubleConverter()  double farmerSellingPrice, @JsonKey(name: 'trader_selling_price')@DoubleConverter()  double traderSellingPrice, @JsonKey(name: 'start_date')  DateTime startDate,  String status, @JsonKey(name: 'trader_name')  String? traderName, @JsonKey(name: 'farmer_name')  String? farmerName, @JsonKey(name: 'product_name')  String? productName, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ContractModel() when $default != null:
return $default(_that.id,_that.farmerId,_that.middlemanId,_that.productId,_that.quantity,_that.farmerSellingPrice,_that.traderSellingPrice,_that.startDate,_that.status,_that.traderName,_that.farmerName,_that.productName,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContractModel extends ContractModel {
  const _ContractModel({this.id, @JsonKey(name: 'farmer_id') required this.farmerId, @JsonKey(name: 'middleman_id') required this.middlemanId, @JsonKey(name: 'product_id') required this.productId, @DoubleConverter() required this.quantity, @JsonKey(name: 'farmer_selling_price')@DoubleConverter() required this.farmerSellingPrice, @JsonKey(name: 'trader_selling_price')@DoubleConverter() required this.traderSellingPrice, @JsonKey(name: 'start_date') required this.startDate, this.status = 'active', @JsonKey(name: 'trader_name') this.traderName, @JsonKey(name: 'farmer_name') this.farmerName, @JsonKey(name: 'product_name') this.productName, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt}): super._();
  factory _ContractModel.fromJson(Map<String, dynamic> json) => _$ContractModelFromJson(json);

@override final  String? id;
@override@JsonKey(name: 'farmer_id') final  String farmerId;
@override@JsonKey(name: 'middleman_id') final  String middlemanId;
@override@JsonKey(name: 'product_id') final  String productId;
@override@DoubleConverter() final  double quantity;
@override@JsonKey(name: 'farmer_selling_price')@DoubleConverter() final  double farmerSellingPrice;
@override@JsonKey(name: 'trader_selling_price')@DoubleConverter() final  double traderSellingPrice;
@override@JsonKey(name: 'start_date') final  DateTime startDate;
@override@JsonKey() final  String status;
@override@JsonKey(name: 'trader_name') final  String? traderName;
@override@JsonKey(name: 'farmer_name') final  String? farmerName;
@override@JsonKey(name: 'product_name') final  String? productName;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of ContractModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContractModelCopyWith<_ContractModel> get copyWith => __$ContractModelCopyWithImpl<_ContractModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContractModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContractModel&&(identical(other.id, id) || other.id == id)&&(identical(other.farmerId, farmerId) || other.farmerId == farmerId)&&(identical(other.middlemanId, middlemanId) || other.middlemanId == middlemanId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.farmerSellingPrice, farmerSellingPrice) || other.farmerSellingPrice == farmerSellingPrice)&&(identical(other.traderSellingPrice, traderSellingPrice) || other.traderSellingPrice == traderSellingPrice)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.traderName, traderName) || other.traderName == traderName)&&(identical(other.farmerName, farmerName) || other.farmerName == farmerName)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,farmerId,middlemanId,productId,quantity,farmerSellingPrice,traderSellingPrice,startDate,status,traderName,farmerName,productName,createdAt,updatedAt);

@override
String toString() {
  return 'ContractModel(id: $id, farmerId: $farmerId, middlemanId: $middlemanId, productId: $productId, quantity: $quantity, farmerSellingPrice: $farmerSellingPrice, traderSellingPrice: $traderSellingPrice, startDate: $startDate, status: $status, traderName: $traderName, farmerName: $farmerName, productName: $productName, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ContractModelCopyWith<$Res> implements $ContractModelCopyWith<$Res> {
  factory _$ContractModelCopyWith(_ContractModel value, $Res Function(_ContractModel) _then) = __$ContractModelCopyWithImpl;
@override @useResult
$Res call({
 String? id,@JsonKey(name: 'farmer_id') String farmerId,@JsonKey(name: 'middleman_id') String middlemanId,@JsonKey(name: 'product_id') String productId,@DoubleConverter() double quantity,@JsonKey(name: 'farmer_selling_price')@DoubleConverter() double farmerSellingPrice,@JsonKey(name: 'trader_selling_price')@DoubleConverter() double traderSellingPrice,@JsonKey(name: 'start_date') DateTime startDate, String status,@JsonKey(name: 'trader_name') String? traderName,@JsonKey(name: 'farmer_name') String? farmerName,@JsonKey(name: 'product_name') String? productName,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$ContractModelCopyWithImpl<$Res>
    implements _$ContractModelCopyWith<$Res> {
  __$ContractModelCopyWithImpl(this._self, this._then);

  final _ContractModel _self;
  final $Res Function(_ContractModel) _then;

/// Create a copy of ContractModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? farmerId = null,Object? middlemanId = null,Object? productId = null,Object? quantity = null,Object? farmerSellingPrice = null,Object? traderSellingPrice = null,Object? startDate = null,Object? status = null,Object? traderName = freezed,Object? farmerName = freezed,Object? productName = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_ContractModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,farmerId: null == farmerId ? _self.farmerId : farmerId // ignore: cast_nullable_to_non_nullable
as String,middlemanId: null == middlemanId ? _self.middlemanId : middlemanId // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,farmerSellingPrice: null == farmerSellingPrice ? _self.farmerSellingPrice : farmerSellingPrice // ignore: cast_nullable_to_non_nullable
as double,traderSellingPrice: null == traderSellingPrice ? _self.traderSellingPrice : traderSellingPrice // ignore: cast_nullable_to_non_nullable
as double,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,traderName: freezed == traderName ? _self.traderName : traderName // ignore: cast_nullable_to_non_nullable
as String?,farmerName: freezed == farmerName ? _self.farmerName : farmerName // ignore: cast_nullable_to_non_nullable
as String?,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
