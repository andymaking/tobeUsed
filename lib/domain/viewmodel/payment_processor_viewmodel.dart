import 'dart:io';

import 'package:dhoro_mobile/data/core/table_constants.dart';
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/payment_processor/payment_processor.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/data/remote/model/user/logged_in_user.dart';
import 'package:dhoro_mobile/data/repository/user_repository.dart';
import 'package:dhoro_mobile/domain/model/user/user.dart';
import 'package:hive/hive.dart';

import '../../main.dart';
import 'base/base_view_model.dart';

class PaymentProcessorViewModel extends BaseViewModel {
  final userRepository = locator<UserRepository>();
  GetUserData? user;
  List<PaymentProcessorData> paymentProcessor = [];
  ViewState _state = ViewState.Idle;
  ViewState get viewState => _state;
  String? errorMessage;

  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  /// get user paymentProcessors
  Future<List<PaymentProcessorData>?> getPaymentProcessor() async {
    try {
      setViewState(ViewState.Loading);
      var response = await userRepository.getPaymentProcessors();
      setViewState(ViewState.Success);
      print("Showing getPaymentProcessor response::: $response");
      paymentProcessor = response ?? [];
      return response;
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
      setViewState(ViewState.Success);
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
  }

}
