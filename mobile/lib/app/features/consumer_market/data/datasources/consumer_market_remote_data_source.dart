import 'package:dio/dio.dart';
import 'package:hamrokrishi_app/app/features/consumer_market/domain/entities/market_item_entity.dart';

abstract class IConsumerMarketRemoteDataSource {
  Future<List<MarketItemEntity>> getConsumerMarketplace();
}

class ConsumerMarketRemoteDataSourceImpl implements IConsumerMarketRemoteDataSource {
  final Dio dio;

  ConsumerMarketRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MarketItemEntity>> getConsumerMarketplace() async {
    try {
      final response = await dio.get('/customers/marketplace');
      
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => MarketItemEntity.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load marketplace - Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw Exception('Connection error. Check BASE_URL in api_constants.dart');
      }
      throw Exception('Failed to load marketplace: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load marketplace: $e');
    }
  }
}
