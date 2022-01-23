import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/payment_processor/payment_processor.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_status.dart';
import 'package:dhoro_mobile/data/repository/user_repository.dart';
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/widgets/custom_dialog.dart';
import 'package:dhoro_mobile/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import '../../main.dart';
import 'base/base_view_model.dart';

class PaymentProcessorViewModel extends BaseViewModel {
  final userRepository = locator<UserRepository>();
  GetUserData? user;
  List<PaymentProcessorData> paymentProcessor = [];
  ViewState _state = ViewState.Idle;
  ViewState get viewState => _state;
  String? errorMessage;
  String bankName = "";
  String userName = "";
  String accountNumber = "";
  bool isValidAddPayment = false;

  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  void validateAddPayment() {
    isValidAddPayment = isValidBankName() && isValidUserName() && isValidAccountNumber();
    notifyListeners();
  }

  bool isValidBankName() {
    return bankName.isNotEmpty && bankName.length >= 3;
  }

  bool isValidUserName() {
    return userName.isNotEmpty && userName.length >= 2;
  }

  bool isValidAccountNumber() {
    return accountNumber.isNotEmpty && accountNumber.length >= 9;
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
    notifyListeners();
  }

  /// add user paymentProcessors
  Future<PaymentProcessorData?> addPaymentProcessor(BuildContext context, String bankName, String userName, String accountNumber) async {
    try {
      setViewState(ViewState.Loading);
      var response = await userRepository.addPaymentProcessors(bankName, userName, accountNumber);
      setViewState(ViewState.Success);
      getPaymentProcessor();
      showToast("Delete payment processor successful");
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.paymentProcessorList, (route) => false);
      print("Showing getPaymentProcessor response::: $response");
      //paymentProcessor = response;
      return response;
    } catch (error) {
      await showTopModalSheet<String>(
          context: context,
          child: ShowDialog(
            title: "$error",
            isError: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ));
      setViewState(ViewState.Error);
      setError(error.toString());
    }
  }

  /// delete Payment Processor
  Future<MessageResponse?> deletePaymentProcessor(String pk, BuildContext context) async {
    try {
      setViewState(ViewState.Loading);
      var response = await userRepository.deletePaymentProcessor(pk);
      setViewState(ViewState.Success);
      getPaymentProcessor();
      showToast("Delete payment processor successful");
      print("Showing deletePaymentProcessor: $response");
      return response;
    } catch (error) {
      print("Error $error");
      await showTopModalSheet<String>(
          context: context,
          child: ShowDialog(
            title: "$error",
            isError: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ));
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

}
