class WalletStatusResponse {
  int? status;
  WalletStatusMessage? message;

  WalletStatusResponse({
    this.status,
    this.message,
  });

  WalletStatusResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'] != null ? WalletStatusMessage.fromJson(json['message']) : null;

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    if (message != null) {
      map['message'] = message?.toJson();
    }
    return map;
  }

}

class WalletStatusMessage {
  bool? status;

  WalletStatusMessage({
    this.status,
  });

  WalletStatusMessage.fromJson(dynamic json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    return map;
  }

}