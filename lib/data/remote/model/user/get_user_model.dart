
class GetUserResponse {
  int? status;
  String? message;
  GetUserData? data;

  GetUserResponse({this.status,this.message,this.data});

  GetUserResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? GetUserData.fromJson(json['data']) : null;
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

class GetUserData {
  String? pk;
  String? firstName;
  String? lastName;
  bool? isActive;
  String? email;
  String? phoneNumber;
  String? avatar;
  String? wid;
  String? created;
  String? updated;
  List<Wallet>? wallet;
  List<Payment>? payment;
  QRCode? qrCode;

  GetUserData({
    this.pk,
    this.firstName,
    this.lastName,
    this.isActive,
    this.email,
    this.phoneNumber,
    this.avatar,
    this.wid,
    this.created,
    this.updated,
    this.wallet,
    this.payment,
    this.qrCode
  });

  GetUserData.fromJson(dynamic json) {
    pk = json['pk'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    isActive = json['is_active'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    avatar = json['avatar'];
    wid = json['wid'];
    created = json['created'];
    updated = json['updated'];
    if (json['wallet'] != null) {
      wallet = [];
      json['wallet'].forEach((v) {
        wallet?.add(Wallet.fromJson(v));
      });
    }
    if (json['payment'] != null) {
      payment = [];
      json['payment'].forEach((v) {
        payment?.add(Payment.fromJson(v));
      });
    }
    qrCode = json['qrcode'] != null ? QRCode.fromJson(json['qrcode']) : null;

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['pk'] = pk;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['is_active'] = isActive;
    map['email'] = email;
    map['phone_number'] = phoneNumber;
    map['avatar'] = avatar;
    map['wid'] = wid;
    map['created'] = created;
    map['updated'] = updated;
    if (wallet != null) {
      map['wallet'] = wallet?.map((v) => v.toJson()).toList();
    }
    if (payment != null) {
      map['payment'] = payment?.map((v) => v.toJson()).toList();
    }
    if (qrCode != null) {
      map['qrcode'] = qrCode?.toJson();
    }
    //map['qrcode'] = qrCode;
    return map;
  }

}

class Wallet {
  String? pk;
  double? amount;
  double? total;
  String? user;
  String? status;
  String? send;
  String? receive;
  String? created;
  String? updated;

  Wallet({
    this.pk,
    this.amount,
    this.total,
    this.user,
    this.status,
    this.send,
    this.receive,
    this.created,
    this.updated});

  Wallet.fromJson(dynamic json) {
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

class Payment {
  String? pk;
  String? processor;
  String? label;
  String? value;
  bool? isActive;
  String? user;
  String? created;
  String? updated;

  Payment({
    this.pk,
    this.processor,
    this.label,
    this.value,
    this.isActive,
    this.user,
    this.created,
    this.updated});

  Payment.fromJson(dynamic json) {
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

class QRCode {
  String? pk;
  String? code;

  QRCode({
    this.pk,
    this.code,
  });

  QRCode.fromJson(dynamic json) {
    pk = json['pk'];
    code = json['qr_code'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['pk'] = pk;
    map['qr_code'] = code;
    return map;
  }

}

// class GetUserData {
//   GetUserData({
//     this.email,
//     this.token,
//   });
//
//   GetUserData.fromJson(dynamic json) {
//     email = json['email'];
//     email = json['token'];
//   }
//   String? email;
//   String? token;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['email'] = email;
//     map['token'] = token;
//     return map;
//   }
//
// }