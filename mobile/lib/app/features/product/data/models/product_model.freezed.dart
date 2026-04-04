// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductModel {

 String? get id; String get name; String get category;@JsonKey(name: 'harvest_date') DateTime? get harvestDate;@JsonKey(name: 'expiry_date') DateTime get expiryDate;@DoubleConverter() double get price;@DoubleConverter() double get quantity;@JsonKey(name: 'farmer_id') String? get farmerId;@DoubleConverter() double get latitude;@DoubleConverter() double get longitude;@JsonKey(name: 'image_url') String? get imageUrl;@JsonKey(name: 'farmer_name') String? get farmerName;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductModelCopyWith<ProductModel> get copyWith => _$ProductModelCopyWithImpl<ProductModel>(this as ProductModel, _$identity);

  /// Serializes this ProductModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.harvestDate, harvestDate) || other.harvestDate == harvestDate)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.price, price) || other.price == price)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.farmerId, farmerId) || other.farmerId == farmerId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.farmerName, farmerName) || other.farmerName == farmerName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category,harvestDate,expiryDate,price,quantity,farmerId,latitude,longitude,imageUrl,farmerName,createdAt);

@override
String toString() {
  return 'ProductModel(id: $id, name: $name, category: $category, harvestDate: $harvestDate, expiryDate: $expiryDate, price: $price, quantity: $quantity, farmerId: $farmerId, latitude: $latitude, longitude: $longitude, imageUrl: $imageUrl, farmerName: $farmerName, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ProductModelCopyWith<$Res>  {
  factory $ProductModelCopyWith(ProductModel value, $Res Function(ProductModel) _then) = _$ProductModelCopyWithImpl;
@useResult
$Res call({
 String? id, String name, String category,@JsonKey(name: 'harvest_date') DateTime? harvestDate,@JsonKey(name: 'expiry_date') DateTime expiryDate,@DoubleConverter() double price,@DoubleConverter() double quantity,@JsonKey(name: 'farmer_id') String? farmerId,@DoubleConverter() double latitude,@DoubleConverter() double longitude,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'farmer_name') String? farmerName,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$ProductModelCopyWithImpl<$Res>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._self, this._then);

  final ProductModel _self;
  final $Res Function(ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? category = null,Object? harvestDate = freezed,Object? expiryDate = null,Object? price = null,Object? quantity = null,Object? farmerId = freezed,Object? latitude = null,Object? longitude = null,Object? imageUrl = freezed,Object? farmerName = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,harvestDate: freezed == harvestDate ? _self.harvestDate : harvestDate // ignore: cast_nullable_to_non_nullable
as DateTime?,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,farmerId: freezed == farmerId ? _self.farmerId : farmerId // ignore: cast_nullable_to_non_nullable
as String?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,farmerName: freezed == farmerName ? _self.farmerName : farmerName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductModel].
extension ProductModelPatterns on ProductModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String name,  String category, @JsonKey(name: 'harvest_date')  DateTime? harvestDate, @JsonKey(name: 'expiry_date')  DateTime expiryDate, @DoubleConverter()  double price, @DoubleConverter()  double quantity, @JsonKey(name: 'farmer_id')  String? farmerId, @DoubleConverter()  double latitude, @DoubleConverter()  double longitude, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'farmer_name')  String? farmerName, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.harvestDate,_that.expiryDate,_that.price,_that.quantity,_that.farmerId,_that.latitude,_that.longitude,_that.imageUrl,_that.farmerName,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String name,  String category, @JsonKey(name: 'harvest_date')  DateTime? harvestDate, @JsonKey(name: 'expiry_date')  DateTime expiryDate, @DoubleConverter()  double price, @DoubleConverter()  double quantity, @JsonKey(name: 'farmer_id')  String? farmerId, @DoubleConverter()  double latitude, @DoubleConverter()  double longitude, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'farmer_name')  String? farmerName, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ProductModel():
return $default(_that.id,_that.name,_that.category,_that.harvestDate,_that.expiryDate,_that.price,_that.quantity,_that.farmerId,_that.latitude,_that.longitude,_that.imageUrl,_that.farmerName,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String name,  String category, @JsonKey(name: 'harvest_date')  DateTime? harvestDate, @JsonKey(name: 'expiry_date')  DateTime expiryDate, @DoubleConverter()  double price, @DoubleConverter()  double quantity, @JsonKey(name: 'farmer_id')  String? farmerId, @DoubleConverter()  double latitude, @DoubleConverter()  double longitude, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'farmer_name')  String? farmerName, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.harvestDate,_that.expiryDate,_that.price,_that.quantity,_that.farmerId,_that.latitude,_that.longitude,_that.imageUrl,_that.farmerName,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductModel extends ProductModel {
  const _ProductModel({this.id, required this.name, required this.category, @JsonKey(name: 'harvest_date') this.harvestDate, @JsonKey(name: 'expiry_date') required this.expiryDate, @DoubleConverter() required this.price, @DoubleConverter() required this.quantity, @JsonKey(name: 'farmer_id') this.farmerId, @DoubleConverter() required this.latitude, @DoubleConverter() required this.longitude, @JsonKey(name: 'image_url') this.imageUrl, @JsonKey(name: 'farmer_name') this.farmerName, @JsonKey(name: 'created_at') this.createdAt}): super._();
  factory _ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

@override final  String? id;
@override final  String name;
@override final  String category;
@override@JsonKey(name: 'harvest_date') final  DateTime? harvestDate;
@override@JsonKey(name: 'expiry_date') final  DateTime expiryDate;
@override@DoubleConverter() final  double price;
@override@DoubleConverter() final  double quantity;
@override@JsonKey(name: 'farmer_id') final  String? farmerId;
@override@DoubleConverter() final  double latitude;
@override@DoubleConverter() final  double longitude;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
@override@JsonKey(name: 'farmer_name') final  String? farmerName;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductModelCopyWith<_ProductModel> get copyWith => __$ProductModelCopyWithImpl<_ProductModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.harvestDate, harvestDate) || other.harvestDate == harvestDate)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.price, price) || other.price == price)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.farmerId, farmerId) || other.farmerId == farmerId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.farmerName, farmerName) || other.farmerName == farmerName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category,harvestDate,expiryDate,price,quantity,farmerId,latitude,longitude,imageUrl,farmerName,createdAt);

