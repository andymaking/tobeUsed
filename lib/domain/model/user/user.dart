import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 2)
class User {
  @HiveField(0)
  String? email;
  @HiveField(1)
  String? token;
  @HiveField(2)

  User({
    this.email,
    this.token,
  });

  User.fromJson(dynamic json) {
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['email'] = email;
    map['token'] = token;
    return map;
  }
}
