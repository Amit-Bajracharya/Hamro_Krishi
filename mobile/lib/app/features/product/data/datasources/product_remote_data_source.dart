import 'dart:io';
import 'package:dio/dio.dart';
import 'package:hamrokrishi_app/app/core/constants/api_constants.dart';
import 'package:hamrokrishi_app/app/features/product/data/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class IProductRemoteDataSource {
  Future<String?> uploadImage(File file);
  Future<void> addProduct(ProductModel product);
  Future<List<ProductModel>> getFarmerProducts(String farmerId);
}

class ProductRemoteDataSourceImpl implements IProductRemoteDataSource {
  final Dio dio;
  final SupabaseClient supabaseClient;

  ProductRemoteDataSourceImpl({required this.dio, required this.supabaseClient});

  @override
  Future<String?> uploadImage(File file) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final path = 'product_images/$fileName';

      await supabaseClient.storage.from('Product').upload(
            path,
            file,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      final imageUrl = supabaseClient.storage.from('Product').getPublicUrl(path);
      return imageUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  @override
  Future<void> addProduct(ProductModel product) async {
    try {
      final response = await dio.post(
        ApiConstants.products,
        data: product.toJson(),
      );

      if (response.statusCode != 201) {
        throw Exception(response.data['error'] ?? 'Failed to add product');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Network error while adding product');
    }
  }

  @override
  Future<List<ProductModel>> getFarmerProducts(String farmerId) async {
    try {
      final response = await dio.get('${ApiConstants.products}/farmer/$farmerId');

      if (response.statusCode == 200) {
        final List data = response.data['data'];
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch products');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Network error while fetching products');
    }
  }
}
