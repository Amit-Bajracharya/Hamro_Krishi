import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hamrokrishi_app/app/core/constants/api_constants.dart';
import 'package:hamrokrishi_app/app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:hamrokrishi_app/app/core/services/location_service.dart';
import 'package:hamrokrishi_app/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/usecases/login_use_case.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/usecases/register_farmer_use_case.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/usecases/register_trader_use_case.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/usecases/register_consumer_use_case.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_farmer_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_trader_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_consumer_bloc.dart';
import 'package:hamrokrishi_app/app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:hamrokrishi_app/app/features/product/data/repositories/product_repository_impl.dart';
import 'package:hamrokrishi_app/app/features/product/domain/repositories/product_repository.dart';
import 'package:hamrokrishi_app/app/features/product/domain/usecases/add_product_use_case.dart';
import 'package:hamrokrishi_app/app/features/product/presentation/bloc/product_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Auth
  
  // Bloc
  sl.registerLazySingleton(() => LoginBloc(loginUseCase: sl()));
  sl.registerFactory(() => RegisterFarmerBloc(registerFarmerUseCase: sl(), locationService: sl()));
  sl.registerFactory(() => RegisterTraderBloc(registerTraderUseCase: sl(), locationService: sl()));
  sl.registerFactory(() => RegisterConsumerBloc(registerConsumerUseCase: sl(), locationService: sl()));
  
  // Features - Product
  sl.registerFactory(() => ProductBloc(addProductUseCase: sl()));
  
  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterFarmerUseCase(sl()));
  sl.registerLazySingleton(() => RegisterTraderUseCase(sl()));
  sl.registerLazySingleton(() => RegisterConsumerUseCase(sl()));
  
  sl.registerLazySingleton(() => AddProductUseCase(sl()));
  
  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<IProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl()),
  );
  
  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<IProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(dio: sl(), supabaseClient: sl()),
  );

  // Core
  sl.registerLazySingleton(() => LocationService());
  sl.registerLazySingleton(() => Dio(
    BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  ));

  sl.registerLazySingleton(() => Supabase.instance.client);
}
