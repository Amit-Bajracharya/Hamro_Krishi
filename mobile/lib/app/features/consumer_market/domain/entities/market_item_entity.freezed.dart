// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_item_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MarketItemEntity {

@JsonKey(name: 'contract_id') String get contractId;@JsonKey(name: 'product_id') String? get productId;@JsonKey(name: 'farmer_id') String? get farmerId;@JsonKey(name: 'middleman_id') String? get middlemanId;@JsonKey(name: 'product_name') String get productName; String get category; double get quantity;@JsonKey(name: 'farmer_selling_price') double get farmerSellingPrice;@JsonKey(name: 'trader_selling_price') double get traderSellingPrice; String get status;@JsonKey(name: 'farmer_name') String get farmerName;@JsonKey(name: 'trader_name') String get traderName;@JsonKey(name: 'image_url') String? get imageUrl;@JsonKey(name: 'expiry_date') DateTime? get expiryDate;@JsonKey(name: 'farmer_latitude') double? get farmerLatitude;@JsonKey(name: 'farmer_longitude') double? get farmerLongitude;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of MarketItemEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketItemEntityCopyWith<MarketItemEntity> get copyWith => _$MarketItemEntityCopyWithImpl<MarketItemEntity>(this as MarketItemEntity, _$identity);

  /// Serializes this MarketItemEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketItemEntity&&(identical(other.contractId, contractId) || other.contractId == contractId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.farmerId, farmerId) || other.farmerId == farmerId)&&(identical(other.middlemanId, middlemanId) || other.middlemanId == middlemanId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.category, category) || other.category == category)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.farmerSellingPrice, farmerSellingPrice) || other.farmerSellingPrice == farmerSellingPrice)&&(identical(other.traderSellingPrice, traderSellingPrice) || other.traderSellingPrice == traderSellingPrice)&&(identical(other.status, status) || other.status == status)&&(identical(other.farmerName, farmerName) || other.farmerName == farmerName)&&(identical(other.traderName, traderName) || other.traderName == traderName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.farmerLatitude, farmerLatitude) || other.farmerLatitude == farmerLatitude)&&(identical(other.farmerLongitude, farmerLongitude) || other.farmerLongitude == farmerLongitude)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contractId,productId,farmerId,middlemanId,productName,category,quantity,farmerSellingPrice,traderSellingPrice,status,farmerName,traderName,imageUrl,expiryDate,farmerLatitude,farmerLongitude,createdAt);

