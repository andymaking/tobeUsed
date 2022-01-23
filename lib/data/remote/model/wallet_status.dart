
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

class MessageResponse {
  bool? status;
  String? message;

  MessageResponse({
    this.status,
    this.message
  });

  MessageResponse.fromJson(dynamic json) {
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

class LockAndUnlockWalletResponse {
  int? status;
  String? message;

  LockAndUnlockWalletResponse({
    this.status,
    this.message
  });

  LockAndUnlockWalletResponse.fromJson(dynamic json) {
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