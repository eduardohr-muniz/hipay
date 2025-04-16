import 'dart:convert';
export 'package:hipay/src/client/dio_impl/adapter/dio_io.dart' if (dart.library.html) 'package:hipay/src/client/dio_impl/adapter/dio_browser.dart';
import 'package:dio/dio.dart';
import 'package:hipay/src/client/clien_exports.dart';
import 'package:hipay/src/logs/talker_logs.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

class ClientDio implements IClient {
  late final Dio _dio;
  bool _enableLogs = false;
  ClientDio({BaseOptions? baseOptions, Talker? talker, bool enableLogs = true}) {
    _enableLogs = enableLogs;

    _dio = DioAdapter(baseOptions ?? _defaultOptions);

    if (_enableLogs) {
      _dio.interceptors.add(TalkerDioLogger(
          talker: talker ?? TalkerLogs.instance.talker,
          settings: const TalkerDioLoggerSettings(
            enabled: true,
            printRequestHeaders: true,
            printRequestData: true,
            printResponseData: true,
            printResponseMessage: true,
            printResponseRedirects: true,
            printErrorHeaders: false,
          )));
    }
  }

  final _defaultOptions = BaseOptions();

  @override
  IClient auth() {
    _defaultOptions.extra["auth_required"] = true;
    return this;
  }

  @override
  IClient unauth() {
    _defaultOptions.extra["auth_required"] = false;
    return this;
  }

