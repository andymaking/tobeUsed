import 'dart:io';

import 'package:dhoro_mobile/data/core/table_constants.dart';
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/airdrop/airdrop_info.dart';
import 'package:dhoro_mobile/data/remote/model/airdrop/claim_airdrop.dart';
import 'package:dhoro_mobile/data/remote/model/convert/withdraw/convert.dart';
import 'package:dhoro_mobile/data/remote/model/rate/rate.dart';
import 'package:dhoro_mobile/data/remote/model/send_dhoro/send_dhoro.dart';
import 'package:dhoro_mobile/data/remote/model/transfer_history/transfer_history_data.dart';
import 'package:dhoro_mobile/data/remote/model/transfer_history/transfer_history_response.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/data/remote/model/user/logged_in_user.dart';
import 'package:dhoro_mobile/data/remote/model/user/user_wallet_balance_model.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_percentage/wallet_percentage.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_status.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_status/wallet_status.dart';
import 'package:dhoro_mobile/data/repository/user_repository.dart';
import 'package:dhoro_mobile/domain/model/user/user.dart';
import 'package:dhoro_mobile/ui/overview/send.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/constant.dart';
import 'package:dhoro_mobile/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../../main.dart';
import 'base/base_view_model.dart';

class OverviewViewModel extends BaseViewModel {
  final userRepository = locator<UserRepository>();
  //LoggedInUser? user;
  GetUserData? user;
  List<TransferHistoryData> transferHistory = [];
  TransferHistoryDataResponse? transferHistoryDataResponse;
  WalletData? walletData;
  RateData? rateData;
  ConvertData? convertData;
  SendDhoroStatus? sendDhoroStatus;
  ClaimAirdropResponse? messageResponse;
  AirdropInfoData? airdropInfoData;
  bool? walletStatus;
  //WalletPercentage? walletPercentage;
  String? walletPercentage;
  MessageResponse? lockUnlock;
  ViewState _state = ViewState.Idle;
  ViewState get viewState => _state;
  String sendAmount = "";
  String walletId = "";
  String? errorMessage;
  String email = "";
  String popupSelection = "";
  String password = "";
  bool isValidSendAmount = false;
  bool isValidLogin = false;
  bool isHidePassword = true;
  bool isLoggedIn = false;
  bool shouldFetchNextPage = true;
  int offset = 1;
  int? lastPage;
  ScrollController? _controller;

  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  void validateLogin() {
    isValidLogin = isValidEmail() && isValidPassword();
    notifyListeners();
  }

  void isUserLoggedIn() {
    isLoggedIn = !isLoggedIn;
    notifyListeners();
  }

  void togglePassword() {
    isHidePassword = !isHidePassword;
    notifyListeners();
  }

  bool isValidEmail() {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    return regex.hasMatch(email);
  }

  bool isValidPassword() {
    return password.isNotEmpty && password.length >= 7;
  }

  void validateSendAmount() {
    isValidSendAmount = isValidAmount() && isValidWalletId();
    notifyListeners();
  }

  bool isValidAmount() {
    return sendAmount.isNotEmpty;
  }

  bool isValidWalletId() {
    return walletId.isNotEmpty && walletId.length >= 26;
  }

