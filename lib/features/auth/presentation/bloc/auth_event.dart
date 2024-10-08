part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  AuthSignIn({required this.email, required this.password});
}

final class AuthSignOut extends AuthEvent {}

final class AuthCheck extends AuthEvent {}
