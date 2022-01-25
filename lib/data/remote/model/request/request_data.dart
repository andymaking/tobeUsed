import 'package:dhoro_mobile/data/remote/model/payment_processor/payment_processor.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';

class RequestData {
  String? pk;
  double? amount;
  double? value;
  double? naira;
  String? currencyType;
  double? transactionFee;
  double? totalUsd;
  double? totalNgn;
  String? wid;
  PaymentProcessorData? proof;
  Payment? payment;
  String? type;
  String? status;
  String? created;
  String? updated;

  RequestData({
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
    this.payment,
    this.type,
    this.status,
    this.created,
    this.updated});

  RequestData.fromJson(dynamic json) {
    pk = json['pk'];
    amount = json['amount'];
    value = json['value'];
    naira = json['naira'];
    currencyType = json['currency_type'];
    transactionFee = json['transaction_fee'];
    totalUsd = json['total_usd'];
    totalNgn = json['total_ngn'];
    wid = json['wid'];
    proof = json['proof'] != null ? PaymentProcessorData.fromJson(json['proof']) : null;
    payment = json['payment'] != null ? Payment.fromJson(json['payment']) : null;
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
    if (proof != null) {
      map['proof'] = proof?.toJson();
    }
    if (payment != null) {
      map['payment'] = payment?.toJson();
    }
    map['type'] = type;
    map['status'] = status;
    map['created'] = created;
    map['updated'] = updated;
    return map;
  }

}

class RequestResultData {
  int? status;
  String? message;
  List<RequestData>? data;

  RequestResultData({
    this.status,
    this.message,
    this.data,
    });

  RequestResultData.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(RequestData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}