@override
String toString() {
  return 'MarketItemEntity(contractId: $contractId, productId: $productId, farmerId: $farmerId, middlemanId: $middlemanId, productName: $productName, category: $category, quantity: $quantity, farmerSellingPrice: $farmerSellingPrice, traderSellingPrice: $traderSellingPrice, status: $status, farmerName: $farmerName, traderName: $traderName, imageUrl: $imageUrl, expiryDate: $expiryDate, farmerLatitude: $farmerLatitude, farmerLongitude: $farmerLongitude, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MarketItemEntityCopyWith<$Res>  {
  factory $MarketItemEntityCopyWith(MarketItemEntity value, $Res Function(MarketItemEntity) _then) = _$MarketItemEntityCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'contract_id') String contractId,@JsonKey(name: 'product_id') String? productId,@JsonKey(name: 'farmer_id') String? farmerId,@JsonKey(name: 'middleman_id') String? middlemanId,@JsonKey(name: 'product_name') String productName, String category, double quantity,@JsonKey(name: 'farmer_selling_price') double farmerSellingPrice,@JsonKey(name: 'trader_selling_price') double traderSellingPrice, String status,@JsonKey(name: 'farmer_name') String farmerName,@JsonKey(name: 'trader_name') String traderName,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'expiry_date') DateTime? expiryDate,@JsonKey(name: 'farmer_latitude') double? farmerLatitude,@JsonKey(name: 'farmer_longitude') double? farmerLongitude,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$MarketItemEntityCopyWithImpl<$Res>
    implements $MarketItemEntityCopyWith<$Res> {
  _$MarketItemEntityCopyWithImpl(this._self, this._then);

  final MarketItemEntity _self;
  final $Res Function(MarketItemEntity) _then;

/// Create a copy of MarketItemEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contractId = null,Object? productId = freezed,Object? farmerId = freezed,Object? middlemanId = freezed,Object? productName = null,Object? category = null,Object? quantity = null,Object? farmerSellingPrice = null,Object? traderSellingPrice = null,Object? status = null,Object? farmerName = null,Object? traderName = null,Object? imageUrl = freezed,Object? expiryDate = freezed,Object? farmerLatitude = freezed,Object? farmerLongitude = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
contractId: null == contractId ? _self.contractId : contractId // ignore: cast_nullable_to_non_nullable
as String,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,farmerId: freezed == farmerId ? _self.farmerId : farmerId // ignore: cast_nullable_to_non_nullable
as String?,middlemanId: freezed == middlemanId ? _self.middlemanId : middlemanId // ignore: cast_nullable_to_non_nullable
as String?,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,farmerSellingPrice: null == farmerSellingPrice ? _self.farmerSellingPrice : farmerSellingPrice // ignore: cast_nullable_to_non_nullable
as double,traderSellingPrice: null == traderSellingPrice ? _self.traderSellingPrice : traderSellingPrice // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,farmerName: null == farmerName ? _self.farmerName : farmerName // ignore: cast_nullable_to_non_nullable
as String,traderName: null == traderName ? _self.traderName : traderName // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,farmerLatitude: freezed == farmerLatitude ? _self.farmerLatitude : farmerLatitude // ignore: cast_nullable_to_non_nullable
as double?,farmerLongitude: freezed == farmerLongitude ? _self.farmerLongitude : farmerLongitude // ignore: cast_nullable_to_non_nullable
as double?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MarketItemEntity].
extension MarketItemEntityPatterns on MarketItemEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarketItemEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarketItemEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarketItemEntity value)  $default,){
final _that = this;
switch (_that) {
case _MarketItemEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarketItemEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MarketItemEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'contract_id')  String contractId, @JsonKey(name: 'product_id')  String? productId, @JsonKey(name: 'farmer_id')  String? farmerId, @JsonKey(name: 'middleman_id')  String? middlemanId, @JsonKey(name: 'product_name')  String productName,  String category,  double quantity, @JsonKey(name: 'farmer_selling_price')  double farmerSellingPrice, @JsonKey(name: 'trader_selling_price')  double traderSellingPrice,  String status, @JsonKey(name: 'farmer_name')  String farmerName, @JsonKey(name: 'trader_name')  String traderName, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'expiry_date')  DateTime? expiryDate, @JsonKey(name: 'farmer_latitude')  double? farmerLatitude, @JsonKey(name: 'farmer_longitude')  double? farmerLongitude, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarketItemEntity() when $default != null:
return $default(_that.contractId,_that.productId,_that.farmerId,_that.middlemanId,_that.productName,_that.category,_that.quantity,_that.farmerSellingPrice,_that.traderSellingPrice,_that.status,_that.farmerName,_that.traderName,_that.imageUrl,_that.expiryDate,_that.farmerLatitude,_that.farmerLongitude,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'contract_id')  String contractId, @JsonKey(name: 'product_id')  String? productId, @JsonKey(name: 'farmer_id')  String? farmerId, @JsonKey(name: 'middleman_id')  String? middlemanId, @JsonKey(name: 'product_name')  String productName,  String category,  double quantity, @JsonKey(name: 'farmer_selling_price')  double farmerSellingPrice, @JsonKey(name: 'trader_selling_price')  double traderSellingPrice,  String status, @JsonKey(name: 'farmer_name')  String farmerName, @JsonKey(name: 'trader_name')  String traderName, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'expiry_date')  DateTime? expiryDate, @JsonKey(name: 'farmer_latitude')  double? farmerLatitude, @JsonKey(name: 'farmer_longitude')  double? farmerLongitude, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _MarketItemEntity():
return $default(_that.contractId,_that.productId,_that.farmerId,_that.middlemanId,_that.productName,_that.category,_that.quantity,_that.farmerSellingPrice,_that.traderSellingPrice,_that.status,_that.farmerName,_that.traderName,_that.imageUrl,_that.expiryDate,_that.farmerLatitude,_that.farmerLongitude,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'contract_id')  String contractId, @JsonKey(name: 'product_id')  String? productId, @JsonKey(name: 'farmer_id')  String? farmerId, @JsonKey(name: 'middleman_id')  String? middlemanId, @JsonKey(name: 'product_name')  String productName,  String category,  double quantity, @JsonKey(name: 'farmer_selling_price')  double farmerSellingPrice, @JsonKey(name: 'trader_selling_price')  double traderSellingPrice,  String status, @JsonKey(name: 'farmer_name')  String farmerName, @JsonKey(name: 'trader_name')  String traderName, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'expiry_date')  DateTime? expiryDate, @JsonKey(name: 'farmer_latitude')  double? farmerLatitude, @JsonKey(name: 'farmer_longitude')  double? farmerLongitude, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MarketItemEntity() when $default != null:
return $default(_that.contractId,_that.productId,_that.farmerId,_that.middlemanId,_that.productName,_that.category,_that.quantity,_that.farmerSellingPrice,_that.traderSellingPrice,_that.status,_that.farmerName,_that.traderName,_that.imageUrl,_that.expiryDate,_that.farmerLatitude,_that.farmerLongitude,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarketItemEntity implements MarketItemEntity {
  const _MarketItemEntity({@JsonKey(name: 'contract_id') required this.contractId, @JsonKey(name: 'product_id') this.productId, @JsonKey(name: 'farmer_id') this.farmerId, @JsonKey(name: 'middleman_id') this.middlemanId, @JsonKey(name: 'product_name') required this.productName, required this.category, required this.quantity, @JsonKey(name: 'farmer_selling_price') required this.farmerSellingPrice, @JsonKey(name: 'trader_selling_price') required this.traderSellingPrice, required this.status, @JsonKey(name: 'farmer_name') required this.farmerName, @JsonKey(name: 'trader_name') required this.traderName, @JsonKey(name: 'image_url') this.imageUrl, @JsonKey(name: 'expiry_date') this.expiryDate, @JsonKey(name: 'farmer_latitude') this.farmerLatitude, @JsonKey(name: 'farmer_longitude') this.farmerLongitude, @JsonKey(name: 'created_at') this.createdAt});
  factory _MarketItemEntity.fromJson(Map<String, dynamic> json) => _$MarketItemEntityFromJson(json);

@override@JsonKey(name: 'contract_id') final  String contractId;
@override@JsonKey(name: 'product_id') final  String? productId;
@override@JsonKey(name: 'farmer_id') final  String? farmerId;
@override@JsonKey(name: 'middleman_id') final  String? middlemanId;
@override@JsonKey(name: 'product_name') final  String productName;
@override final  String category;
@override final  double quantity;
@override@JsonKey(name: 'farmer_selling_price') final  double farmerSellingPrice;
@override@JsonKey(name: 'trader_selling_price') final  double traderSellingPrice;
@override final  String status;
@override@JsonKey(name: 'farmer_name') final  String farmerName;
@override@JsonKey(name: 'trader_name') final  String traderName;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
@override@JsonKey(name: 'expiry_date') final  DateTime? expiryDate;
@override@JsonKey(name: 'farmer_latitude') final  double? farmerLatitude;
@override@JsonKey(name: 'farmer_longitude') final  double? farmerLongitude;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of MarketItemEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarketItemEntityCopyWith<_MarketItemEntity> get copyWith => __$MarketItemEntityCopyWithImpl<_MarketItemEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarketItemEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarketItemEntity&&(identical(other.contractId, contractId) || other.contractId == contractId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.farmerId, farmerId) || other.farmerId == farmerId)&&(identical(other.middlemanId, middlemanId) || other.middlemanId == middlemanId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.category, category) || other.category == category)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.farmerSellingPrice, farmerSellingPrice) || other.farmerSellingPrice == farmerSellingPrice)&&(identical(other.traderSellingPrice, traderSellingPrice) || other.traderSellingPrice == traderSellingPrice)&&(identical(other.status, status) || other.status == status)&&(identical(other.farmerName, farmerName) || other.farmerName == farmerName)&&(identical(other.traderName, traderName) || other.traderName == traderName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.farmerLatitude, farmerLatitude) || other.farmerLatitude == farmerLatitude)&&(identical(other.farmerLongitude, farmerLongitude) || other.farmerLongitude == farmerLongitude)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contractId,productId,farmerId,middlemanId,productName,category,quantity,farmerSellingPrice,traderSellingPrice,status,farmerName,traderName,imageUrl,expiryDate,farmerLatitude,farmerLongitude,createdAt);

