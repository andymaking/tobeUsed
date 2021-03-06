
import 'dart:convert';

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
import 'package:dio/dio.dart';

abstract class UserRemote {
  Future<UserLoginResponse?> login(String email, String password);
  Future<String?> register(
      String firstname,
      String lastname,
      String email,
      String password,
      );
  Future<String?> verifyAccount(String otp);
  Future<WalletData?> getWalletBalance(TokenMetaData tokenMetaData);
  Future<List<TransferHistoryData>?> getTransferHistory(TokenMetaData tokenMetaData, int page, int pageSize);
  Future<List<TransferHistoryData>?> getTransferHistoryQuery(TokenMetaData tokenMetaData, String query);
  Future<GetUserData?> getUser(TokenMetaData tokenMetaData);
  Future<String?> changePassword(TokenMetaData tokenMetaData,String oldPassword, String newPassword);
  Future<WalletStatusMessage?> getWalletStatus(TokenMetaData tokenMetaData);
  Future<LockAndUnlockWalletResponse?> lockOrUnlockWallet(bool status, TokenMetaData tokenMetaData);
  Future<String?> getWalletPercentage(TokenMetaData tokenMetaData);
  Future<List<PaymentProcessorData>?> getPaymentProcessors(TokenMetaData tokenMetaData);
  Future<MessageResponse?> deletePaymentProcessor(String pk,TokenMetaData tokenMetaData);
  Future<List<RequestData>?> getRequests(TokenMetaData tokenMetaData, int page);
  Future<List<RequestData>?> getRequestsQuery(TokenMetaData tokenMetaData, String query);
  Future<GetUserData?> updateUserProfile(TokenMetaData tokenMetaData,String firstName, String lastName, String phoneNumber);
  Future<PaymentProcessorData?> addPaymentProcessors(TokenMetaData tokenMetaData,String bankName, String userName, String accountNumber);
  Future<GetUserData?> addAvatar(TokenMetaData tokenMetaData,String avatar);
  Future<RateData?> getRate();
  Future<ConvertData?> convertCurrency(String queryParams);
  Future<ConvertData?> convertBuyCurrency(String queryParams);
  Future<List<AgentsData>?> getAgents(TokenMetaData tokenMetaData);
  Future<AgentsData?> getSingleAgent(TokenMetaData tokenMetaData, String pk);
  Future<WithdrawData?> buyDhoro(TokenMetaData tokenMetaData, String value, String agent, String proofOfPayment, String currencyType);
  Future<WithdrawData?> withdrawDhoro(TokenMetaData tokenMetaData, double amount, String currencyType, String paymentMethod, String agent);
  Future<SendDhoroStatus?> sendDhoro(TokenMetaData tokenMetaData,String amount, String currencyType, String wid);
  Future<ClaimAirdropResponse?> claimAirdrop(String wid,TokenMetaData tokenMetaData);
  Future<AirdropInfoData?> getAirdropInfo(TokenMetaData tokenMetaData);
  Future<AvatarResponse?> getAvatar(TokenMetaData tokenMetaData);
  Future<ValidateBuyResponse?> validateBuyDhoro(String amount, String currencyType);
  Future<ValidateWithdrawResponse?> validateWithdrawDhoro(String amount, String currencyType);
  Future<AirdropStatusData?> getAirdropStatus(TokenMetaData tokenMetaData);
  Future<MessageResponse?> forgotPassport(String email);

}

void handleError(dynamic error) {
  var errorString = error.response.toString();
  if (error is DioError) {
    final errorMessage = DioExceptions.fromDioError(error).toString();
    throw errorMessage;
  } else {
    var json = jsonDecode(errorString);
    var nameJson = json['message'];

    throw nameJson;
  }
}

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.other:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        message = _handleError(
            dioError.response?.statusCode ?? 444, dioError.response?.data);
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String message = "";

  String _handleError(int statusCode, dynamic error) {
    if (statusCode >= 400 && statusCode <= 409)
      return error["message"];
    else if (statusCode >= 500 && statusCode <= 509)
      return 'Internal server error';
    else return error["message"];
  }


  @override
  String toString() => message;
}
