import 'package:dhoro_mobile/domain/model/user/user.dart';

class UserLoginResponse {
  int? status;
  String? message;
  User? data;
  UserLoginResponse({
    this.status,
    this.message,
    this.data,
  });

  UserLoginResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}