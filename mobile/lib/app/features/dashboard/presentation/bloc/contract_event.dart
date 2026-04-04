import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/contract_entity.dart';

part 'contract_event.freezed.dart';

@freezed
abstract class ContractEvent with _$ContractEvent {
  const factory ContractEvent.createContract(ContractEntity contract) = CreateContract;
  const factory ContractEvent.fetchUserContracts({
    required String userId,
    required String role,
  }) = FetchUserContracts;

  const factory ContractEvent.updateContractStatus({
    required String id,
    required String status,
  }) = UpdateContractStatus;
}
