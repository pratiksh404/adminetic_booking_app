import 'package:adminetic_booking/core/helpers/typedefs.dart';
import 'package:adminetic_booking/core/network/response_model.dart';
import 'package:dio/dio.dart';

abstract class ApiInterface {
  const ApiInterface();

  Future<ResponseModel> all({
    required String endPoint,
    JSON? queryParams,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
  });

  Future<ResponseModel> get({
    required String endPoint,
    JSON? queryParams,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
  });

  void cancelRequests({CancelToken? cancelToken});

  Future<ResponseModel> post({
    required String endPoint,
    JSON? data,
    CancelToken? cancelToken,
    bool requiresAuthToken = true,
  });
}
