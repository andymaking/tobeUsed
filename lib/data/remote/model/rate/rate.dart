class RateResponse {
  int? status;
  String? message;
  RateData? data;

  RateResponse({this.status,this.message,this.data});

  RateResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? RateData.fromJson(json['data']) : null;
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

class RateData {
  RateData({
    this.pk,
    this.priceInDollar,
    this.equivalentInDhoro,
    this.created,
    this.updated
  });

  RateData.fromJson(dynamic json) {
    pk = json['pk'];
    priceInDollar = json['price_in_dollar'];
    equivalentInDhoro = json['equivalent_in_dhoro'];
    created = json['created'];
    updated = json['updated'];
  }
  String? pk;
  String? priceInDollar;
  double? equivalentInDhoro;
  String? created;
  String? updated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pk'] = pk;
    map['price_in_dollar'] = priceInDollar;
    map['equivalent_in_dhoro'] = equivalentInDhoro;
    map['created'] = created;
    map['updated'] = updated;
    return map;
  }

}