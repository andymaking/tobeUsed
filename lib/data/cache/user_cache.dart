
import 'package:dhoro_mobile/domain/model/token/token_meta_data.dart';
import 'package:dhoro_mobile/domain/model/user/user.dart';

abstract class UserCache {
  Future<void> saveUserLogin(User user);
  Future<void> saveTokenMetaData(TokenMetaData tokenMetaData);
  Future<TokenMetaData> getTokenMetaData();
  Future<User> getUser();
  Future<bool> isTokenExpired();
  Future<void> updateUserFirstTime(bool status);
}