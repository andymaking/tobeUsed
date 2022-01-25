
class AgentsResponse {
  int? status;
  String? message;
  List<AgentsData>? data;

  AgentsResponse({this.status,this.message,this.data});

  AgentsResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AgentsData.fromJson(v));
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

class GetSingleAgentsResponse {
  int? status;
  String? message;
  AgentsData? data;

  GetSingleAgentsResponse({this.status,this.message,this.data});

  GetSingleAgentsResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? AgentsData.fromJson(json['data']) : null;
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

class AgentsData {
  AgentsData({
    this.pk,
    this.user,
    this.accountName,
    this.accountNumber,
    this.bankName,
    this.phoneNumber,
    this.email,
    this.created
  });

  AgentsData.fromJson(dynamic json) {
    pk = json['pk'];
    user = json['user'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    created = json['created'];
  }
  String? pk;
  String? user;
  String? accountName;
  String? accountNumber;
  String? bankName;
  String? phoneNumber;
  String? email;
  String? created;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pk'] = pk;
    map['user'] = user;
    map['account_name'] = accountName;
    map['account_number'] = accountNumber;
    map['bank_name'] = bankName;
    map['phone_number'] = phoneNumber;
    map['email'] = email;
    map['created'] = created;
    return map;
  }

}