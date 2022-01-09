class ConvertResponse {
  int? status;
  String? message;
  ConvertData? data;

  ConvertResponse({this.status,this.message,this.data});

  ConvertResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ConvertData.fromJson(json['data']) : null;
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

class ConvertData {
  ConvertData({
    this.ngn,
    this.dhr,
    this.usd,
  });

  ConvertData.fromJson(dynamic json) {
    ngn = json['ngn'];
    dhr = json['dhr'];
    usd = json['usd'];
  }
  String? ngn;
  String? dhr;
  String? usd;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ngn'] = ngn;
    map['dhr'] = dhr;
    map['usd'] = usd;
    return map;
  }

}