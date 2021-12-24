class PaymentProcessorResponse {
  int? status;
  String? message;
  List<PaymentProcessorData>? data;
  PaymentProcessorResponse({
    this.status,
    this.message,
    this.data,
  });

  PaymentProcessorResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PaymentProcessorData.fromJson(v));
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

class PaymentProcessorData {
  String? pk;
  String? processor;
  String? label;
  String? value;
  bool? isActive;
  String? user;
  String? created;
  String? updated;

  PaymentProcessorData({
    this.pk,
    this.processor,
    this.label,
    this.value,
    this.isActive,
    this.user,
    this.created,
    this.updated});

  PaymentProcessorData.fromJson(dynamic json) {
    pk = json['pk'];
    processor = json['processor'];
    label = json['label'];
    value = json['value'];
    isActive = json['is_active'];
    user = json['user'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['pk'] = pk;
    map['processor'] = processor;
    map['label'] = label;
    map['value'] = value;
    map['is_active'] = isActive;
    map['user'] = user;
    map['created'] = created;
    map['updated'] = updated;
    return map;
  }

}