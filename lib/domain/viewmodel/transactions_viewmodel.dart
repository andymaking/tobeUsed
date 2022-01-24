import 'dart:io';

import 'package:dhoro_mobile/data/core/table_constants.dart';
import 'package:dhoro_mobile/data/core/view_state.dart';
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
import 'package:dhoro_mobile/utils/constant.dart';
import 'package:dhoro_mobile/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../main.dart';
import 'base/base_view_model.dart';

class TransactionsViewModel extends BaseViewModel {
  final userRepository = locator<UserRepository>();

  GetUserData? user;
  List<TransferHistoryData> transferHistory = [];
  TransferHistoryDataResponse? transferHistoryDataResponse;

  ViewState _state = ViewState.Idle;
  ViewState get viewState => _state;
  String? errorMessage;
  int? lastPage;
  int? currentPaginationPage;


  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }


  Future<void> getTransferHistory() async {
    try {
      print("transaction getTransferHistory");
      setViewState(ViewState.Loading);
      var response = await userRepository.getTransferHistory(1, 8);
      transferHistory = response ?? [];
      print("transferHistory $transferHistory");
      setViewState(ViewState.Success);
      lastPage = await sharedPreference.getTransLastPage();
      currentPaginationPage = await sharedPreference.getTransCurrentPage();
      print("Success transferHistory $transferHistory");
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
  }

  Future<void> getTransferHistoryWithPaging(pageNumber) async {
    try {
      setViewState(ViewState.Loading);
      var response = await userRepository.getTransferHistory(pageNumber, 8);
      transferHistory = response ?? [];
      print("transferHistory $transferHistory");
      setViewState(ViewState.Success);
      print("transaction getTransferHistory");
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
  }

}
