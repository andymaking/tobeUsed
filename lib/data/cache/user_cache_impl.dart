import 'package:dhoro_mobile/data/cache/user_cache.dart';
import 'package:dhoro_mobile/data/core/table_constants.dart';
import 'package:dhoro_mobile/domain/model/token/token_meta_data.dart';
import 'package:dhoro_mobile/domain/model/user/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserCacheImpl extends UserCache {
  @override
  Future<TokenMetaData> getTokenMetaData() async {
    final box = await Hive.openBox<TokenMetaData>(DbTable.TOKEN_TABLE_NAME);
    final data = box.values.toList();
    return data.last;
  }

  @override
  Future<User> getUser() async {
    final box = await Hive.openBox<User>(DbTable.USER_TABLE_NAME);
    final user = box.values.toList();
    return user.last;
  }

  @override
  Future<bool> isTokenExpired() async {
    final box = await Hive.openBox<bool>(DbTable.TOKEN_TABLE_NAME);
    final user = box.values;
    return user.first;
  }

  @override
  Future<void> saveTokenMetaData(TokenMetaData tokenMetaData) async {
    var box = await Hive.openBox<TokenMetaData>(DbTable.TOKEN_TABLE_NAME);
    box.add(tokenMetaData);
  }

  @override
  Future<void> saveUserLogin(User user) async {
    var box = await Hive.openBox<User>(DbTable.USER_TABLE_NAME);
    box.add(user);
  }

  @override
  Future<void> updateUserFirstTime(bool status) async {
    var box = await Hive.openBox<bool>(DbTable.APP_FIRST_TABLE_NAME);
    box.add(status);
  }

}