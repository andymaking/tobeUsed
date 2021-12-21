
import 'package:dhoro_mobile/data/core/network_config.dart';
import 'package:dhoro_mobile/data/remote/model/user/user_model.dart';
import 'package:dhoro_mobile/data/remote/user_remote/user_remote.dart';
import 'package:dhoro_mobile/utils/constant.dart';
import 'package:dio/dio.dart';

/// This calls implements the UserRemote logic
class UserRemoteImpl extends UserRemote {
  final Dio dioClient;

  UserRemoteImpl(this.dioClient);

  @override
  Future<UserLoginResponse?> login(
      String email, String password) async {
    try {
      var _data = {'email': email, 'password': password};
      var response =
      await dioClient.post("${NetworkConfig.BASE_URL}user/login", data: _data);
      final responseData = UserLoginResponse.fromJson(response.data);
      sharedPreference.saveToken(responseData.data!.token!);
      return responseData;
    } catch (error) {
      print("error: $error");
      handleError(error);
    }
  }

}