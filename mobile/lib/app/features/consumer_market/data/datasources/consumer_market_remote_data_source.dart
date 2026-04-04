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
        throw Exception('Failed to load marketplace');
      }
    } catch (e) {
      throw Exception('Failed to load marketplace: $e');
    }
  }
}
