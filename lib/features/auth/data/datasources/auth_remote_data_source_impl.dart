import 'package:adminetic_booking/core/exceptions/server_validation_error.dart';
import 'package:adminetic_booking/core/network/api_interface.dart';
import 'package:adminetic_booking/core/network/api_service.dart';
import 'package:adminetic_booking/core/network/auth_api_service.dart';
import 'package:adminetic_booking/core/network/endpoints/auth_endpoint.dart';
import 'package:adminetic_booking/core/network/response_model.dart';
import 'package:adminetic_booking/core/services/shared_preferences_service.dart';
import 'package:dio/dio.dart';

import 'package:adminetic_booking/core/exceptions/server_exception.dart';
import 'package:adminetic_booking/core/extensions/extensions.dart';
import 'package:adminetic_booking/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:adminetic_booking/features/auth/data/models/user_model.dart';
import 'package:adminetic_booking/features/auth/domain/usecases/sign_in.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiInterface _apiService;

  AuthRemoteDataSourceImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<UserModel> signIn(SignInParams params) async {
    // try {
    //   const String loginUrl = '/login';
    //   final response = await dio.post(
    //     loginUrl,
    //     data: {
    //       'email': params.email,
    //       'password': params.password,
    //     },
    //   );
    //   final responseData = response.data;
    //   final status = responseData['status'];
    //   if (status is bool
    //       ? status
    //       : (status is String
    //           ? status.toBool()
    //           : throw ServerException('Server response status is unknown.'))) {
    //     final token = responseData['token'];
    //     final responseUserData = responseData['data'];

    //     // final message = responseData.message;

    //     final userModel = UserModel.fromMap(responseUserData);
    //     await sharedPreferences.saveData('token', token);
    //     return userModel;
    //   } else {
    //     responseData.error != null
    //         ? throw ServerValidationError.fromJson(
    //             responseData,
    //           )
    //         : throw ServerException(responseData.message);
    //   }
    // } on DioException catch (e) {
    //   // Authentication error
    //   if (e.response?.statusCode == 401) {
    //     throw ServerException('Authentication failed. Invalid credentials.');
    //   }
    //   throw ServerException(e.toString());
    // } on ServerException catch (e) {
    //   throw ServerException(e.message);
    // } on ServerValidationError catch (e) {
    //   throw ServerValidationError(errors: e.errors);
    // } catch (e) {
    //   throw ServerException(e.toString());
    // }

    final ResponseModel responseModel = await _apiService.post(
        endPoint: AuthEndpoint.signIn,
        data: {
          'email': params.email,
          'password': params.password,
        },
        requiresAuthToken: true);

    return UserModel.fromMap(responseModel.data!);
  }

  @override
  Future<void> logOut() async {
    // try {
    //   const String logOutUrl = '/logout';
    //   final token = sharedPreferences.getData('token');
    //   await dio.post(
    //     logOutUrl,
    //     options: Options(
    //       headers: {
    //         'Accept': 'application/vnd.api+json',
    //         'Authorization': 'Bearer $token',
    //       },
    //     ),
    //   );
    // } on ServerException catch (e) {
    //   throw ServerException(e.message);
    // }
    final ResponseModel responseModel = await _apiService.post(
        endPoint: AuthEndpoint.signOut, requiresAuthToken: true);

    if (responseModel.data != null) {
      await (_apiService as AuthApiService)
          .sharedPreferences
          .removeData('token');
    }
  }

  @override
  Future<UserModel?> currentUser() async {
    // try {
    //   const String currentUserUrl = '/user';
    //   final token = sharedPreferences.getData('token');
    //   if (token == null) {
    //     throw ServerException('User not logged in');
    //   }
    //   final response = await dio.get(
    //     currentUserUrl,
    //     options: Options(
    //       headers: {
    //         'Authorization': 'Bearer $token',
    //       },
    //     ),
    //   );
    //   final responseData = response.data;
    //   final responseUserData = responseData['data'];

    //   final userModel = UserModel.fromMap(responseUserData);
    //   return userModel;
    // } on ServerException catch (e) {
    //   throw ServerException(e.message);
    // } catch (e) {
    //   throw ServerException(e.toString());
    // }

    final ResponseModel responseModel =
        await _apiService.get(endPoint: AuthEndpoint.user);
    return responseModel.data != null
        ? UserModel.fromMap(responseModel.data!)
        : null;
  }
}
