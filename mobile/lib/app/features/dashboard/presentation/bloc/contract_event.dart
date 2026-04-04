import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/contract_entity.dart';

part 'contract_event.freezed.dart';

@freezed
abstract class ContractEvent with _$ContractEvent {
  const factory ContractEvent.createContract(ContractEntity contract) = CreateContract;
}
