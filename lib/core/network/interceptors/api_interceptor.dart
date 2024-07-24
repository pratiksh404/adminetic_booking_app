import 'package:adminetic_booking/core/services/internet_status.dart';
import 'package:adminetic_booking/core/services/shared_preferences_service.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  final SharedPreferencesService sharedPreferences;
  final InternetStatus internetStatus;

  ApiInterceptor(
      {required this.sharedPreferences, required this.internetStatus});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!await internetStatus.isOnline) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'No Internet Connection',
          type: DioExceptionType.connectionError,
        ),
      );
    }

    if (options.extra.containsKey('requiresAuthToken')) {
      if (options.extra['requiresAuthToken'] == true) {
        // Token from shared preference
        final String? token = sharedPreferences.getData('token');

        if (token != null) {
          options.headers.addAll(
            <String, Object?>{'Authorization': 'Bearer $token'},
          );
        } else {
          return handler.reject(
            DioException(
              requestOptions: options,
              error: 'User not logged in',
              type: DioExceptionType.connectionError,
            ),
          );
        }
      }
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final bool status = response.data['status'];
    if (status) {
      final String? token = response.data['token'];

      if (token != null) {
        sharedPreferences.saveData('token', token);
      }
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final String? message = err.response?.data['message'];
    if (message != null) {
      err.copyWith(message: message);
    }
    return handler.next(err);
  }
}
