import 'package:fpdart/src/either.dart';

import 'package:adminetic_booking/core/entities/user.dart';
import 'package:adminetic_booking/core/exceptions/failure.dart';
import 'package:adminetic_booking/core/exceptions/server_exception.dart';
import 'package:adminetic_booking/core/exceptions/server_validation_error.dart';
import 'package:adminetic_booking/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:adminetic_booking/features/auth/domain/repositories/auth_repository.dart';
import 'package:adminetic_booking/features/auth/domain/usecases/sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});
  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      await authRemoteDataSource.logOut();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signIn(SignInParams params) async {
    try {
      final User user = await authRemoteDataSource.signIn(params);
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    } on ServerValidationError catch (e) {
      return Left(Failure(message: e.toString(), errors: e.errors));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final User? user = await authRemoteDataSource.currentUser();
      if (user == null) {
        return Left(Failure(message: "User not logged in"));
      }
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}
