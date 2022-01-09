class TransferHistoryData {
  String? pk;
  double? amount;
  double? total;
  String? user;
  String? status;
  String? send;
  String? receive;
  String? created;
  String? updated;

  TransferHistoryData({
    this.pk,
    this.amount,
    this.total,
    this.user,
    this.status,
    this.send,
    this.receive,
    this.created,
    this.updated});

  TransferHistoryData.fromJson(dynamic json) {
    pk = json['pk'];
    amount = json['amount'];
    total = json['total'];
    user = json['user'];
    status = json['status'];
    send = json['send'];
    receive = json['receive'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['pk'] = pk;
    map['amount'] = amount;
    map['user'] = user;
    map['status'] = status;
    map['send'] = send;
    map['receive'] = receive;
    map['created'] = created;
    map['updated'] = updated;
    return map;
  }

}

class ResultData {
  int? status;
  String? message;
  List<TransferHistoryData>? data;

  ResultData({
    this.status,
    this.message,
    this.data,
    });

  ResultData.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TransferHistoryData.fromJson(v));
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