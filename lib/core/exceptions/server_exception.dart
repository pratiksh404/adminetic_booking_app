import 'package:dio/dio.dart';

enum _ServerExceptionType {
  /// The exception for a prematurely cancelled request.
  cancelException,

  /// The exception for a failed connection attempt.
  connectTimeoutException,

  /// The exception for failing to send a request.
  sendTimeoutException,

  /// The exception for failing to receive a response.
  receiveTimeoutException,

  /// The exception for no internet connectivity.
  socketException,

  /// A better name for the socket exception.
  fetchDataException,

  /// The exception for an incorrect parameter in a request/response.
  formatException,

  /// The exception for an unknown type of failure.
  unrecognizedException,

  /// The exception for any parsing failure encountered during
  /// serialization/deserialization of a request.
  serializationException,
}

class ServerException implements Exception {
  final String name, message;
  final String? code;
  final int? statusCode;
  final _ServerExceptionType type;
  ServerException({
    this.code,
    int? statusCode,
    this.message = 'An unknown error occurred.',
    this.type = _ServerExceptionType.unrecognizedException,
  })  : statusCode = statusCode ?? 500,
        name = type.name;

  factory ServerException.fromDioException(Exception exception) {
    try {
      if (exception is DioException) {
        final response = exception.response;
        final int statusCode = response?.statusCode ?? 500;
        final String? message = exception.response?.data['message'];

        switch (exception.type) {
          case DioExceptionType.cancel:
            return ServerException(
              statusCode: statusCode,
              message: message ?? 'Request cancelled.',
              type: _ServerExceptionType.cancelException,
            );
          case DioExceptionType.connectionTimeout:
            return ServerException(
              statusCode: statusCode,
              message: message ?? 'Connection timeout.',
              type: _ServerExceptionType.connectTimeoutException,
            );
          case DioExceptionType.sendTimeout:
            return ServerException(
              statusCode: statusCode,
              message: message ?? 'Send timeout.',
              type: _ServerExceptionType.sendTimeoutException,
            );
          case DioExceptionType.receiveTimeout:
            return ServerException(
              statusCode: statusCode,
              message: message ?? 'Receive timeout.',
              type: _ServerExceptionType.receiveTimeoutException,
            );
          case DioExceptionType.badCertificate:
            return ServerException(
              statusCode: statusCode,
              message: message ?? 'Bad certificate.',
              type: _ServerExceptionType.fetchDataException,
            );
          case DioExceptionType.badResponse:
            return ServerException(
              statusCode: statusCode,
              message: message ?? 'Bad response.',
              type: _ServerExceptionType.fetchDataException,
            );
          case DioExceptionType.connectionError:
            return ServerException(
              statusCode: statusCode,
              message: message ?? 'Connection error.',
              type: _ServerExceptionType.socketException,
            );
          case DioExceptionType.unknown:
            return ServerException(
              statusCode: statusCode,
              message: message ?? 'An unknown error occurred.',
              type: _ServerExceptionType.unrecognizedException,
            );
          default:
            return ServerException(
              statusCode: statusCode,
              message: message ?? 'An unknown error occurred.',
              type: _ServerExceptionType.unrecognizedException,
            );
        }
      } else {
        return ServerException(
          message: 'An unknown error occurred.',
          type: _ServerExceptionType.unrecognizedException,
        );
      }
    } on FormatException catch (e) {
      return ServerException(
        message: e.message,
        type: _ServerExceptionType.formatException,
      );
    } on Exception catch (_) {
      return ServerException(
        message: 'An unknown error occurred.',
        type: _ServerExceptionType.unrecognizedException,
      );
    }
  }

  factory ServerException.fromParsingException(Exception error) {
    return ServerException(
      type: _ServerExceptionType.serializationException,
      message: 'Failed to parse network response to model or vice versa',
    );
  }
}
