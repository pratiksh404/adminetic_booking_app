import 'package:adminetic_booking/core/cubit/app_user/app_user_cubit.dart';
import 'package:adminetic_booking/core/network/api_interface.dart';
import 'package:adminetic_booking/core/network/api_service.dart';
import 'package:adminetic_booking/core/network/app_api_service.dart';
import 'package:adminetic_booking/core/network/auth_api_service.dart';
import 'package:adminetic_booking/core/network/dio_service.dart';
import 'package:adminetic_booking/core/network/interceptors/api_interceptor.dart';
import 'package:adminetic_booking/core/services/internet_status.dart';
import 'package:adminetic_booking/core/services/shared_preferences_service.dart';
import 'package:adminetic_booking/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:adminetic_booking/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:adminetic_booking/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:adminetic_booking/features/auth/domain/repositories/auth_repository.dart';
import 'package:adminetic_booking/features/auth/domain/usecases/current_user.dart';
import 'package:adminetic_booking/features/auth/domain/usecases/sign_in.dart';
import 'package:adminetic_booking/features/auth/domain/usecases/sign_out.dart';
import 'package:adminetic_booking/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  // Env initialization
  await dotenv.load(fileName: ".env");

// Feature Dependencies
  _dependencies();

  // App User Cubit Initialization
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  // Shared Preferences Initialization
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<SharedPreferencesService>(
      SharedPreferencesService(sharedPreferences));

// Network Initialization

  // Internet Check Initialization
  final internetConnectionChecker = InternetConnectionChecker();
  serviceLocator
    ..registerSingleton<InternetStatus>(
        InternetStatus(internetConnectionChecker));

  // Dio Initialization
  final authDio = Dio(_dioConfigurations(forAuth: true));
  authDio
    ..interceptors.add(ApiInterceptor(
      sharedPreferences: serviceLocator<SharedPreferencesService>(),
      internetStatus: serviceLocator<InternetStatus>(),
    ))
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  final dio = Dio(_dioConfigurations());
  dio
    ..interceptors.add(ApiInterceptor(
      sharedPreferences: serviceLocator<SharedPreferencesService>(),
      internetStatus: serviceLocator<InternetStatus>(),
    ))
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));

// Initializing Auth Api Service
  serviceLocator.registerLazySingleton(() => AppApiService(
        client: DioService(
          dio: dio,
          cancelToken: CancelToken(),
        ),
      ));

  serviceLocator.registerLazySingleton(() => AuthApiService(
      client: DioService(
        dio: authDio,
        cancelToken: CancelToken(),
      ),
      sharedPreferences: serviceLocator<SharedPreferencesService>()));
}

void _dependencies() {
  // Auth Dependencies
  _authDependencies();
}

void _authDependencies() {
  // Data Sources
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        apiService: serviceLocator<AuthApiService>(),
      ),
    )
    // Repositories
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
          authRemoteDataSource: serviceLocator<AuthRemoteDataSource>()),
    )
    // Usecases
    ..registerFactory(
      () => CurrentUser(authRepository: serviceLocator<AuthRepository>()),
    )
    ..registerFactory(
      () => SignIn(authRepository: serviceLocator<AuthRepository>()),
    )
    ..registerFactory(
      () => SignOut(authRepository: serviceLocator<AuthRepository>()),
    )
    // Blocs
    ..registerFactory<AuthBloc>(
      () => AuthBloc(
        signIn: serviceLocator<SignIn>(),
        signOut: serviceLocator<SignOut>(),
        currentUser: serviceLocator<CurrentUser>(),
        appUserCubit: serviceLocator<AppUserCubit>(),
      ),
    );
}

BaseOptions _dioConfigurations({bool forAuth = false}) {
  // Android 10.0.2.2
  // IOS 127.0.0.1 or localhost
  final String baseUrl =
      dotenv.env['BASE_URL'] ?? 'http://10.0.2.2:8000/api/v1';

  final String authBaseUrl =
      dotenv.env['AUTH_BASE_URL'] ?? 'http://10.0.2.2:8000/api';

  return BaseOptions(
    baseUrl: forAuth ? authBaseUrl : baseUrl,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  );
}
