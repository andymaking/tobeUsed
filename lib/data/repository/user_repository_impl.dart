
import 'package:dhoro_mobile/data/cache/user_cache.dart';
import 'package:dhoro_mobile/data/remote/model/agents/agent.dart';
import 'package:dhoro_mobile/data/remote/model/convert/withdraw/convert.dart';
import 'package:dhoro_mobile/data/remote/model/payment_processor/payment_processor.dart';
import 'package:dhoro_mobile/data/remote/model/rate/rate.dart';
import 'package:dhoro_mobile/data/remote/model/request/request_data.dart';
import 'package:dhoro_mobile/data/remote/model/transfer_history/transfer_history_data.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/data/remote/model/user/logged_in_user.dart';
import 'package:dhoro_mobile/data/remote/model/user/user_wallet_balance_model.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_percentage/wallet_percentage.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_status.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_status/wallet_status.dart';
import 'package:dhoro_mobile/data/remote/model/withdraw/withdraw.dart';
import 'package:dhoro_mobile/data/remote/user_remote/user_remote.dart';
import 'package:dhoro_mobile/data/repository/user_repository.dart';
import 'package:dhoro_mobile/domain/model/token/token_meta_data.dart';
import 'package:dhoro_mobile/domain/model/user/user.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemote userRemote;
  final UserCache userCache;

  UserRepositoryImpl(this.userRemote, this.userCache);

  @override
  Future<String?> changePassword(String oldPassword, String newPassword) async{
    final tokenMeta = await getToken();
    return await userRemote.changePassword(tokenMeta, oldPassword, newPassword);
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
    if ((DateTime.now().hour - lastSavedTime.hour) < 22) {
      //token has not expired
      return tokenMeta;
    } else {
      //logout
      /*TODO*/
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

  @override
  Future<List<PaymentProcessorData>?> getPaymentProcessors() async{
    final token = await getToken();
    return await userRemote.getPaymentProcessors(token);
  }

  @override
  Future<MessageResponse?> deletePaymentProcessor(String pk) async{
    final token = await getToken();
    return await userRemote.deletePaymentProcessor(pk,token);
  }

  @override
  Future<List<RequestData>?> getRequests() async{
    final token = await getToken();
    return await userRemote.getRequests(token);
  }

  @override
  Future<GetUserData?> updateUserProfile(String firstName, String lastName, String phoneNumber) async{
    final token = await getToken();
    return await userRemote.updateUserProfile(token, firstName, lastName, phoneNumber);
  }

  @override
  Future<PaymentProcessorData?> addPaymentProcessors(String bankName, String userName, String accountNumber) async{
    final token = await getToken();
    return await userRemote.addPaymentProcessors(token, bankName, userName, accountNumber);
  }

  @override
  Future<GetUserData?> addAvatar(String avatar) async{
    final token = await getToken();
    return await userRemote.addAvatar(token, avatar);
  }

  @override
  Future<RateData?> getRate() async {
    return await userRemote.getRate();
  }

  @override
  Future<ConvertData?> convertCurrency(String queryParams) async {
    return userRemote.convertCurrency(queryParams);
  }

  @override
  Future<List<AgentsData>?> getAgents() async {
    final token = await getToken();
    return await userRemote.getAgents(token);
  }

  @override
  Future<AgentsData?> getSingleAgent(String pk) async {
    final token = await getToken();
    return await userRemote.getSingleAgent(token,pk);
  }

  @override
  Future<ConvertData?> convertBuyCurrency(String queryParams) async {
    return userRemote.convertBuyCurrency(queryParams);
  }

  @override
  Future<WithdrawData?> buyDhoro(String value, String agent, String proofOfPayment, String currencyType) async {
    final token = await getToken();
    return await userRemote.buyDhoro(token,value, agent, proofOfPayment, currencyType);
  }

  @override
  Future<WithdrawData?> withdrawDhoro(String amount, String agent, String paymentMethod, String currencyType) async {
    final token = await getToken();
    return await userRemote.withdrawDhoro(token,amount, agent, paymentMethod, currencyType);
  }

  @override
  Future<List<TransferHistoryData>?> getTransferHistoryQuery(String query) async {
    final tokenMeta = await getToken();
    return await userRemote.getTransferHistoryQuery(tokenMeta, query);
  }

  @override
  Future<List<RequestData>?> getRequestsQuery(String query) async {
    final token = await getToken();
    return await userRemote.getRequestsQuery(token, query);
  }

}