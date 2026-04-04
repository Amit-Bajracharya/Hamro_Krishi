// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trader_product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TraderProductModel {

 String? get id;@JsonKey(name: 'contract_id') String get contractId;@DoubleConverter()@JsonKey(name: 'quantity_for_sale') double get quantityForSale;@DoubleConverter() double get latitude;@DoubleConverter() double get longitude; String get status;@JsonKey(name: 'created_at') DateTime? get createdAt;// Joined fields from Contract and Product
@JsonKey(name: 'product_name') String? get productName;@DoubleConverter()@JsonKey(name: 'trader_selling_price') double? get price;@JsonKey(name: 'category') String? get category;@JsonKey(name: 'image_url') String? get imageUrl;
/// Create a copy of TraderProductModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TraderProductModelCopyWith<TraderProductModel> get copyWith => _$TraderProductModelCopyWithImpl<TraderProductModel>(this as TraderProductModel, _$identity);

  /// Serializes this TraderProductModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TraderProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.contractId, contractId) || other.contractId == contractId)&&(identical(other.quantityForSale, quantityForSale) || other.quantityForSale == quantityForSale)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.price, price) || other.price == price)&&(identical(other.category, category) || other.category == category)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,contractId,quantityForSale,latitude,longitude,status,createdAt,productName,price,category,imageUrl);

