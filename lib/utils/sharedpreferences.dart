import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

class SharedPreference extends ChangeNotifier {
  final String deviceBrandKey = 'deviceBand';
  final String deviceModelKey = 'deviceModel';
  final String deviceIdKey = 'deviceId';
  final String tokenKey = 'token';
  final String forgotPassWKey = 'forgotPassW';
  final String forgotPassPassKey = 'forgotPassPassKey';
  final String forgotPassConfirmPassKey = 'forgotPassConfirmPassKey';
  final String lastTransactionHistoryPage = 'lastTransactionHistoryPage';
  final String requestTotalPages = 'requestTotalPages';

  // clear shared preferences
  Future<void> clear() async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.clear();
  }


  /// cache device id
  void setDeviceId(String id) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(deviceIdKey, id);
    notifyListeners();
  }
  /// cache device id
  void saveToken(String id) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(tokenKey, id);
    notifyListeners();
  }
  /// cache device id
  void saveTransLastPage(int id) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setInt(lastTransactionHistoryPage, id);
    notifyListeners();
  }
  /// get user token
  Future<int> getTransLastPage() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getInt(lastTransactionHistoryPage) ?? 0;
  }
  /// cache device id
  void saveRequestLastPage(int id) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setInt(requestTotalPages, id);
    notifyListeners();
  }
  /// get user token
  Future<int> getRequestLastPage() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getInt(requestTotalPages) ?? 0;
  }

  /// get user token
  Future<String> getToken() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getString(tokenKey) ?? '';
  }

  /// get device id
  Future<String> getDeviceId() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getString(deviceIdKey) ?? '';
  }

  /// cache device id
  void setDeviceBrand(String id) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(deviceBrandKey, id);
    notifyListeners();
  }
  /// get device id
  Future<String> getDeviceBrand() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getString(deviceBrandKey) ?? '';
  }

  /// cache device id
  void setDeviceModel(String id) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(deviceModelKey, id);
    notifyListeners();
  }
  /// get device id
  Future<String> getDeviceModel() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getString(deviceModelKey) ?? '';
  }

  /// cache device id
  void saveForgotPasswordEmail(String id) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(forgotPassWKey, id);
    notifyListeners();
  }
  /// get device id
  Future<String> getForgotPasswordEmail() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getString(forgotPassWKey) ?? '';
  }

  /// cache device id
  void saveForgotPasswordPassword(String id) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(forgotPassPassKey, id);
    notifyListeners();
  }
  /// get device id
  Future<String> getForgotPasswordPassword() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getString(forgotPassPassKey) ?? '';
  }

  /// cache device id
  void saveForgotPasswordConfirmPassword(String id) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(forgotPassConfirmPassKey, id);
    notifyListeners();
  }
  /// get device id
  Future<String> getForgotPasswordConfirmPassword() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getString(forgotPassConfirmPassKey) ?? '';
  }

}
