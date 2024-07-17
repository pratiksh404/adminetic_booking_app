import 'package:adminetic_booking/core/exceptions/failure.dart';
import 'package:adminetic_booking/core/usecase.dart';
import 'package:adminetic_booking/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignOut implements UseCase<void, NoParams> {
  final AuthRepository authRepository;
  SignOut({required this.authRepository});

  /// This Dart function is an asynchronous method that calls the logOut method from the authRepository
  /// and returns a Future containing Either a Failure or void.
  ///
  /// Args:
  ///   params (NoParams): In the provided code snippet, the `call` method is being overridden with a
  /// return type of `Future<Either<Failure, void>>`. It takes a single parameter `NoParams params`.
  ///
  /// Returns:
  ///   The code snippet is returning a `Future` that resolves to an `Either` type, which can hold either
  /// a `Failure` or `void`. The `call` method is calling the `logOut` method from the `authRepository`
  /// and returning the result.
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.logOut();
  }
}
