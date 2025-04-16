import 'package:dio/dio.dart';

class ClientExceptionDio implements Exception {
  final RequestOptions requestOptions;
  final Response? response;
  final DioExceptionType type;
  final Object? error;
  final StackTrace stackTrace;
  final String? message;

  ClientExceptionDio({
    required this.requestOptions,
    required this.type,
    required this.stackTrace,
    this.response,
    this.error,
    this.message,
  });
  ClientExceptionDio copyWith({
    RequestOptions? requestOptions,
    Response? response,
    DioExceptionType? type,
    Object? error,
    StackTrace? stackTrace,
    String? message,
  }) {
    return ClientExceptionDio(
      requestOptions: requestOptions ?? this.requestOptions,
      response: response ?? this.response,
      type: type ?? this.type,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
      message: message ?? this.message,
    );
  }
}
