
import 'package:dhoro_mobile/data/core/network_config.dart';
import 'package:dhoro_mobile/data/remote/model/payment_processor/payment_processor.dart';
import 'package:dhoro_mobile/data/remote/model/request/request_data.dart';
import 'package:dhoro_mobile/data/remote/model/request/request_response.dart';
import 'package:dhoro_mobile/data/remote/model/success_message.dart';
import 'package:dhoro_mobile/data/remote/model/transfer_history/transfer_history_data.dart';
import 'package:dhoro_mobile/data/remote/model/transfer_history/transfer_history_response.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/data/remote/model/user/logged_in_user.dart';
import 'package:dhoro_mobile/data/remote/model/user/user_model.dart';
import 'package:dhoro_mobile/data/remote/model/user/user_wallet_balance_model.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_percentage/wallet_percentage.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_status.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_status/wallet_status.dart';
import 'package:dhoro_mobile/data/remote/user_remote/user_remote.dart';
import 'package:dhoro_mobile/domain/model/token/token_meta_data.dart';
import 'package:dhoro_mobile/utils/constant.dart';
import 'package:dio/dio.dart';

/// This calls implements the UserRemote logic
class UserRemoteImpl extends UserRemote {
  final Dio dioClient;

  UserRemoteImpl(this.dioClient);

  @override
  Future<UserLoginResponse?> login(
      String email, String password) async {
    try {
      var _data = {'email': email, 'password': password};
      var response =
      await dioClient.post("${NetworkConfig.BASE_URL}user/login", data: _data);
      final responseData = UserLoginResponse.fromJson(response.data);
      sharedPreference.saveToken(responseData.data!.token!);
      return responseData;
    } catch (error) {
      print("error: $error");
      handleError(error);
    }
  }

  @override
  Future<String?> register(
      String firstname,
      String lastname,
      String email,
      String password,
      ) async {
    try {
      var _data = {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'password': password,
      };
      var response = await dioClient.post("${NetworkConfig.BASE_URL}user/register",
          data: _data);
      final message = SuccessMessage.fromJson(response.data).message;
      return message;
    } catch (error) {
      handleError(error);
    }
  }

  @override
  Future<String?> verifyAccount(String otp) async {
    try{
      var _data = {
        'token': otp,
      };
      var response = await dioClient.post("${NetworkConfig.BASE_URL}user/verification",
          data: _data);
      final message = SuccessMessage.fromJson(response.data).message;
      print("Verification from Remote layer:: $message");
      return message;
    } catch (error){
      print("Verification error from Remote layer:: $error");
      handleError(error);
    }
  }

  @override
  Future<WalletData?> getWalletBalance(TokenMetaData tokenMetaData) async{
    try {
      dioClient.options.headers['Authorization'] = tokenMetaData.token;
      var response = await dioClient.get(
          "${NetworkConfig.BASE_URL}user/wallet/balance");
      final responseData = WalletBalanceResponse.fromJson(response.data);
      print("WalletBalance from Remote layer:: $responseData");
      return responseData.data;
    } catch (error) {
      handleError(error);
    }
  }

  @override
  Future<List<TransferHistoryData>?> getTransferHistory(TokenMetaData tokenMetaData) async{
    try {
      dioClient.options.headers['Authorization'] = tokenMetaData.token;
      var response = await dioClient.get(
        "${NetworkConfig.BASE_URL}user/transfer/history",
      );
      final responseData = TransferHistoryDataResponse.fromJson(response.data);
      print("TransferHistory from Remote layer:: $responseData");
      return responseData.results?.data;
    } catch (error) {
      handleError(error);
    }
  }

  @override
  Future<String?> changePassword(TokenMetaData tokenMetaData, String oldPassword, String newPassword) async{
    try {
      var _data = {
        'old_password': oldPassword,
        'new_password': newPassword
      };
      dioClient.options.headers['Authorization'] = tokenMetaData.token;
      var response = await dioClient.post(
          "${NetworkConfig.BASE_URL}user/password/reset", data: _data
      );
      final responseData = MessageResponse.fromJson(response.data);
      print("changePassword from Remote layer:: $responseData");
      return responseData.message;
    } catch (error) {
      handleError(error);
    }
  }

  @override
  Future<String?> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<GetUserData?> getUser(TokenMetaData tokenMetaData) async{
    try {
      dioClient.options.headers['Authorization'] = tokenMetaData.token;
      var response = await dioClient.get(
        "${NetworkConfig.BASE_URL}user",
      );
      final responseData = GetUserResponse.fromJson(response.data);
      print("Showing User Info Status: ${responseData.status}");
      print("Showing User Info message: ${responseData.message}");
      print("Showing User Info: ${responseData.data}");
      return responseData.data;
    } catch (error) {
      print("get user error: $error");
      handleError(error);
    }
  }