@override
String toString() {
  return 'MarketItemEntity(contractId: $contractId, productId: $productId, farmerId: $farmerId, middlemanId: $middlemanId, productName: $productName, category: $category, quantity: $quantity, farmerSellingPrice: $farmerSellingPrice, traderSellingPrice: $traderSellingPrice, status: $status, farmerName: $farmerName, traderName: $traderName, imageUrl: $imageUrl, expiryDate: $expiryDate, farmerLatitude: $farmerLatitude, farmerLongitude: $farmerLongitude, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MarketItemEntityCopyWith<$Res> implements $MarketItemEntityCopyWith<$Res> {
  factory _$MarketItemEntityCopyWith(_MarketItemEntity value, $Res Function(_MarketItemEntity) _then) = __$MarketItemEntityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'contract_id') String contractId,@JsonKey(name: 'product_id') String? productId,@JsonKey(name: 'farmer_id') String? farmerId,@JsonKey(name: 'middleman_id') String? middlemanId,@JsonKey(name: 'product_name') String productName, String category, double quantity,@JsonKey(name: 'farmer_selling_price') double farmerSellingPrice,@JsonKey(name: 'trader_selling_price') double traderSellingPrice, String status,@JsonKey(name: 'farmer_name') String farmerName,@JsonKey(name: 'trader_name') String traderName,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'expiry_date') DateTime? expiryDate,@JsonKey(name: 'farmer_latitude') double? farmerLatitude,@JsonKey(name: 'farmer_longitude') double? farmerLongitude,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$MarketItemEntityCopyWithImpl<$Res>
    implements _$MarketItemEntityCopyWith<$Res> {
  __$MarketItemEntityCopyWithImpl(this._self, this._then);

  final _MarketItemEntity _self;
  final $Res Function(_MarketItemEntity) _then;

/// Create a copy of MarketItemEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contractId = null,Object? productId = freezed,Object? farmerId = freezed,Object? middlemanId = freezed,Object? productName = null,Object? category = null,Object? quantity = null,Object? farmerSellingPrice = null,Object? traderSellingPrice = null,Object? status = null,Object? farmerName = null,Object? traderName = null,Object? imageUrl = freezed,Object? expiryDate = freezed,Object? farmerLatitude = freezed,Object? farmerLongitude = freezed,Object? createdAt = freezed,}) {
  return _then(_MarketItemEntity(
contractId: null == contractId ? _self.contractId : contractId // ignore: cast_nullable_to_non_nullable
as String,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,farmerId: freezed == farmerId ? _self.farmerId : farmerId // ignore: cast_nullable_to_non_nullable
as String?,middlemanId: freezed == middlemanId ? _self.middlemanId : middlemanId // ignore: cast_nullable_to_non_nullable
as String?,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,farmerSellingPrice: null == farmerSellingPrice ? _self.farmerSellingPrice : farmerSellingPrice // ignore: cast_nullable_to_non_nullable
as double,traderSellingPrice: null == traderSellingPrice ? _self.traderSellingPrice : traderSellingPrice // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,farmerName: null == farmerName ? _self.farmerName : farmerName // ignore: cast_nullable_to_non_nullable
as String,traderName: null == traderName ? _self.traderName : traderName // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,farmerLatitude: freezed == farmerLatitude ? _self.farmerLatitude : farmerLatitude // ignore: cast_nullable_to_non_nullable
as double?,farmerLongitude: freezed == farmerLongitude ? _self.farmerLongitude : farmerLongitude // ignore: cast_nullable_to_non_nullable
as double?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
