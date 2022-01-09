import 'dart:io';

import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/convert/withdraw/convert.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/data/repository/user_repository.dart';
import '../../main.dart';
import 'base/base_view_model.dart';

class WithdrawViewModel extends BaseViewModel {
  final userRepository = locator<UserRepository>();

  GetUserData? user;

  ViewState _state = ViewState.Idle;
  ViewState get viewState => _state;
  String? errorMessage;
  String amount = "";
  bool isAmountValid = false;

  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  void validateAmount() {
    isAmountValid = isValidAmount();
    notifyListeners();
  }

  bool isValidAmount() {
    return amount.isNotEmpty;
  }

  /// Convert currency
  Future<ConvertData?> convertCurrency(String query) async {
    try {
      setViewState(ViewState.Loading);
      var loginResponse = await userRepository.convertCurrency(query);
      setViewState(ViewState.Success);
      print("Showing convertCurrency response::: $loginResponse");
      return loginResponse;
    } catch (error) {
      print("Showing error response::: $error");
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
      //print("User Info::: $user");
      setViewState(ViewState.Success);
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
  }

}
