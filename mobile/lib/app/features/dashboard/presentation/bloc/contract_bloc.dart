import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_contract_use_case.dart';
import 'contract_event.dart';
import 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  final CreateContractUseCase createContractUseCase;

  ContractBloc({required this.createContractUseCase}) : super(const ContractInitial()) {
    on<CreateContract>(_onCreateContract);
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
