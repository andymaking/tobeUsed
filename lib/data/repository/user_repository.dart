
import 'package:dhoro_mobile/data/remote/model/transfer_history/transfer_history_data.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/data/remote/model/user/logged_in_user.dart';
import 'package:dhoro_mobile/data/remote/model/user/user_wallet_balance_model.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_percentage/wallet_percentage.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_status.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_status/wallet_status.dart';
import 'package:dhoro_mobile/domain/model/token/token_meta_data.dart';
import 'package:dhoro_mobile/domain/model/user/user.dart';

abstract class UserRepository {
  Future<TokenMetaData> getToken();
  //Future<LoggedInUser?> getLoggedInUser();
  Future<GetUserData?> getUser();
  Future<User?> login(String email, String password);
  Future<String?> register(
      String firstname,
      String lastname,
      String email,
      String password,
      );
  Future<String?> verifyAccount(String otp);
  Future<WalletData?> walletBalance();
  Future<String?> forgotPassword(String email);
  Future<String?> changePassword(
      String password, String confirmPassword, String email, String otp);
  Future<List<TransferHistoryData>?> getTransferHistory();
  Future<WalletStatusMessage?> getWalletStatus();
  Future<MessageResponse?> lockOrUnlockWallet(bool status);
  Future<String?> getWalletPercentage();

}