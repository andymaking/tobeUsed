import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/convert/withdraw/convert.dart';
import 'package:dhoro_mobile/data/remote/model/payment_processor/payment_processor.dart';
import 'package:dhoro_mobile/data/remote/model/request/request_data.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/data/repository/user_repository.dart';
import 'package:dhoro_mobile/domain/viewmodel/base/base_view_model.dart';
import 'package:dhoro_mobile/main.dart';
import 'package:dhoro_mobile/ui/withdraw_dhoro/withdraw_account_details.dart';
import 'package:dhoro_mobile/ui/withdraw_dhoro/withdraw_amount.dart';
import 'package:dhoro_mobile/ui/withdraw_dhoro/withdraw_summary.dart';
import 'package:flutter/cupertino.dart';


class RequestViewModel extends BaseViewModel {
  final userRepository = locator<UserRepository>();
  PageController controller = PageController(
    initialPage: 0,
  );

  //LoggedInUser? loggedInUser;
  List<RequestData> requestList = [];
  ViewState _state = ViewState.Idle;
  ConvertData? convertData;
  List<PaymentProcessorData> paymentProcessor = [];
  GetUserData? user;

  ViewState get viewState => _state;
  //List<RequestData> userInterests = [];
  Set<String> currentUserGender = Set();
  Set<String> currentUserInterest = Set();
  Set<String> selectedPhoto = Set();
  String photoId = "";

  List<String> rightThreeImages = ["", "", ""];
  List<String> bottomFirstTwoImages = ["", ""];
  String primaryImage = "";
  List<String> images = [];
  String errorMessage = "";
  String amount = "";
  String bankName = "";
  String userName = "";
  String accountNumber = "";
  bool isWithdrawAmount = true;
  bool isBankDetails = true;

  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController genderControllerId = new TextEditingController();

  int currentPage = 0;

  final widgetPages = [
    Container(
        padding: EdgeInsets.only(bottom: 84), child: WithdrawAmountPage()),
    Container(
        padding: EdgeInsets.only(bottom: 84), child: WithdrawAccountDetailsPage()),
    Container(
        padding: EdgeInsets.only(bottom: 84), child: WithdrawSummaryPage()),

  ];
  late var pages = _initWidgetPages();
  late var pagesAnswers = _initSetupAnswers();

  List<bool> _initWidgetPages() {
    return List<bool>.filled(widgetPages.length, false, growable: false);
  }

  void moveToNextPage() {
    controller.jumpToPage(currentPage + 1);
  }

  void moveToPreviousPage() {
    controller.jumpToPage(currentPage - 1);
  }

  List<dynamic> _initSetupAnswers() {
    return List<dynamic>.filled(widgetPages.length, null, growable: false);
  }

  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  void pageChanged(int position) {
    currentPage = position;
    notifyListeners();
  }

  void pageValidated(bool validated) {
    pages[currentPage] = validated;
    notifyListeners();
  }

  void updatePageAnswers(dynamic answer) {
    pagesAnswers[currentPage] = answer;
    notifyListeners();
  }

  dynamic getCurrentPageAnswer() {
    final index = currentPage;
    return pagesAnswers[index];
  }

  void validateWithdrawAmount() {
    isWithdrawAmount = isValidAmount();
    notifyListeners();
  }

  bool isValidAmount() {
    return amount.isNotEmpty && amount.length >= 1;
  }

  void validateBankDetails() {
    isBankDetails = isValidAmount();
    notifyListeners();
  }

  bool isValidBankDetails() {
    return amount.isNotEmpty && amount.length >= 1;
  }

  Future<RequestData?> getRequest() async {
    try {
      setViewState(ViewState.Loading);
      var response = await userRepository.getRequests();
      requestList = response ?? [];
      print("getRequest $requestList");
      setViewState(ViewState.Success);
      print("Success getRequest $requestList");
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
  }

  /// Convert currency
  Future<ConvertData?> convertCurrency(String query) async {
    try {
      setViewState(ViewState.Loading);
      var loginResponse = await userRepository.convertCurrency(query);
      convertData = loginResponse;
      setViewState(ViewState.Success);
      print("Showing convertCurrency response::: $loginResponse");
      return loginResponse;
    } catch (error) {
      print("Showing error response::: $error");
      setViewState(ViewState.Error);
      setError(error.toString());
    }
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
