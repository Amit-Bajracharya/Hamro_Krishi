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
import 'package:hamrokrishi_app/app/features/product/domain/usecases/get_farmer_products_use_case.dart';
import 'package:hamrokrishi_app/app/features/product/presentation/bloc/product_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/data/datasources/weather_remote_data_source.dart';
import 'package:hamrokrishi_app/app/features/dashboard/data/repositories/weather_repository_impl.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/repositories/weather_repository.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/usecases/get_weather_use_case.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/weather_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/data/datasources/prediction_remote_data_source.dart';
import 'package:hamrokrishi_app/app/features/dashboard/data/repositories/prediction_repository_impl.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/repositories/prediction_repository.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/usecases/get_prediction_use_case.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/prediction_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/data/datasources/farmer_remote_data_source.dart';
import 'package:hamrokrishi_app/app/features/dashboard/data/repositories/farmer_repository_impl.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/repositories/farmer_repository.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/trader_dashboard_bloc.dart';
import 'package:hamrokrishi_app/app/features/market/presentation/bloc/trader_market_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/data/datasources/contract_remote_data_source.dart';
import 'package:hamrokrishi_app/app/features/dashboard/data/repositories/contract_repository_impl.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/repositories/contract_repository.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/usecases/create_contract_use_case.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/usecases/get_user_contracts_use_case.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/usecases/update_contract_status_use_case.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/contract_bloc.dart';
import 'package:hamrokrishi_app/app/features/trader/data/datasources/trader_product_remote_data_source.dart';
import 'package:hamrokrishi_app/app/features/trader/data/repositories/trader_product_repository_impl.dart';
import 'package:hamrokrishi_app/app/features/trader/domain/usecases/add_trader_product_use_case.dart';
import 'package:hamrokrishi_app/app/features/trader/domain/usecases/get_trader_products_use_case.dart';
import 'package:hamrokrishi_app/app/features/trader/presentation/bloc/trader_product_bloc.dart';
import 'package:hamrokrishi_app/app/features/consumer_market/data/datasources/consumer_market_remote_data_source.dart';
import 'package:hamrokrishi_app/app/features/consumer_market/presentation/bloc/consumer_market_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Auth
  
  // Bloc
  sl.registerLazySingleton(() => LoginBloc(loginUseCase: sl()));
  sl.registerFactory(() => RegisterFarmerBloc(registerFarmerUseCase: sl(), locationService: sl()));
  sl.registerFactory(() => RegisterTraderBloc(registerTraderUseCase: sl(), locationService: sl()));
  sl.registerFactory(() => RegisterConsumerBloc(registerConsumerUseCase: sl(), locationService: sl()));
  sl.registerFactory(() => ConsumerMarketBloc(remoteDataSource: sl(), productRepository: sl()));
  
  // Features - Product
  sl.registerFactory(() => ProductBloc(
        addProductUseCase: sl(),
        getFarmerProductsUseCase: sl(),
      ));
  
  sl.registerFactory(() => WeatherBloc(getWeatherUseCase: sl()));
  sl.registerFactory(() => PredictionBloc(getPredictionUseCase: sl()));
  sl.registerFactory(() => TraderDashboardBloc(
        farmerRepository: sl(),
        productRepository: sl(),
      ));
  sl.registerFactory(() => TraderMarketBloc(
        farmerRepository: sl(),
        productRepository: sl(),
      ));
  sl.registerFactory(() => ContractBloc(
        createContractUseCase: sl(),
        getUserContractsUseCase: sl(),
        updateContractStatusUseCase: sl(),
      ));
  sl.registerFactory(() => TraderProductBloc(
        addTraderProductUseCase: sl(),
        getTraderProductsUseCase: sl(),
        contractRepository: sl(),
      ));
  
  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterFarmerUseCase(sl()));
  sl.registerLazySingleton(() => RegisterTraderUseCase(sl()));
  sl.registerLazySingleton(() => RegisterConsumerUseCase(sl()));
  
  sl.registerLazySingleton(() => AddProductUseCase(sl()));
  sl.registerLazySingleton(() => GetFarmerProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetWeatherUseCase(sl()));
  sl.registerLazySingleton(() => GetPredictionUseCase(sl()));
  sl.registerLazySingleton(() => CreateContractUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserContractsUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateContractStatusUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddTraderProductUseCase(sl()));
  sl.registerLazySingleton(() => GetTraderProductsUseCase(sl()));
  
  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<IProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<IWeatherRepository>(
    () => WeatherRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<IPredictionRepository>(
    () => PredictionRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<IFarmerRepository>(
    () => FarmerRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<IContractRepository>(
    () => ContractRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ITraderProductRepository>(
    () => TraderProductRepositoryImpl(remoteDataSource: sl()),
  );
  
  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<IProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(dio: sl(), supabaseClient: sl()),
  );

  sl.registerLazySingleton<IWeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<IPredictionRemoteDataSource>(
    () => PredictionRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<IFarmerRemoteDataSource>(
    () => FarmerRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<IContractRemoteDataSource>(
    () => ContractRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<ITraderProductRemoteDataSource>(
    () => TraderProductRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<IConsumerMarketRemoteDataSource>(
    () => ConsumerMarketRemoteDataSourceImpl(dio: sl()),
  );

  // Core
  sl.registerLazySingleton(() => LocationService());
  sl.registerLazySingleton(() => Dio(
    BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  ));

  sl.registerLazySingleton(() => Supabase.instance.client);
}
