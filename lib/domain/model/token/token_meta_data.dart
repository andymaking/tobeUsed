import 'package:hive/hive.dart';

part 'token_meta_data.g.dart';

@HiveType(typeId: 99)
class TokenMetaData {
  @HiveField(0)
  String token;
  @HiveField(1)
  String refreshToken;
  @HiveField(2)
  double lastTimeStored;
  @HiveField(3)
  String userId;

  TokenMetaData(
      this.token, this.refreshToken, this.lastTimeStored, this.userId);

  @override
  String toString() {
    return 'TokenMetaData{token: $token, refreshToken: $refreshToken, lastTimeStored: $lastTimeStored, userId: $userId}';
  }
}
