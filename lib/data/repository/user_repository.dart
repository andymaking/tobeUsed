
import 'package:dhoro_mobile/data/remote/model/user/logged_in_user.dart';
import 'package:dhoro_mobile/domain/model/token/token_meta_data.dart';
import 'package:dhoro_mobile/domain/model/user/user.dart';

abstract class UserRepository {
  Future<TokenMetaData> getToken();
  Future<LoggedInUser?> getLoggedInUser();
  Future<User?> login(String email, String password);
  Future<String?> register(
      String firstname,
      String lastname,
      String email,
      String password,
      );
  Future<String?> forgotPassword(String email);
  Future<String?> changePassword(
      String password, String confirmPassword, String email, String otp);
}