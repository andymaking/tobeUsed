
class WalletStatus {
  int? status;
  Message? message;

  WalletStatus({
    this.status,
    this.message,
  });

  WalletStatus.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    return map;
  }

}

class Message {
  bool? status;

  Message({
    this.status,
  });

  Message.fromJson(dynamic json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    return map;
  }

}