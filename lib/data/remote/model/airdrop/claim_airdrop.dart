
class ClaimAirdropResponse {
  int? status;
  String? message;

  ClaimAirdropResponse({
    this.status,
    this.message,
  });

  ClaimAirdropResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    return map;
  }

}