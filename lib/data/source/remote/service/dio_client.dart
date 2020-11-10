import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:structure_flutter_mobile/data/source/remote/api/error/base_exception.dart';
import 'package:structure_flutter_mobile/data/source/remote/api/error/error_response.dart';
import 'package:structure_flutter_mobile/data/source/remote/service/callback.dart';

const _kDefaultConnectTimeout = Duration.millisecondsPerMinute;
const _kDefaultReceiveTimeout = Duration.millisecondsPerMinute;

@singleton
class DioClient {
  final String baseUrl;

  Dio _dio;

  final List<Interceptor> interceptors;

  DioClient(this.baseUrl, {Dio dio, this.interceptors}) {
    _dio = dio ?? Dio();
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = _kDefaultConnectTimeout
      ..options.receiveTimeout = _kDefaultReceiveTimeout
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'};
    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors);
    }
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          error: true));
    }
  }

  Future<Callback<T>> get<T>(
    String uri, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
    @required Function(Map<String, dynamic> json) mapper,
  }) async {
    return _handleResponse(
        () => _dio.get(uri,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress),
        mapper);
  }

  Future<Callback<T>> _handleResponse<T>(Future<dynamic> Function() func,
      Function(Map<String, dynamic>) mapper) async {
    try {
      final result = await func() as Response;
      final data = result.data as Map<String, dynamic>;
      if (result.statusCode == 200) {
        return Callback.success(mapper(data));
      } else {
        final ErrorResponse error = ErrorResponse.fromJson(data);
        final BaseException exception = error != null
            ? BaseException.toServerError(error)
            : BaseException.toHttpError(result);
        return Callback.failure(exception);
      }
    } on SocketException catch (e) {
      return Callback.failure(BaseException.toNetworkError(e));
    } catch (e) {
      if (e is DioError) {
        return Callback.failure(BaseException.toHttpError(e.response));
      }
      return Callback.failure(BaseException.toUnexpectedError(e));
    }
  }
}
