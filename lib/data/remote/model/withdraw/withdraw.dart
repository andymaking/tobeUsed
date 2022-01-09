class WithdrawResponse {
  int? status;
  String? message;
  WithdrawData? data;

  WithdrawResponse({
    this.status,
    this.message,
    this.data
  });

  WithdrawResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? WithdrawData.fromJson(json['data']) : null;
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

class WithdrawData {
  String? pk;
  double? amount;
  double? value;
  double? naira;
  String? currencyType;
  double? transactionFee;
  double? totalUsd;
  double? totalNgn;
  String? wid;
  String? proof;
  String? agentDetail;
  String? type;
  String? status;
  String? created;
  String? updated;

  WithdrawData({
    this.pk,
    this.amount,
    this.value,
    this.naira,
    this.currencyType,
    this.transactionFee,
    this.totalUsd,
    this.totalNgn,
    this.wid,
    this.proof,
    this.agentDetail,
    this.type,
    this.status,
    this.created,
    this.updated});

  WithdrawData.fromJson(dynamic json) {
    pk = json['pk'];
    amount = json['amount'];
    value = json['value'];
    naira = json['naira'];
    currencyType = json['currency_type'];
    transactionFee = json['transaction_fee'];
    totalUsd = json['total_usd'];
    totalNgn = json['total_ngn'];
    wid = json['wid'];
    proof = json['proof'];
    agentDetail = json['agent_detail'];
    type = json['type'];
    status = json['status'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['pk'] = pk;
    map['amount'] = amount;
    map['value'] = value;
    map['naira'] = naira;
    map['currency_type'] = currencyType;
    map['transaction_fee'] = transactionFee;
    map['total_usd'] = totalUsd;
    map['total_ngn'] = totalNgn;
    map['wid'] = wid;
    map['proof'] = proof;
    map['agent_detail'] = agentDetail;
    map['type'] = type;
    map['status'] = status;
    map['created'] = created;
    map['updated'] = updated;
    return map;
  }

}