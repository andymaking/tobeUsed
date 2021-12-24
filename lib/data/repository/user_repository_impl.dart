
import 'package:dhoro_mobile/data/cache/user_cache.dart';
import 'package:dhoro_mobile/data/remote/model/transfer_history/transfer_history_data.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/data/remote/model/user/logged_in_user.dart';
import 'package:dhoro_mobile/data/remote/model/user/user_wallet_balance_model.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_percentage/wallet_percentage.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_status.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_status/wallet_status.dart';
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
  Future<GetUserData?> getUser() async{
    final tokenMeta = await getToken();
    print("Showing token on getUser::: $tokenMeta");
    return await userRemote.getUser(tokenMeta);
  }

  @override
  Future<TokenMetaData> getToken() async{
    final tokenMeta = await userCache.getTokenMetaData();
    final lastSavedTime =
    DateTime.fromMillisecondsSinceEpoch(tokenMeta.lastTimeStored.toInt());
    if ((DateTime.now().hour - lastSavedTime.hour) < 1) {
      //token has not expired
      return tokenMeta;
    } else {
      return tokenMeta;
    }
  }

  @override
  Future<User?> login(String email, String password) async{
    final response = await userRemote.login(email, password);
    await userCache.saveUserLogin(response!.data!);
    await userCache.updateUserFirstTime(true);
    final tokenMeta = TokenMetaData(
        "Token " + response.data!.token!,
        DateTime.now().millisecondsSinceEpoch.toDouble(),
    );
    print("Showing token details::: $tokenMeta");
    await userCache.saveTokenMetaData(tokenMeta);
    return response.data!;
  }

  @override
  Future<String?> register(
      String firstname,
      String lastname,
      String email,
      String password,
      ) {
    return userRemote.register(firstname, lastname, email, password);
  }

  @override
  Future<String?> verifyAccount(String otp) async{
    return await userRemote.verifyAccount(otp);
  }

  @override
  Future<WalletData?> walletBalance() async{
    final tokenMeta = await getToken();
    return await userRemote.getWalletBalance(tokenMeta);
  }

  @override
  Future<List<TransferHistoryData>?> getTransferHistory() async{
    final tokenMeta = await getToken();
    return await userRemote.getTransferHistory(tokenMeta);
  }

  @override
  Future<WalletStatusMessage?> getWalletStatus() async{
    final token = await getToken();
    return await userRemote.getWalletStatus(token);
  }

  @override
  Future<MessageResponse?> lockOrUnlockWallet(bool status) async{
    final token = await getToken();
    return await userRemote.lockOrUnlockWallet(status,token);
  }

  @override
  Future<String?> getWalletPercentage() async{
    final token = await getToken();
    return await userRemote.getWalletPercentage(token);
  }

}