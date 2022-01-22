class AirdropInfoResponse {
  int? status;
  String? message;
  AirdropInfoData? data;

  AirdropInfoResponse({
    this.status,
    this.message,
    this.data,
  });

  AirdropInfoResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? AirdropInfoData.fromJson(json['data']) : null;
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

class AirdropInfoData {
  double? amount;
  double? amountPerAddress;
  bool? claimed;

  AirdropInfoData({
    this.amount,
    this.amountPerAddress,
    this.claimed,
    });

  AirdropInfoData.fromJson(dynamic json) {
    amount = json['amount'];
    amountPerAddress = json['amount_per_address'];
    claimed = json['claimed'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['amount'] = amount;
    map['amount_per_address'] = amountPerAddress;
    map['claimed'] = claimed;
    return map;
  }

}