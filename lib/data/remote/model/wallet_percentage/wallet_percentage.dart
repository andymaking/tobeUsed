
class WalletPercentage {
  int? status;
  String? message;
  int? data;

  WalletPercentage({
    this.status,
    this.message,
    this.data
  });

  WalletPercentage.fromJson(dynamic json) {
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