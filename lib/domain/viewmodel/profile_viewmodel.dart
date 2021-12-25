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

class ProfileViewModel extends BaseViewModel {
  final userRepository = locator<UserRepository>();
  //LoggedInUser? user;
  GetUserData? user;

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

  /// login user
  Future<User?> login(String email, String password) async {
    try {
      setViewState(ViewState.Loading);
      var loginResponse = await userRepository.login(email, password);
      setViewState(ViewState.Success);
      //getUser();
      print("Showing Login response::: $loginResponse");
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

  void updateLoginStatus(bool status) async {
    final box = await Hive.openBox<bool>(DbTable.LOGIN_TABLE_NAME);
    box.add(status);
  }

}
