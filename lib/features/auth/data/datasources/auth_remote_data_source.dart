import 'package:adminetic_booking/features/auth/data/models/user_model.dart';
import 'package:adminetic_booking/features/auth/domain/usecases/sign_in.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signIn(SignInParams params);

  Future<UserModel?> currentUser();

  Future<UserModel> setUserFcmToken(UserModel user);

  Future<void> logOut();
}
