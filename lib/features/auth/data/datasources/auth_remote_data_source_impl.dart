import 'package:adminetic_booking/core/exceptions/server_validation_error.dart';
import 'package:adminetic_booking/core/services/shared_preferences_service.dart';
import 'package:dio/dio.dart';

import 'package:adminetic_booking/core/exceptions/server_exception.dart';
import 'package:adminetic_booking/core/extensions/extensions.dart';
import 'package:adminetic_booking/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:adminetic_booking/features/auth/data/models/user_model.dart';
import 'package:adminetic_booking/features/auth/domain/usecases/sign_in.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SharedPreferencesService sharedPreferences;
  final Dio dio;
  AuthRemoteDataSourceImpl(
      {required this.sharedPreferences, required this.dio});

  @override
  Future<UserModel> signIn(SignInParams params) async {
    try {
      const String loginUrl = '/login';
      final response = await dio.post(
        loginUrl,
        data: {
          'email': params.email,
          'password': params.password,
        },
      );
      final responseData = response.data;
      final status = responseData['status'];
      if (status is bool
          ? status
          : (status is String
              ? status.toBool()
              : throw ServerException('Server response status is unknown.'))) {
        final token = responseData['token'];
        final responseUserData = responseData['data'];

        // final message = responseData.message;

        final userModel = UserModel.fromMap(responseUserData);
        await sharedPreferences.saveData('token', token);
        return userModel;
      } else {
        responseData.error != null
            ? throw ServerValidationError.fromJson(
                responseData,
              )
            : throw ServerException(responseData.message);
      }
    } on DioException catch (e) {
      // Authentication error
      if (e.response?.statusCode == 401) {
        throw ServerException('Authentication failed. Invalid credentials.');
      }
      throw ServerException(e.toString());
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } on ServerValidationError catch (e) {
      throw ServerValidationError(errors: e.errors);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logOut() async {
    try {
      const String logOutUrl = '/logout';
      final token = sharedPreferences.getData('token');
      await dio.post(
        logOutUrl,
        options: Options(
          headers: {
            'Accept': 'application/vnd.api+json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<UserModel?> currentUser() async {
    try {
      const String currentUserUrl = '/user';
      final token = sharedPreferences.getData('token');
      if (token == null) {
        throw ServerException('User not logged in');
      }
      final response = await dio.get(
        currentUserUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final responseData = response.data;
      final responseUserData = responseData['data'];

      final userModel = UserModel.fromMap(responseUserData);
      return userModel;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
