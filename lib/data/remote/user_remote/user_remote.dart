
import 'dart:convert';

import 'package:dhoro_mobile/data/remote/model/user/user_model.dart';
import 'package:dio/dio.dart';

abstract class UserRemote {
  Future<UserLoginResponse?> login(String email, String password);
  Future<String?> register(
      String firstname,
      String lastname,
      String email,
      String password,
      );
}

void handleError(dynamic error) {
  var errorString = error.response.toString();
  if (error is DioError) {
    final errorMessage = DioExceptions.fromDioError(error).toString();
    throw errorMessage;
  } else {
    var json = jsonDecode(errorString);
    var nameJson = json['message'];

    throw nameJson;
  }
}

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.other:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        message = _handleError(
            dioError.response?.statusCode ?? 444, dioError.response?.data);
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String message = "";

  String _handleError(int statusCode, dynamic error) {
    if (statusCode >= 400 && statusCode <= 409)
      return error["message"];
    else if (statusCode >= 500 && statusCode <= 509)
      return 'Internal server error';
    else return error["message"];
  }


  @override
  String toString() => message;
}
