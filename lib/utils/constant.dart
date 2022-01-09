

import 'package:dhoro_mobile/utils/sharedpreferences.dart';

/// create global instance of sharedPreferences global service
final SharedPreference sharedPreference = SharedPreference();
//final HiveUtils hiveUtils = HiveUtils();

class Constant {
  static const String USER_ID_KEY = 'user_id';
  static const String FIRST_NAME_KEY = 'first_name';
  static const String LAST_NAME_KEY = 'last_name';
  static const String NAME_KEY = 'name';
  static const String EMAIL_KEY = 'email';
  static const String PHONE_NUMBER_KEY = 'phone';
  static const String AVATAR_KEY = 'avatar';
  static const String TOKEN_KEY = 'token';
  static const String ACCOUNT_NO_KEY = 'account_number';
  static const String LOGIN_TIME = "login_time";
  static const String IS_AUTOMATIC = "is_automatic";
  static const String FIRST_INSTALL = "is_first_install";
  static const String IS_LOGIN_KEY = "is_logged_in";
  static const double TEXT_EDIT_FONT_SIZE = 16;
}

extension StingExtentions on String {
 String get svg => 'assets/images/svg/$this.svg';
 String get png => 'assets/images/png/$this.png';
}
