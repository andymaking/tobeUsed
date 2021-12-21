
import 'package:dhoro_mobile/data/cache/user_cache.dart';
import 'package:dhoro_mobile/data/remote/model/user/logged_in_user.dart';
import 'package:dhoro_mobile/data/remote/user_remote/user_remote.dart';
import 'package:dhoro_mobile/data/repository/user_repository.dart';
import 'package:dhoro_mobile/domain/model/token/token_meta_data.dart';
import 'package:dhoro_mobile/domain/model/user/user.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemote userRemote;
  final UserCache userCache;

  UserRepositoryImpl(this.userRemote, this.userCache);

  @override
  Future<String?> changePassword(String password, String confirmPassword, String email, String otp) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<String?> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<LoggedInUser?> getLoggedInUser() {
    // TODO: implement getLoggedInUser
    throw UnimplementedError();
  }

  @override
  Future<TokenMetaData> getToken() {
    // TODO: implement getToken
    throw UnimplementedError();
  }

  @override
  Future<User?> login(String email, String password) async{
    final response = await userRemote.login(email, password);
    await userCache.saveUserLogin(response!.data!);
    await userCache.updateUserFirstTime(true);
    final tokenMeta = TokenMetaData(
        "Bearer " + response.data!.token!,
        DateTime.now().millisecondsSinceEpoch.toDouble(),
    );
    await userCache.saveTokenMetaData(tokenMeta);
    return response.data!;
  }

  @override
  Future<String?> register(String firstname, String lastname, String email, String password, String device_id, String device_brand, String device_model, List<String> pictures, int genderId, String dob, String phone
      ) {
    // TODO: implement register
    throw UnimplementedError();
  }

}