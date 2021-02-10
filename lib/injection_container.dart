import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_tdd_architecture/core/network/network_info.dart';
import 'package:flutter_tdd_architecture/features/data/datasources/local_data_source/user_local_data_source.dart';
import 'package:flutter_tdd_architecture/features/data/datasources/remote_data_source/user_remote_data_source.dart';
import 'package:flutter_tdd_architecture/features/data/repositories/user/user_repository_impl.dart';
import 'package:flutter_tdd_architecture/features/domain/repositories/user/user_repository.dart';
import 'package:flutter_tdd_architecture/features/domain/usecases/usecases.dart';
import 'package:flutter_tdd_architecture/features/presentation/bloc/user/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Bloc
  sl.registerFactory(
    () => UserBloc(
      user: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetUser(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(dio: sl()));

  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(sp: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
