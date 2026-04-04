import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_contract_use_case.dart';
import '../../domain/usecases/get_user_contracts_use_case.dart';
import '../../domain/usecases/update_contract_status_use_case.dart';
import 'contract_event.dart';
import 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  final CreateContractUseCase createContractUseCase;
  final GetUserContractsUseCase getUserContractsUseCase;
  final UpdateContractStatusUseCase updateContractStatusUseCase;

  ContractBloc({
    required this.createContractUseCase,
    required this.getUserContractsUseCase,
    required this.updateContractStatusUseCase,
  }) : super(const ContractInitial()) {
    on<CreateContract>(_onCreateContract);
    on<FetchUserContracts>(_onFetchUserContracts);
    on<UpdateContractStatus>(_onUpdateContractStatus);
  }

  Future<void> _onUpdateContractStatus(
    UpdateContractStatus event,
    Emitter<ContractState> emit,
  ) async {
    emit(const ContractSubmitting());
    
    final result = await updateContractStatusUseCase(event.id, event.status);
    
    result.fold(
      (failure) => emit(ContractFailure(failure.message)),
      (contract) => emit(ContractSuccess(contract)),
    );
  }

  Future<void> _onFetchUserContracts(
    FetchUserContracts event,
    Emitter<ContractState> emit,
  ) async {
    emit(const ContractLoading());
    
    final result = await getUserContractsUseCase(event.userId, event.role);
    
    result.fold(
      (failure) => emit(ContractFailure(failure.message)),
      (contracts) => emit(ContractState.contractsLoaded(contracts)),
    );
  }

  Future<void> _onCreateContract(
    CreateContract event,
    Emitter<ContractState> emit,
  ) async {
    emit(const ContractSubmitting());
    
    final result = await createContractUseCase(event.contract);
    
    result.fold(
      (failure) => emit(ContractFailure(failure.message)),
      (contract) => emit(ContractSuccess(contract)),
    );
  }
}