@override
String toString() {
  return 'TraderProductModel(id: $id, contractId: $contractId, quantityForSale: $quantityForSale, latitude: $latitude, longitude: $longitude, status: $status, createdAt: $createdAt, productName: $productName, price: $price, category: $category, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $TraderProductModelCopyWith<$Res>  {
  factory $TraderProductModelCopyWith(TraderProductModel value, $Res Function(TraderProductModel) _then) = _$TraderProductModelCopyWithImpl;
@useResult
$Res call({
 String? id,@JsonKey(name: 'contract_id') String contractId,@DoubleConverter()@JsonKey(name: 'quantity_for_sale') double quantityForSale,@DoubleConverter() double latitude,@DoubleConverter() double longitude, String status,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'product_name') String? productName,@DoubleConverter()@JsonKey(name: 'trader_selling_price') double? price,@JsonKey(name: 'category') String? category,@JsonKey(name: 'image_url') String? imageUrl
});




}
/// @nodoc
class _$TraderProductModelCopyWithImpl<$Res>
    implements $TraderProductModelCopyWith<$Res> {
  _$TraderProductModelCopyWithImpl(this._self, this._then);

  final TraderProductModel _self;
  final $Res Function(TraderProductModel) _then;

/// Create a copy of TraderProductModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? contractId = null,Object? quantityForSale = null,Object? latitude = null,Object? longitude = null,Object? status = null,Object? createdAt = freezed,Object? productName = freezed,Object? price = freezed,Object? category = freezed,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,contractId: null == contractId ? _self.contractId : contractId // ignore: cast_nullable_to_non_nullable
as String,quantityForSale: null == quantityForSale ? _self.quantityForSale : quantityForSale // ignore: cast_nullable_to_non_nullable
as double,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TraderProductModel].
extension TraderProductModelPatterns on TraderProductModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TraderProductModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TraderProductModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TraderProductModel value)  $default,){
final _that = this;
switch (_that) {
case _TraderProductModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TraderProductModel value)?  $default,){
final _that = this;
switch (_that) {
case _TraderProductModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'contract_id')  String contractId, @DoubleConverter()@JsonKey(name: 'quantity_for_sale')  double quantityForSale, @DoubleConverter()  double latitude, @DoubleConverter()  double longitude,  String status, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'product_name')  String? productName, @DoubleConverter()@JsonKey(name: 'trader_selling_price')  double? price, @JsonKey(name: 'category')  String? category, @JsonKey(name: 'image_url')  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TraderProductModel() when $default != null:
return $default(_that.id,_that.contractId,_that.quantityForSale,_that.latitude,_that.longitude,_that.status,_that.createdAt,_that.productName,_that.price,_that.category,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'contract_id')  String contractId, @DoubleConverter()@JsonKey(name: 'quantity_for_sale')  double quantityForSale, @DoubleConverter()  double latitude, @DoubleConverter()  double longitude,  String status, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'product_name')  String? productName, @DoubleConverter()@JsonKey(name: 'trader_selling_price')  double? price, @JsonKey(name: 'category')  String? category, @JsonKey(name: 'image_url')  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _TraderProductModel():
return $default(_that.id,_that.contractId,_that.quantityForSale,_that.latitude,_that.longitude,_that.status,_that.createdAt,_that.productName,_that.price,_that.category,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id, @JsonKey(name: 'contract_id')  String contractId, @DoubleConverter()@JsonKey(name: 'quantity_for_sale')  double quantityForSale, @DoubleConverter()  double latitude, @DoubleConverter()  double longitude,  String status, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'product_name')  String? productName, @DoubleConverter()@JsonKey(name: 'trader_selling_price')  double? price, @JsonKey(name: 'category')  String? category, @JsonKey(name: 'image_url')  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _TraderProductModel() when $default != null:
return $default(_that.id,_that.contractId,_that.quantityForSale,_that.latitude,_that.longitude,_that.status,_that.createdAt,_that.productName,_that.price,_that.category,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TraderProductModel extends TraderProductModel {
  const _TraderProductModel({this.id, @JsonKey(name: 'contract_id') required this.contractId, @DoubleConverter()@JsonKey(name: 'quantity_for_sale') required this.quantityForSale, @DoubleConverter() required this.latitude, @DoubleConverter() required this.longitude, this.status = 'available', @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'product_name') this.productName, @DoubleConverter()@JsonKey(name: 'trader_selling_price') this.price, @JsonKey(name: 'category') this.category, @JsonKey(name: 'image_url') this.imageUrl}): super._();
  factory _TraderProductModel.fromJson(Map<String, dynamic> json) => _$TraderProductModelFromJson(json);

@override final  String? id;
@override@JsonKey(name: 'contract_id') final  String contractId;
@override@DoubleConverter()@JsonKey(name: 'quantity_for_sale') final  double quantityForSale;
@override@DoubleConverter() final  double latitude;
@override@DoubleConverter() final  double longitude;
@override@JsonKey() final  String status;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
// Joined fields from Contract and Product
@override@JsonKey(name: 'product_name') final  String? productName;
@override@DoubleConverter()@JsonKey(name: 'trader_selling_price') final  double? price;
@override@JsonKey(name: 'category') final  String? category;
@override@JsonKey(name: 'image_url') final  String? imageUrl;

/// Create a copy of TraderProductModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TraderProductModelCopyWith<_TraderProductModel> get copyWith => __$TraderProductModelCopyWithImpl<_TraderProductModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TraderProductModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TraderProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.contractId, contractId) || other.contractId == contractId)&&(identical(other.quantityForSale, quantityForSale) || other.quantityForSale == quantityForSale)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.price, price) || other.price == price)&&(identical(other.category, category) || other.category == category)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,contractId,quantityForSale,latitude,longitude,status,createdAt,productName,price,category,imageUrl);

@override
String toString() {
  return 'TraderProductModel(id: $id, contractId: $contractId, quantityForSale: $quantityForSale, latitude: $latitude, longitude: $longitude, status: $status, createdAt: $createdAt, productName: $productName, price: $price, category: $category, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$TraderProductModelCopyWith<$Res> implements $TraderProductModelCopyWith<$Res> {
  factory _$TraderProductModelCopyWith(_TraderProductModel value, $Res Function(_TraderProductModel) _then) = __$TraderProductModelCopyWithImpl;
@override @useResult
$Res call({
 String? id,@JsonKey(name: 'contract_id') String contractId,@DoubleConverter()@JsonKey(name: 'quantity_for_sale') double quantityForSale,@DoubleConverter() double latitude,@DoubleConverter() double longitude, String status,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'product_name') String? productName,@DoubleConverter()@JsonKey(name: 'trader_selling_price') double? price,@JsonKey(name: 'category') String? category,@JsonKey(name: 'image_url') String? imageUrl
});




}
/// @nodoc
class __$TraderProductModelCopyWithImpl<$Res>
    implements _$TraderProductModelCopyWith<$Res> {
  __$TraderProductModelCopyWithImpl(this._self, this._then);

  final _TraderProductModel _self;
  final $Res Function(_TraderProductModel) _then;

/// Create a copy of TraderProductModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? contractId = null,Object? quantityForSale = null,Object? latitude = null,Object? longitude = null,Object? status = null,Object? createdAt = freezed,Object? productName = freezed,Object? price = freezed,Object? category = freezed,Object? imageUrl = freezed,}) {
  return _then(_TraderProductModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,contractId: null == contractId ? _self.contractId : contractId // ignore: cast_nullable_to_non_nullable
as String,quantityForSale: null == quantityForSale ? _self.quantityForSale : quantityForSale // ignore: cast_nullable_to_non_nullable
as double,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
