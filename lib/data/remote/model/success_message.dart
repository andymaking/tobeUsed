class SuccessMessage {
  String? message;

  SuccessMessage({
      this.message});

  SuccessMessage.fromJson(dynamic json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

}