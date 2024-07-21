import 'package:adminetic_booking/core/helpers/typedefs.dart';
import 'package:adminetic_booking/core/network/response_model.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class DioService {
  final Dio _dio;
  final CacheOptions? cacheOptions;
  final CancelToken _cancelToken;
  DioService(
      {required Dio dio,
      this.cacheOptions,
      required CancelToken cancelToken,
      Iterable<Interceptor>? interceptors,
      HttpClientAdapter? httpClientAdapter})
      : _dio = dio,
        _cancelToken = cancelToken {
    if (interceptors != null) _dio.interceptors.addAll(interceptors);
    if (httpClientAdapter != null) _dio.httpClientAdapter = httpClientAdapter;
  }

  void cancelRequest(CancelToken? cancelToken) {
    cancelToken != null ? cancelToken.cancel() : _cancelToken.cancel();
  }

  Future<ResponseModel> get({
    required String endPoint,
    JSON? queryParameters,
    Options? options,
    CacheOptions? cacheOptions,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.get<JSON>(
      endPoint,
      queryParameters: queryParameters,
      options: _mergeDioAndCacheOptions(
          dioOptions: options, cacheOptions: cacheOptions),
      cancelToken: cancelToken ?? _cancelToken,
    );

    return ResponseModel.fromMap(response.data!);
  }

  Future<ResponseModel> post({
    required String endPoint,
    JSON? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.post<JSON>(
      endPoint,
      data: data,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return ResponseModel.fromMap(response.data!);
  }

  Future<ResponseModel> patch({
    required String endPoint,
    JSON? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.patch<JSON>(
      endPoint,
      data: data,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return ResponseModel.fromMap(response.data!);
  }

  Future<ResponseModel> delete({
    required String endPoint,
    JSON? data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.delete<JSON>(
      endPoint,
      data: data,
      options: options,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return ResponseModel.fromMap(response.data!);
  }

  Options? _mergeDioAndCacheOptions({
    Options? dioOptions,
    CacheOptions? cacheOptions,
  }) {
    if (dioOptions == null && cacheOptions == null) {
      return null;
    } else if (dioOptions == null && cacheOptions != null) {
      return cacheOptions.toOptions();
    } else if (dioOptions != null && cacheOptions == null) {
      return dioOptions;
    } else if (dioOptions != null && cacheOptions != null) {
      final cacheOptionsMap = cacheOptions.toExtra();
      final options = dioOptions.copyWith(
          extra: <String, dynamic>{...dioOptions.extra!, ...cacheOptionsMap});
      return options;
    } else {
      return dioOptions;
    }
  }
}
