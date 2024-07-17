import 'package:adminetic_booking/core/cubit/app_user/app_user_cubit.dart';
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
        dio: Dio(_dioConfigurations(forAuth: true)),
        sharedPreferences: serviceLocator<SharedPreferencesService>(),
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
  final String baseUrl =
      dotenv.env['BASE_URL'] ?? 'https://rafting.test/api/v1';

  final String authBaseUrl =
      dotenv.env['AUTH_BASE_URL'] ?? 'https://rafting.test/api';

  return BaseOptions(
    baseUrl: forAuth ? authBaseUrl : baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  );
}
