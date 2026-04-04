import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/contract_entity.dart';

part 'contract_state.freezed.dart';

@freezed
class ContractState with _$ContractState {
  const factory ContractState.initial() = ContractInitial;
  const factory ContractState.submitting() = ContractSubmitting;
  const factory ContractState.success(ContractEntity contract) = ContractSuccess;
  const factory ContractState.failure(String message) = ContractFailure;
}