  @override
  Future<ClientResponse<T>> delete<T>(String path, {data, Map<String, dynamic>? query, Map<String, dynamic>? headers}) async {
    try {
      _logDebug(path, "DELETE", queryParamters: query, headers: headers, baseOptions: _dio.options.headers, data: data);
      final DateTime start = DateTime.now();
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: query,
        options: Options(headers: headers),
      );
      final DateTime end = DateTime.now();
      _logResponse(path, "DELETE", response: response, time: end.difference(start).inMilliseconds.toString());
      return _dioResponseConverter(response);
    } on DioException catch (e) {
      _trowRestClientException(e);
    }
  }

  @override
  Future<ClientResponse<T>> download<T>(String path, {required String savePath, Map<String, dynamic>? query, Map<String, dynamic>? headers, void Function(int, int)? onReceiveProgress, void Function(double percent)? onReceiveProgressPercent}) async {
    try {
      _logDebug(path, "DOWNLOAD", queryParamters: query, headers: headers, baseOptions: _dio.options.headers);
      final DateTime start = DateTime.now();
      final response = await _dio.download(
        path,
        savePath,
        onReceiveProgress: (count, total) {
          onReceiveProgress?.call(count, total);
          final double result = (total > 0) ? count / total : 0.1;
          onReceiveProgressPercent?.call(result);
        },
        queryParameters: query,
        options: Options(headers: headers),
      );
      final DateTime end = DateTime.now();
      _logResponse(path, "DOWNLOAD", response: response, time: end.difference(start).inMilliseconds.toString());
      return _dioResponseConverter(response);
    } on DioException catch (e) {
      _trowRestClientException(e);
    }
  }

  @override
  Future<ClientResponse<T>> get<T>(String path, {Map<String, dynamic>? query, Map<String, dynamic>? headers, void Function(int, int)? onReceiveProgress}) async {
    try {
      _logDebug(path, "GET", queryParamters: query, headers: headers, baseOptions: _dio.options.headers);
      final DateTime start = DateTime.now();
      final response = await _dio.get(path, queryParameters: query, options: Options(headers: headers), onReceiveProgress: onReceiveProgress);
      final DateTime end = DateTime.now();
      _logResponse(path, "GET", response: response, time: end.difference(start).inMilliseconds.toString());
      return _dioResponseConverter(response);
    } on DioException catch (e) {
      _trowRestClientException(e);
    }
  }

  @override
  Future<ClientResponse<T>> patch<T>(String path, {data, Map<String, dynamic>? query, Map<String, dynamic>? headers}) async {
    try {
      _logDebug(path, "PATCH", queryParamters: query, headers: headers, baseOptions: _dio.options.headers, data: data);
      final DateTime start = DateTime.now();
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: query,
        options: Options(headers: headers),
      );
      final DateTime end = DateTime.now();
      _logResponse(path, "PATCH", response: response, time: end.difference(start).inMilliseconds.toString());
      return _dioResponseConverter(response);
    } on DioException catch (e) {
      _trowRestClientException(e);
    }
  }

  @override
  Future<ClientResponse<T>> post<T>(String path, {data, Map<String, dynamic>? query, Map<String, dynamic>? headers}) async {
    try {
      _logDebug(path, "POST", queryParamters: query, headers: headers, baseOptions: _dio.options.headers, data: data is Map ? jsonEncode(data) : data);
      final DateTime start = DateTime.now();
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: query,
        options: Options(headers: headers, extra: {
          'mode': 'no-cors'
        }),
      );
      final DateTime end = DateTime.now();
      _logResponse(path, "POST", response: response, time: end.difference(start).inMilliseconds.toString());
      return _dioResponseConverter(response);
    } on DioException catch (e) {
      _trowRestClientException(e);
    }
  }

  @override
  Future<ClientResponse<T>> put<T>(String path, {data, Map<String, dynamic>? query, Map<String, dynamic>? headers}) async {
    try {
      _logDebug(path, "PUT", queryParamters: query, headers: headers, baseOptions: _dio.options.headers, data: data);
      final DateTime start = DateTime.now();
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: query,
        options: Options(headers: headers),
      );
      final DateTime end = DateTime.now();
      _logResponse(path, "PUT", response: response, time: end.difference(start).inMilliseconds.toString());
      return _dioResponseConverter(response);
    } on DioException catch (e) {
      _trowRestClientException(e);
    }
  }

  @override
  Future<ClientResponse<T>> request<T>(String path, {data, Map<String, dynamic>? query, Map<String, dynamic>? headers}) async {
    try {
      _logDebug(path, "REQUEST", queryParamters: query, headers: headers, baseOptions: _dio.options.headers, data: data);
      final DateTime start = DateTime.now();
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: query,
        options: Options(headers: headers),
      );
      final DateTime end = DateTime.now();
      _logResponse(path, "REQUEST", response: response, time: end.difference(start).inMilliseconds.toString());
      return _dioResponseConverter(response);
    } on DioException catch (e) {
      return _trowRestClientException(e);
    }
  }

  Future<ClientResponse<T>> _dioResponseConverter<T>(Response<dynamic> response) async {
    return ClientResponse<T>(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

  String getErrorMessage(DioException dioError) {
    if (dioError.response != null && dioError.response?.data != null && dioError.response?.data is Map) {
      if (dioError.response?.data['error_description'] != null) {
        return dioError.response?.data['error_description'];
      }
      if (dioError.response?.data['error'] != null) {
        return dioError.response?.data['error'];
      }
      if (dioError.response?.data['message'] != null) {
        return dioError.response!.data['message']!.toString();
      }

      if (dioError.response?.data['msg'] != null) {
        return dioError.response?.data['msg'];
      }
    }

    return dioError.toString();
  }

  Never _trowRestClientException(DioException dioError) {
    final exception = ClientExceptionDio(
      error: dioError.error,
      message: getErrorMessage(dioError),
      response: dioError.response,
      requestOptions: dioError.requestOptions,
      stackTrace: dioError.stackTrace,
      type: dioError.type,
    );
    _logError(error: exception.error.toString(), stackTrace: exception.stackTrace, message: exception.message, statusCode: exception.response?.statusCode.toString());
    throw Exception(exception.message ?? exception);
  }

  void _logDebug(String path, String methodo, {Map<String, dynamic>? headers, Map<String, dynamic>? baseOptions, Map<String, dynamic>? queryParamters, dynamic data}) {
    // if (_enableLogs == false) return;
    // log.d(
    //     'METHOD: $methodo \nPATH: ${_dio.options.baseUrl}$path \nQUERYPARAMTERS: $queryParamters \nHEADERS: $headers \nBASEOPTIONS: $baseOptions \nDATA: ${data is Uint8List ? 'bytes' : data}');
  }

  void _logError({String? error, String? message, String? statusCode, StackTrace? stackTrace}) {
    // if (_enableLogs == false) return;
    // log
    //   ..e('ERROR: $error \nMESSAGE: $message \nSTATUSCODE: $statusCode')
    //   ..w('STACKTRACE: $stackTrace');
  }

  void _logResponse(String path, String methodo, {Response? response, String? time}) {
    // if (_enableLogs == false) return;
    // final statusCode = response?.statusCode ?? 0;
    // if (statusCode >= 200 && statusCode < 300) {
    //   log.i(
    //       '[RESPONSE]: ${response?.statusCode}\nMETHOD: $methodo \nPATH: ${_dio.options.baseUrl}$path \nTIME: 🕑$time ms \nRESPONSE: ${_logFormatter(response?.data)}');
    // } else {
    //   log.w(
    //       '[RESPONSE]: ${response?.statusCode}\nMETHOD: $methodo \nPATH: ${_dio.options.baseUrl}$path \nTIME: 🕑$time ms \nRESPONSE: ${_logFormatter(response?.data)}');
    // }
  }

  // String? _logFormatter(dynamic input) {
  //   if (input is Map) {
  //     try {
  //       return const JsonEncoder.withIndent('  ').convert(input);
  //     } catch (e) {
  //       return 'Erro ao formatar o JSON: $e';
  //     }
  //   }
  //   if (input is List) {
  //     if (input.isEmpty) return '[]';
  //     final first = input.first;
  //     if (first is Map) {
  //       try {
  //         return const JsonEncoder.withIndent('  ').convert(input);
  //       } catch (e) {
  //         return 'Erro ao formatar o JSON: $e';
  //       }
  //     }
  //   }
  //   return input.runtimeType.toString();
  // }
}