  @override
  Future<WalletStatusMessage?> getWalletStatus(TokenMetaData tokenMetaData) async{
    try {
      dioClient.options.headers['Authorization'] = tokenMetaData.token;
      var response = await dioClient.get(
        "${NetworkConfig.BASE_URL}user/wallet/status",
      );
      final responseData = WalletStatusResponse.fromJson(response.data);
      print("TransferHistory from Remote layer:: $responseData");
      return responseData.message;
    } catch (error) {
      handleError(error);
    }
  }

  @override
  Future<MessageResponse?> lockOrUnlockWallet(bool status, TokenMetaData tokenMetaData) async{
    try {
      var _data = {
        'status': status,
      };
      dioClient.options.headers['Authorization'] = tokenMetaData.token;
      var response = await dioClient.post(
        "${NetworkConfig.BASE_URL}user/wallet/lock", data: _data
      );
      final responseData = MessageResponse.fromJson(response.data);
      print("lockOrUnlockWallet from Remote layer:: $responseData");
      return responseData;
    } catch (error) {
      handleError(error);
    }
  }

  @override
  Future<String?> getWalletPercentage(TokenMetaData tokenMetaData) async{
    try {
      dioClient.options.headers['Authorization'] = tokenMetaData.token;
      var response = await dioClient.get(
        "${NetworkConfig.BASE_URL}common/dhoro/percentage",
      );
      final responseData = WalletPercentage.fromJson(response.data);
      print("getWalletPercentage from Remote layer:: $responseData");
      return responseData.data.toString();
    } catch (error) {
      handleError(error);
    }
  }

  @override
  Future<List<PaymentProcessorData>?> getPaymentProcessors(TokenMetaData tokenMetaData) async{
    try {
      dioClient.options.headers['Authorization'] = tokenMetaData.token;
      var response = await dioClient.get(
        "${NetworkConfig.BASE_URL}user/payment/fetch",
      );
      final responseData = PaymentProcessorResponse.fromJson(response.data);
      print("getPaymentProcessors from Remote layer:: ${responseData.data} response:$response");
      return responseData.data;
    } catch (error) {
      handleError(error);
    }
  }

  @override
  Future<MessageResponse?> deletePaymentProcessor(String pk, TokenMetaData tokenMetaData) async{
    try {
      dioClient.options.headers['Authorization'] = tokenMetaData.token;
      var response = await dioClient.delete(
        "${NetworkConfig.BASE_URL}user/payment/delete/$pk",
      );
      final responseData = MessageResponse.fromJson(response.data);
      print("getPaymentProcessors from Remote layer:: ${responseData.message}");
      return responseData;
    } catch (error) {
      handleError(error);
    }
  }

  @override
  Future<List<RequestData>?> getRequests(TokenMetaData tokenMetaData) async {
    try {
      dioClient.options.headers['Authorization'] = tokenMetaData.token;
      var response = await dioClient.get(
        "${NetworkConfig.BASE_URL}user/request",
      );
      final responseData = RequestResponse.fromJson(response.data);
      print("getRequests from Remote layer:: ${responseData.results?.data} response:$response");
      return responseData.results?.data;
    } catch (error) {
      handleError(error);
    }
  }

  @override
  Future<GetUserData?> updateUserProfile(TokenMetaData tokenMetaData, String firstName, String lastName, String phoneNumber) async{
    try {
      var _data = {
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber
      };
      dioClient.options.headers['Authorization'] = tokenMetaData.token;
      var response = await dioClient.put(
          "${NetworkConfig.BASE_URL}user/profile/update", data: _data
      );
      final responseData = GetUserResponse.fromJson(response.data);
      print("updateUserProfile from Remote layer:: $responseData");
      return responseData.data;
    } catch (error) {
      handleError(error);
    }
  }

  @override
  Future<PaymentProcessorData?> addPaymentProcessors(TokenMetaData tokenMetaData, String bankName, String userName, String accountNumber) async{
    try {
      var _data = {
        'processor': bankName,
        'label': userName,
        'value': accountNumber
      };
      dioClient.options.headers['Authorization'] = tokenMetaData.token;
      var response = await dioClient.post(
          "${NetworkConfig.BASE_URL}user/payment/create", data: _data
      );
      final responseData = AddPaymentProcessorResponse.fromJson(response.data);
      print("addPaymentProcessors from Remote layer:: $responseData");
      return responseData.data;
    } catch (error) {
      handleError(error);
    }
  }

  @override
  Future<GetUserData?> addAvatar(TokenMetaData tokenMetaData, String avatar) async{
    try {
      var _data = {
        'avatar': avatar,
      };
      dioClient.options.headers['Authorization'] = tokenMetaData.token;
      var response = await dioClient.post(
          "${NetworkConfig.BASE_URL}user/profile/avatar/update", data: _data
      );
      final responseData = GetUserResponse.fromJson(response.data);
      print("addAvatar from Remote layer:: $responseData");
      return responseData.data;
    } catch (error) {
      handleError(error);
    }
  }





}