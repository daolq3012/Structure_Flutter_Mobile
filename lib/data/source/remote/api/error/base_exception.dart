import 'package:dio/dio.dart';
import 'package:structure_flutter_mobile/data/source/remote/api/error/type.dart';

import 'error_response.dart';

class BaseException implements Exception {
  final Type errorType;
  final Exception exception;
  final Response<dynamic> response;
  final ErrorResponse errorResponse;

  BaseException(
    this.errorType, {
    this.response,
    this.exception,
    this.errorResponse,
  });

  factory BaseException.toNetworkError(Exception e) {
    return BaseException(Type.NETWORK, exception: e);
  }

  factory BaseException.toHttpError(Response<dynamic> response) {
    return BaseException(Type.HTTP, response: response);
  }

  factory BaseException.toServerError(ErrorResponse response) {
    return BaseException(Type.SERVER, errorResponse: response);
  }

  factory BaseException.toUnexpectedError(Exception e) {
    return BaseException(Type.UNEXPECTED, exception: e);
  }

  String get errorMessage {
    switch (errorType) {
      case Type.NETWORK:
        return exception.toString();
      case Type.SERVER:
        return errorResponse.message;
      case Type.HTTP:
        return _getHttpErrorMessage(response.statusCode);
      default:
        return "Something went wrong. Please try again!";
    }
  }

  _getHttpErrorMessage(int statusCode) {
    if (statusCode >= 300 && statusCode <= 308) {
      // Redirection
      return "It was transferred to a different URL. I'm sorry for causing you trouble";
    }
    if (statusCode >= 400 && statusCode <= 451) {
      // Client error
      return "An error occurred on the application side. Please try again later!";
    }
    if (statusCode >= 500 && statusCode <= 511) {
      // Server error
      return "A server error occurred. Please try again later!";
    }
    // Unofficial error
    return "An error occurred. Please try again later!";
  }
}
