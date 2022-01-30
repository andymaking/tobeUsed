
class ValidateBuyResponse {
  int? status;
  String? message;
  bool? data;

  ValidateBuyResponse({
    this.status,
    this.message,
    this.data
  });

  ValidateBuyResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['data'] = data;
    return map;
  }

}

class ValidateWithdrawResponse {
  int? status;
  String? message;
  bool? data;

  ValidateWithdrawResponse({
    this.status,
    this.message,
    this.data
  });

  ValidateWithdrawResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['data'] = data;
    return map;
  }

}
