import 'package:dhoro_mobile/domain/model/user/user.dart';

class WalletBalanceResponse {
  int? status;
  String? message;
  WalletData? data;
  WalletBalanceResponse({
    this.status,
    this.message,
    this.data,
  });

  WalletBalanceResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? WalletData.fromJson(json['data']) : null;
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


class WalletData {
  double? dhrBalance;
  double? usdEquivalent;

  WalletData({
    this.dhrBalance,
    this.usdEquivalent,
    });

  WalletData.fromJson(dynamic json) {
    dhrBalance = json['dhr_balance'];
    usdEquivalent = json['usd_equivalent'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['dhr_balance'] = dhrBalance;
    map['usd_equivalent'] = usdEquivalent;
    return map;
  }

}
