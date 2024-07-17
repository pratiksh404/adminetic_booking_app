import 'package:adminetic_booking/core/entities/user.dart';
import 'package:adminetic_booking/core/exceptions/failure.dart';
import 'package:adminetic_booking/core/usecase.dart';
import 'package:adminetic_booking/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignIn implements UseCase<User, SignInParams> {
  final AuthRepository authRepository;

  SignIn({required this.authRepository});

  /// The function `call` in Dart returns a `Future` that either contains a `Failure` or a `User` after
  /// signing in with the provided parameters.
  ///
  /// Args:
  ///   params (SignInParams): The `call` function takes a `SignInParams` object as a parameter. This
  /// object likely contains the necessary information required for signing in a user, such as username,
  /// password, or any other authentication details. The function then calls the `signIn` method on the
  /// `authRepository` to attempt to
  ///
  /// Returns:
  ///   A Future containing an Either object, which can hold either a Failure or a User object.

  @override
  Future<Either<Failure, User>> call(SignInParams params) async {
    return await authRepository.signIn(params);
  }
}

/// The class `SignInParams` in Dart represents parameters required for signing in, including email and
/// password.
class SignInParams {
  final String email;
  final String password;
  SignInParams({required this.email, required this.password});
}
