import 'dart:io';

import 'package:dhoro_mobile/data/core/table_constants.dart';
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/rate/rate.dart';
import 'package:dhoro_mobile/data/remote/model/transfer_history/transfer_history_data.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/data/remote/model/user/logged_in_user.dart';
import 'package:dhoro_mobile/data/remote/model/user/user_wallet_balance_model.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_percentage/wallet_percentage.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_status.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_status/wallet_status.dart';
import 'package:dhoro_mobile/data/repository/user_repository.dart';
import 'package:dhoro_mobile/domain/model/user/user.dart';
import 'package:dhoro_mobile/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../main.dart';
import 'base/base_view_model.dart';

class OverviewViewModel extends BaseViewModel {
  final userRepository = locator<UserRepository>();
  //LoggedInUser? user;
  GetUserData? user;
  List<TransferHistoryData> transferHistory = [];
  WalletData? walletData;
  RateData? rateData;
  bool? walletStatus;
  //WalletPercentage? walletPercentage;
  String? walletPercentage;
  MessageResponse? lockUnlock;
  ViewState _state = ViewState.Idle;
  ViewState get viewState => _state;
  String? errorMessage;
  String email = "";
  String password = "";
  bool isValidLogin = false;
  bool isHidePassword = true;
  bool isLoggedIn = false;

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
      // await showTopModalSheet<String>(
      //     context: context,
      //     child: ShowDialog(
      //       title: '$error',
      //       isError: true,
      //       onPressed: () {},
      //     ));
    }
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
  }

  Future<TransferHistoryData?> getTransferHistory() async {
    try {
      setViewState(ViewState.Loading);
      var response = await userRepository.getTransferHistory();
      transferHistory = response ?? [];
      print("transferHistory $transferHistory");
      setViewState(ViewState.Success);
      print("Success transferHistory $transferHistory");
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
  }

  void updateLoginStatus(bool status) async {
    final box = await Hive.openBox<bool>(DbTable.LOGIN_TABLE_NAME);
    box.add(status);
  }

}
