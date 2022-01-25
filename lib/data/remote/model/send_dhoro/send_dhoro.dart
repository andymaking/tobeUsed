
class SendDhoroStatus {
  int? status;
  String? message;

  SendDhoroStatus({
    this.status,
    this.message,
  });

  SendDhoroStatus.fromJson(dynamic json) {
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