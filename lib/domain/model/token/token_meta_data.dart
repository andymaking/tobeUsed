import 'package:hive/hive.dart';

part 'token_meta_data.g.dart';

@HiveType(typeId: 99)
class TokenMetaData {
  @HiveField(0)
  String token;
  @HiveField(1)
  double lastTimeStored;
  // @HiveField(2)
  // String userId;

  TokenMetaData(
      this.token, this.lastTimeStored, /*this.userId*/);

  @override
  String toString() {
    return 'TokenMetaData{token: $token, lastTimeStored: $lastTimeStored}';
  }
}
