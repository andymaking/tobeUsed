import 'dart:io';

import 'package:dhoro_mobile/data/core/table_constants.dart';
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/data/remote/model/user/logged_in_user.dart';
import 'package:dhoro_mobile/data/repository/user_repository.dart';
import 'package:dhoro_mobile/domain/model/user/user.dart';
import 'package:hive/hive.dart';

import '../../main.dart';
import 'base/base_view_model.dart';

class VerifyAccountViewModel extends BaseViewModel {
  final userRepository = locator<UserRepository>();
  //LoggedInUser? user;
  GetUserData? user;
  ViewState _state = ViewState.Idle;
  ViewState get viewState => _state;
  String? errorMessage;
  String otp = "";
  bool isValidOTP = false;

  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  void validateVerify() {
    isValidOTP = isValidOtp();
    notifyListeners();
  }

  bool isValidOtp() {
    return otp.isNotEmpty && otp.length == 6;
  }

  /// verify a user
  Future<String?> verifyAccount(String otp) async {
    try {
      setViewState(ViewState.Loading);
      await userRepository.verifyAccount(otp);
      setViewState(ViewState.Success);
    } catch (error) {
      setViewState(ViewState.Error);
      print("Verification error::: $error");
      setError(error.toString());
    }
  }

  Future<void> getUser() async {
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