  /// user walletBalance
  Future<WalletData?> walletBalance() async {
    try {
      setViewState(ViewState.Loading);
      var walletBalanceResponse = await userRepository.walletBalance();
      setViewState(ViewState.Success);
      print("Showing walletBalance response::: $walletBalanceResponse");
      walletData = walletBalanceResponse;
      return walletBalanceResponse;
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
    notifyListeners();
  }

  /// user walletBalance
  Future<MessageResponse?> lockOrUnlockWallet(status, BuildContext context) async {
    try {
      setViewState(ViewState.Loading);
      var response = await userRepository.lockOrUnlockWallet(status);
      setViewState(ViewState.Success);
      await getWalletStatus();
      print("Showing lockOrUnlockWallet response::: $response");
      lockUnlock = response;
      return response;
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
      await showTopModalSheet<String>(
          context: context,
          child: ShowDialog(
            title: '$error',
            isError: true,
            onPressed: () {},
          ));
    }
    notifyListeners();
  }

  /// user walletBalance
  Future<WalletStatusMessage?> getWalletStatus() async {
    try {
      setViewState(ViewState.Loading);
      var response = await userRepository.getWalletStatus();
      setViewState(ViewState.Success);
      print("Showing getWalletStatus response::: $response");
      walletStatus = response?.status;
      return response;
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
    notifyListeners();
  }

  /// dhoro rate
  Future<RateData?> getRate() async {
    try {
      setViewState(ViewState.Loading);
      var response = await userRepository.getRate();
      setViewState(ViewState.Success);
      print("Showing getRate response::: $response");
      rateData = response;
      return response;
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
    notifyListeners();
  }

  /// user walletBalance
  Future<String?> getWalletPercentage() async {
    try {
      setViewState(ViewState.Loading);
      var response = await userRepository.getWalletPercentage();
      print("Showing getWalletPercentage response..::: $response");
      setViewState(ViewState.Success);
      print("Showing getWalletPercentage response::: $response");
      walletPercentage = response;
      print("Showing walletPercentage: $walletPercentage, response:$response");
      return response;
    } catch (error) {
      print("Error $error");
      setViewState(ViewState.Error);
      setError(error.toString());
    }
    notifyListeners();
  }


  Future<void> getTransferHistory() async {
    try {
      setViewState(ViewState.Loading);
      var response = await userRepository.getTransferHistory(1);
      transferHistory = response ?? [];
      print("transferHistory $transferHistory");
      setViewState(ViewState.Success);
      lastPage = await sharedPreference.getTransLastPage();
      print("Success transferHistory $transferHistory");
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
    notifyListeners();
  }

  Future<void> getTransferHistoryWithPaging(pageNumber) async {
    try {
      setViewState(ViewState.Loading);
      var response = await userRepository.getTransferHistory(pageNumber);
      transferHistory = response ?? [];
      print("transferHistory $transferHistory");
      setViewState(ViewState.Success);
      print("lastPage lastPage $lastPage");
      print("Success transferHistory $transferHistory");
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
  }

  Future<TransferHistoryData?> getTransferHistoryQuery(String query) async {
    try {
      setViewState(ViewState.Loading);
      var response = await userRepository.getTransferHistoryQuery(query);
      transferHistory = response ?? [];
      print("getTransferHistoryQuery $transferHistory");
      setViewState(ViewState.Success);
      print("Success getTransferHistoryQuery $transferHistory");
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
  }


  Future<GetUserData?> getUser() async {
    try {
      setViewState(ViewState.Loading);
      var response = 
      await userRepository.getUser();
      user = response;
      setViewState(ViewState.Success);
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
    notifyListeners();
  }

  /// Convert currency
  Future<ConvertData?> convertCurrency(String query) async {
    try {
      setViewState(ViewState.Loading);
      var response = await userRepository.convertCurrency(query);
      convertData = response;
      setViewState(ViewState.Success);
      print("Showing convertCurrency response::: $response");
      return response;
    } catch (error) {
      print("Showing error response::: $error");
      setViewState(ViewState.Error);
      setError(error.toString());
    }
  }

  /// Convert currency
  Future<SendDhoroStatus?> sendDhoro(BuildContext context, String amount, String currency, String wid) async {
    try {
      setViewState(ViewState.Loading);
      var response = await userRepository.sendDhoro(amount, currency, wid);
      sendDhoroStatus = response;
      setViewState(ViewState.Success);
      Navigator.pop(context);
      print("Showing sendDhoro response::: $response");
      showSuccessBottomSheet(context, "$amount $currency", wid);
      return response;
    } catch (error) {
      showFailedBottomSheet(context, error.toString(), "$amount $currency", wid);
      print("Showing error response::: $error");
      setViewState(ViewState.Error);
      setError(error.toString());
    }
  }

  /// Claim Airdrop
  Future<ClaimAirdropResponse?> claimAirdrop(BuildContext context, String wid) async {
    try {
      setViewState(ViewState.Loading);
      var response = await userRepository.claimAirdrop(wid);
      messageResponse = response;
      setViewState(ViewState.Success);
      Navigator.pop(context);
      print("Showing sendDhoro response::: $response");
      showClaimSuccessBottomSheet(context, "${messageResponse?.message}");
      return response;
    } catch (error) {
      showClaimFailedBottomSheet(context, error.toString(),);
      print("Showing error response::: $error");
      setViewState(ViewState.Error);
      setError(error.toString());
    }
  }

  Future<AirdropInfoData?> getAirdropInfo() async {
    try {
      setViewState(ViewState.Loading);
      var response =
      await userRepository.getAirdropInfo();
      airdropInfoData = response;
      setViewState(ViewState.Success);
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
    notifyListeners();
  }


}


showClaimSuccessBottomSheet(BuildContext context, String message) {
  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      builder: (context) => Container(
        height: 325,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 8,
            ),
            SvgPicture.asset("assets/images/top_indicator.svg"),
            SizedBox(
              height: 24,
            ),
            AppFontsStyle.getAppTextViewBold("Claim Airdrop",
                color: Pallet.colorBlue,
                weight: FontWeight.w700,
                size: AppFontsStyle.textFontSize16),
            SizedBox(
              height: 24,
            ),
            SvgPicture.asset("assets/images/ic_success_send.svg"),
            SizedBox(
              height: 16,
            ),
            Container(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pushNamed(AppRoutes.signUp);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12, top: 8),
                    child: Center(
                      child: AppFontsStyle.getAppTextViewBold(message,
                          color: Pallet.colorBlue,
                          weight: FontWeight.w500,
                          size: AppFontsStyle.textFontSize18),
                    ),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ));
}

showClaimFailedBottomSheet(
    BuildContext context, String message) {
  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      builder: (context) => Container(
        height: 325,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 8,
            ),
            SvgPicture.asset("assets/images/top_indicator.svg"),
            SizedBox(
              height: 24,
            ),
            AppFontsStyle.getAppTextViewBold("Claim Airdrop Failed",
                color: Pallet.colorBlue,
                weight: FontWeight.w700,
                size: AppFontsStyle.textFontSize16),
            SizedBox(
              height: 24,
            ),
            SvgPicture.asset("assets/images/ic_failed_send.svg"),
            SizedBox(
              height: 16,
            ),
            Container(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pushNamed(AppRoutes.signUp);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12, top: 8),
                        child: Center(
                          child: AppFontsStyle.getAppTextViewBold(message,
                              color: Pallet.colorBlue,
                              weight: FontWeight.w500,
                              size: AppFontsStyle.textFontSize18),
                        ),
                      ),
                    ),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ));
}