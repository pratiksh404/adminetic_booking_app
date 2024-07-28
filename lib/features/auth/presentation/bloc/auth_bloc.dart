import 'package:adminetic_booking/core/presentation/cubit/app_user/app_user_cubit.dart';
import 'package:adminetic_booking/core/entities/user.dart';
import 'package:adminetic_booking/core/usecase.dart';
import 'package:adminetic_booking/features/auth/domain/usecases/current_user.dart';
import 'package:adminetic_booking/features/auth/domain/usecases/sign_in.dart';
import 'package:adminetic_booking/features/auth/domain/usecases/sign_out.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignIn _signIn;
  final SignOut _signOut;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required SignIn signIn,
    required SignOut signOut,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _signIn = signIn,
        _signOut = signOut,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignIn>(_onAuthSign);
    on<AuthSignOut>(_onAuthSignOut);
    on<AuthCheck>(_onAuthCheck);
  }

  void _onAuthSign(AuthSignIn event, Emitter<AuthState> emit) async {
    final response = await _signIn(
      SignInParams(email: event.email, password: event.password),
    );

    return response.fold(
      (failure) =>
          emit(AuthFailure(message: failure.message, errors: failure.errors)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    final response = await _signOut(NoParams());

    return response.fold(
      (failure) =>
          emit(AuthFailure(message: failure.message, errors: failure.errors)),
      (_) => _emitAuthOutSuccess(emit),
    );
  }

  void _onAuthCheck(AuthCheck event, Emitter<AuthState> emit) async {
    final response = await _currentUser(NoParams());
    return response.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    print('auth success');
    emit(AuthSuccess(user: user));
    _appUserCubit.updateUser(user);
  }

  void _emitAuthOutSuccess(Emitter<AuthState> emit) {
    emit(AuthSignOutSuccess());
    _appUserCubit.updateUser(null);
  }
}
