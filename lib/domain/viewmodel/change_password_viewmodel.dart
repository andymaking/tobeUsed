
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/data/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../main.dart';
import 'base/base_view_model.dart';

class ChangePasswordViewModel extends BaseViewModel {
  final userRepository = locator<UserRepository>();
  GetUserData? user;

  ViewState _state = ViewState.Idle;
  ViewState get viewState => _state;
  String? errorMessage;
  String newPassword = "";
  String oldPassword = "";
  bool isValidChangePassword = false;

  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  void validateChange() {
    isValidChangePassword = isValidPassword() && isValidNewPassword();
    notifyListeners();
  }

  bool isValidNewPassword(){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(newPassword);
  }

  bool isValidPassword() {
    return oldPassword.isNotEmpty && oldPassword.length >= 7;
  }

  /// change user password
  Future<String?> changePassword(BuildContext context,String oldPassword, String newPassword) async {
    try {
      setViewState(ViewState.Loading);
      var loginResponse = await userRepository.changePassword(oldPassword, newPassword);
      setViewState(ViewState.Success);
      //getUser();
      print("Showing changePassword response::: $loginResponse");
      return loginResponse;
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
  }

  Future<void> getUser() async {
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
