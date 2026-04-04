import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/contract_model.dart';

abstract class IContractRemoteDataSource {
  Future<ContractModel> createContract(ContractModel contract);
}

class ContractRemoteDataSourceImpl implements IContractRemoteDataSource {
  final Dio dio;

  ContractRemoteDataSourceImpl({required this.dio});

  @override
  Future<ContractModel> createContract(ContractModel contract) async {
    try {
      final response = await dio.post(
        ApiConstants.contracts,
        data: contract.toJson(),
      );

      if (response.statusCode == 201) {
        return ContractModel.fromJson(response.data['contract']);
      } else {
        throw Exception(response.data['error'] ?? 'Failed to create contract');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Network error while creating contract');
    }
  }
}
