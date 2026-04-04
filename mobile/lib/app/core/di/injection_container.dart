import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hamrokrishi_app/app/core/constants/api_constants.dart';
import 'package:hamrokrishi_app/app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:hamrokrishi_app/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/usecases/login_use_case.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/usecases/register_farmer_use_case.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_farmer_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Auth
  
  // Bloc
  sl.registerFactory(() => LoginBloc(loginUseCase: sl()));
  sl.registerFactory(() => RegisterFarmerBloc(registerFarmerUseCase: sl()));
  
  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterFarmerUseCase(sl()));
  
  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );
  
  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  // Core
  sl.registerLazySingleton(() => Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  ));
}
