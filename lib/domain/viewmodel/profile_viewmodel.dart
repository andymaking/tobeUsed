import 'dart:io';

import 'package:dhoro_mobile/data/core/table_constants.dart';
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/data/remote/model/user/logged_in_user.dart';
import 'package:dhoro_mobile/data/remote/model/user/user_model.dart';
import 'package:dhoro_mobile/data/repository/user_repository.dart';
import 'package:dhoro_mobile/domain/model/user/user.dart';
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/widgets/custom_dialog.dart';
import 'package:dhoro_mobile/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../main.dart';
import 'base/base_view_model.dart';

class ProfileViewModel extends BaseViewModel {
  final userRepository = locator<UserRepository>();
  //LoggedInUser? user;
  GetUserData? user;
  AvatarResponse? avatarResponse;

  ViewState _state = ViewState.Idle;
  ViewState get viewState => _state;
  String? errorMessage;
  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  bool isValidProfile = false;

  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  void validateProfile() {
    isValidProfile = isValidFirstName() && isValidLastName() && isValidPhoneNumber();
    notifyListeners();
  }

  bool isValidFirstName() {
    return firstName.isNotEmpty && firstName.length >= 2;
  }

  bool isValidLastName() {
    return lastName.isNotEmpty && lastName.length >= 2;
  }

  bool isValidPhoneNumber() {
    return phoneNumber.isNotEmpty && phoneNumber.length >= 9;
  }

  Future<GetUserData?> getUser() async {
    try {
      setViewState(ViewState.Loading);
      var response = 
      await userRepository.getUser();
      setViewState(ViewState.Success);
      user = response;
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
    //notifyListeners();
  }

  Future<AvatarResponse?> getAvatar() async {
    try {
      setViewState(ViewState.Loading);
      var response =
      await userRepository.getAvatar();
      avatarResponse = response;
      setViewState(ViewState.Success);
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
    notifyListeners();
  }

  Future<GetUserData?> updateUserProfile(BuildContext context, String firstName, String lastName,String phoneNumber) async {
    try {
      setViewState(ViewState.Loading);
      var response =
      await userRepository.updateUserProfile(firstName, lastName, phoneNumber);
      user = response;
      setViewState(ViewState.Success);
      await getUser();
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.dashboard, (route) => false);
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
    notifyListeners();
  }

  Future<GetUserData?> addAvatar(BuildContext context, String avatar) async {
    try {
      setViewState(ViewState.Loading);
      var response =
      await userRepository.addAvatar(avatar);
      setViewState(ViewState.Success);
      user = response;
      showToast("Photo uploaded successfully");
      getUser();
      getAvatar();
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
      setViewState(ViewState.Error);
      setError(error.toString());
    }
  }


  void updateLoginStatus(bool status) async {
    final box = await Hive.openBox<bool>(DbTable.LOGIN_TABLE_NAME);
    box.add(status);
  }

}
