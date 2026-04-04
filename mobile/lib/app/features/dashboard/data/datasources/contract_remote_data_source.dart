import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/contract_model.dart';

abstract class IContractRemoteDataSource {
  Future<ContractModel> createContract(ContractModel contract);
  Future<List<ContractModel>> getUserContracts(String userId, String role);
  Future<ContractModel> updateContractStatus(String id, String status);
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

  @override
  Future<List<ContractModel>> getUserContracts(String userId, String role) async {
    try {
      final response = await dio.get(
        '${ApiConstants.contracts}/user/$userId',
        queryParameters: {'role': role},
      );

      if (response.statusCode == 200) {
        final List contractsJson = response.data['contracts'];
        return contractsJson.map((json) => ContractModel.fromJson(json)).toList();
      } else {
        throw Exception(response.data['error'] ?? 'Failed to fetch contracts');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Network error while fetching contracts');
    }
  }

  @override
  Future<ContractModel> updateContractStatus(String id, String status) async {
    try {
      final response = await dio.patch(
        '${ApiConstants.contracts}/$id/status',
        data: {'status': status},
      );

      if (response.statusCode == 200) {
        return ContractModel.fromJson(response.data['contract']);
      } else {
        throw Exception(response.data['error'] ?? 'Failed to update contract status');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Network error while updating status');
    }
  }
}
