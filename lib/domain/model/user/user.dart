import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 2)
class User {
  @HiveField(0)
  String? email;
  @HiveField(1)
  bool? isAgent;
  @HiveField(2)
  String? token;

  User({
    this.email,
    this.isAgent,
    this.token,
  });

  User.fromJson(dynamic json) {
    email = json['email'];
    isAgent = json['is_agent'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['email'] = email;
    map['is_agent'] = isAgent;
    map['token'] = token;
    return map;
  }
}
