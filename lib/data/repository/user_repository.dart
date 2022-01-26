
import 'package:dhoro_mobile/data/remote/model/agents/agent.dart';
import 'package:dhoro_mobile/data/remote/model/airdrop/airdrop_info.dart';
import 'package:dhoro_mobile/data/remote/model/airdrop/claim_airdrop.dart';
import 'package:dhoro_mobile/data/remote/model/convert/withdraw/convert.dart';
import 'package:dhoro_mobile/data/remote/model/payment_processor/payment_processor.dart';
import 'package:dhoro_mobile/data/remote/model/rate/rate.dart';
import 'package:dhoro_mobile/data/remote/model/request/request_data.dart';
import 'package:dhoro_mobile/data/remote/model/send_dhoro/send_dhoro.dart';
import 'package:dhoro_mobile/data/remote/model/transfer_history/transfer_history_data.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/data/remote/model/user/logged_in_user.dart';
import 'package:dhoro_mobile/data/remote/model/user/user_model.dart';
import 'package:dhoro_mobile/data/remote/model/user/user_wallet_balance_model.dart';
import 'package:dhoro_mobile/data/remote/model/validate/validate.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_percentage/wallet_percentage.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_status.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_status/wallet_status.dart';
import 'package:dhoro_mobile/data/remote/model/withdraw/withdraw.dart';
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
  Future<String?> changePassword(String oldPassword, String newPassword);
  Future<List<TransferHistoryData>?> getTransferHistory(int page, int pageSize);
  Future<List<TransferHistoryData>?> getTransferHistoryQuery(String query);
  Future<WalletStatusMessage?> getWalletStatus();
  Future<LockAndUnlockWalletResponse?> lockOrUnlockWallet(bool status);
  Future<String?> getWalletPercentage();
  Future<List<PaymentProcessorData>?> getPaymentProcessors();
  Future<MessageResponse?> deletePaymentProcessor(String pk);
  Future<List<RequestData>?> getRequests(int page);
  Future<List<RequestData>?> getRequestsQuery(String query);
  Future<GetUserData?> updateUserProfile(String firstName, String lastName, String phoneNumber );
  Future<PaymentProcessorData?> addPaymentProcessors(String bankName, String userName, String accountNumber);
  Future<GetUserData?> addAvatar(String avatar);
  Future<RateData?> getRate();
  Future<ConvertData?> convertCurrency(String queryParams);
  Future<ConvertData?> convertBuyCurrency(String queryParams);
  Future<List<AgentsData>?> getAgents();
  Future<AgentsData?> getSingleAgent(String pk);
  Future<WithdrawData?> buyDhoro(String value, String agent, String proofOfPayment, String currencyType);
  Future<WithdrawData?> withdrawDhoro(double amount, String currencyType, String paymentMethod, String agent);
  Future<SendDhoroStatus?> sendDhoro(String amount, String currencyType, String wid);
  Future<ClaimAirdropResponse?> claimAirdrop(String wid);
  Future<AirdropInfoData?> getAirdropInfo();
  Future<AvatarResponse?> getAvatar();
  Future<ValidateBuyResponse?> validateBuyDhoro(String amount, String currencyType);
  Future<ValidateWithdrawResponse?> validateWithdrawDhoro(String amount, String currencyType);
  Future<AirdropStatusData?> getAirdropStatus();

}