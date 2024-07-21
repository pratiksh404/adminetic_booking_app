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
        final String? _token = sharedPreferences.getData('token');

        if (_token != null) {
          options.headers.addAll(
            <String, Object?>{'Authorization': 'Bearer $_token'},
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
    final int statusCode = response.statusCode!;
    if (status) {
      final String? _token = response.data['token'];

      if (_token != null) {
        sharedPreferences.saveData('token', _token);
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
