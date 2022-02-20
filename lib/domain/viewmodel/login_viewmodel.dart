import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:dhoro_mobile/data/core/table_constants.dart';
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/data/remote/model/user/logged_in_user.dart';
import 'package:dhoro_mobile/data/repository/user_repository.dart';
import 'package:dhoro_mobile/domain/model/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/remote/model/wallet_status.dart';
import '../../main.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/toast.dart';
import 'base/base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  final userRepository = locator<UserRepository>();
  //LoggedInUser? user;
  GetUserData? user;
  MessageResponse? messageResponse;
  ViewState _state = ViewState.Idle;
  ViewState get viewState => _state;
  String? errorMessage;
  String email = "";
  String password = "";
  bool isValidLogin = false;
  bool isValidForgotPassword = false;
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

  void validateForgotPassword() {
    isValidForgotPassword = isValidEmail();
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
      print("Showing error response::: $error");
      setViewState(ViewState.Error);
      setError(error.toString());
    }
  }

  /// login user
  Future<MessageResponse?> forgotPassword(BuildContext context, String email) async {
    try {
      setViewState(ViewState.Loading);
      var forgotResponse = await userRepository.forgotPassport(email);
      setViewState(ViewState.Success);
      if (Platform.isAndroid) {
        AndroidIntent intent = AndroidIntent(
          action: 'android.intent.action.MAIN',
          category: 'android.intent.category.APP_EMAIL',
        );
        intent.launch().catchError((e) {
          ;
        });
      } else if (Platform.isIOS) {
        launch("message://").catchError((e){
          setViewState(ViewState.Error);
          setError(e.toString());
        });
      }
      showToast("${forgotResponse?.message}");
      print("Showing forgotPassword response::: $forgotResponse");
      return forgotResponse;
    } catch (error) {
      await showTopModalSheet<String>(
          context: context,
          child: ShowDialog(
            title: error.toString(),
            isError: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ));
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

  void updateLoginStatus(bool status) async {
    final box = await Hive.openBox<bool>(DbTable.LOGIN_TABLE_NAME);
    box.add(status);
  }

}