@override
String toString() {
  return 'ProductModel(id: $id, name: $name, category: $category, harvestDate: $harvestDate, expiryDate: $expiryDate, price: $price, quantity: $quantity, farmerId: $farmerId, latitude: $latitude, longitude: $longitude, imageUrl: $imageUrl, farmerName: $farmerName, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ProductModelCopyWith<$Res> implements $ProductModelCopyWith<$Res> {
  factory _$ProductModelCopyWith(_ProductModel value, $Res Function(_ProductModel) _then) = __$ProductModelCopyWithImpl;
@override @useResult
$Res call({
 String? id, String name, String category,@JsonKey(name: 'harvest_date') DateTime? harvestDate,@JsonKey(name: 'expiry_date') DateTime expiryDate,@DoubleConverter() double price,@DoubleConverter() double quantity,@JsonKey(name: 'farmer_id') String? farmerId,@DoubleConverter() double latitude,@DoubleConverter() double longitude,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'farmer_name') String? farmerName,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$ProductModelCopyWithImpl<$Res>
    implements _$ProductModelCopyWith<$Res> {
  __$ProductModelCopyWithImpl(this._self, this._then);

  final _ProductModel _self;
  final $Res Function(_ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? category = null,Object? harvestDate = freezed,Object? expiryDate = null,Object? price = null,Object? quantity = null,Object? farmerId = freezed,Object? latitude = null,Object? longitude = null,Object? imageUrl = freezed,Object? farmerName = freezed,Object? createdAt = freezed,}) {
  return _then(_ProductModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,harvestDate: freezed == harvestDate ? _self.harvestDate : harvestDate // ignore: cast_nullable_to_non_nullable
as DateTime?,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,farmerId: freezed == farmerId ? _self.farmerId : farmerId // ignore: cast_nullable_to_non_nullable
as String?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,farmerName: freezed == farmerName ? _self.farmerName : farmerName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
