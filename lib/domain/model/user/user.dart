import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 2)
class User {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? firstname;
  @HiveField(2)
  String? lastname;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? phone;
  @HiveField(5)
  String? password;
  @HiveField(6)
  String? description;
  @HiveField(7)
  String? emailOtp;
  @HiveField(8)
  String? avatar;

  User({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.password,
    this.description,
    this.emailOtp,
    this.avatar,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    description = json['description'];
    emailOtp = json['email_otp'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['firstname'] = firstname;
    map['lastname'] = lastname;
    map['email'] = email;
    map['phone'] = phone;
    map['password'] = password;
    map['description'] = description;
    map['email_otp'] = emailOtp;
    map['avatar'] = avatar;
    return map;
  }
}
