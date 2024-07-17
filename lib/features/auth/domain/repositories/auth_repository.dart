import 'package:adminetic_booking/core/entities/user.dart';
import 'package:adminetic_booking/core/exceptions/failure.dart';
import 'package:adminetic_booking/features/auth/domain/usecases/sign_in.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  /// The `Future<Either<Failure, User>> signIn(SignInParams params);` method in the `AuthRepository`
  /// interface is defining a function signature for a method named `signIn`.
  Future<Either<Failure, User>> signIn(SignInParams params);

  Future<Either<Failure, User>> currentUser();

  /// The `Future<Either<Failure, void>> logOut();` method in the `AuthRepository` interface is defining a
  /// function signature for a method named `logOut` that returns a `Future` containing an `Either` type.
  Future<Either<Failure, void>> logOut();
}
