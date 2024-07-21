import 'package:adminetic_booking/core/exceptions/server_exception.dart';
import 'package:adminetic_booking/core/network/api_interface.dart';
import 'package:adminetic_booking/core/helpers/typedefs.dart';
import 'package:adminetic_booking/core/network/dio_service.dart';
import 'package:adminetic_booking/core/network/response_model.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/cancel_token.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class ApiService implements ApiInterface {
  late final DioService _client;
  ApiService({required DioService client}) : _client = client;

  @override
  Future<ResponseModel> all({
    required String endPoint,
    JSON? queryParams,
    CancelToken? cancelToken,
    CachePolicy? cachePolicy,
    int? cacheAgeDays,
    bool requiresAuthToken = true,
  }) async {
    try {
      // Entire map of response
      final response = await _client.get(
        endPoint: endPoint,
        cacheOptions: _client.cacheOptions?.copyWith(
          policy: cachePolicy,
          maxStale: cacheAgeDays != null
              ? Nullable(Duration(days: cacheAgeDays))
              : null,
        ),
        options: Options(
          extra: <String, Object?>{
            'requiresAuthToken': requiresAuthToken,
          },
        ),
        queryParameters: queryParams,
        cancelToken: cancelToken,
      );

      final JSON body = response.data != null ? response.data as JSON : {};

      return ResponseModel.fromMap(body);
    } on Exception catch (ex) {
      throw ServerException.fromDioException(ex);
    }
  }

  @override
  void cancelRequests({CancelToken? cancelToken}) {
    _client.cancelRequest(cancelToken);
  }

  @override
  Future<ResponseModel> get(
      {required String endPoint,
      JSON? queryParams,
      CancelToken? cancelToken,
      bool requiresAuthToken = true}) async {
    try {
      final response = await _client.get(
        endPoint: endPoint,
        options: Options(
          extra: <String, Object?>{
            'requiresAuthToken': requiresAuthToken,
          },
        ),
        queryParameters: queryParams,
        cancelToken: cancelToken,
      );

      return response;
    } on Exception catch (ex) {
      throw ServerException.fromDioException(ex);
    }
  }

  @override
  Future<ResponseModel> post(
      {required String endPoint,
      JSON? data,
      CancelToken? cancelToken,
      bool requiresAuthToken = true}) async {
    try {
      final response = await _client.post(
        endPoint: endPoint,
        data: data,
        options: Options(
          extra: <String, Object?>{
            'requiresAuthToken': requiresAuthToken,
          },
        ),
        cancelToken: cancelToken,
      );

      return response;
    } on Exception catch (ex) {
      throw ServerException.fromDioException(ex);
    }
  }
}
