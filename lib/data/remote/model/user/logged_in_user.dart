class LoggedInUserNetworkResponse {
  int? status;
  String? message;
  LoggedInUser? data;

  LoggedInUserNetworkResponse({this.status,this.message,this.data});

  LoggedInUserNetworkResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? LoggedInUser.fromJson(json['data']) : null;
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

class LoggedInUser {
  LoggedInUser({
    this.email,
    this.token,
  });

  LoggedInUser.fromJson(dynamic json) {
    email = json['email'];
    email = json['token'];
  }
  String? email;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['token'] = token;
    return map;
  }

}


class LoggedInUserData {
  LoggedInUserData({
    this.email,
    this.token,
    });

  LoggedInUserData.fromJson(dynamic json) {
    email = json['email'];
    email = json['token'];
  }
  String? email;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['token'] = token;
    return map;
  }

}




