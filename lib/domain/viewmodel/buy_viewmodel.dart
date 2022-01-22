import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/agents/agent.dart';
import 'package:dhoro_mobile/data/remote/model/convert/withdraw/convert.dart';
import 'package:dhoro_mobile/data/remote/model/payment_processor/payment_processor.dart';
import 'package:dhoro_mobile/data/remote/model/request/request_data.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/data/remote/model/withdraw/withdraw.dart';
import 'package:dhoro_mobile/data/repository/user_repository.dart';
import 'package:dhoro_mobile/domain/viewmodel/base/base_view_model.dart';
import 'package:dhoro_mobile/main.dart';
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/ui/buy_dhoro/buy_amount.dart';
import 'package:dhoro_mobile/ui/buy_dhoro/buy_checkout.dart';
import 'package:dhoro_mobile/ui/buy_dhoro/buy_payment.dart';
import 'package:dhoro_mobile/widgets/custom_dialog.dart';
import 'package:dhoro_mobile/widgets/toast.dart';
import 'package:flutter/cupertino.dart';


class BuyViewModel extends BaseViewModel {
  final userRepository = locator<UserRepository>();
  PageController controller = PageController(
    initialPage: 0,
  );

  List<RequestData> requestList = [];
  ViewState _state = ViewState.Idle;
  ConvertData? convertCurrency;
  List<PaymentProcessorData> paymentProcessor = [];
  List<AgentsData> agents = [];
  AgentsData? anAgents;
  WithdrawData? purchase;
  GetUserData? user;


  ViewState get viewState => _state;
  Set<String> currentUserAgent = Set();
  String selectedAgent = "";
  List<String> images = [];
  String errorMessage = "";

  String amount = "";
  String bankName = "";
  String userName = "";
  String agentId = "";
  String paymentId = "";
  String currencyType = "";
  String accountNumber = "";

  bool isBuyAmount = true;
  bool isBankDetails = true;

  int currentPage = 0;

  void disposeBuyDhoroControllers(){
    print("dispose Buy Dhoro");
    pagesAnswers = _initSetupAnswers();
    pages = _initWidgetPages();
    amount = "";
    agentId = "";
    currencyType = "";
    paymentId = "";
    isBuyAmount = false;
    currentPage = 0;
    controller = PageController(
      initialPage: 0,
    );
  }

  final widgetPages = [
    Container(
        padding: EdgeInsets.only(bottom: 20), child: BuyAmountPage()),
    Container(
        padding: EdgeInsets.only(bottom: 20), child: BuyCheckoutPage()),
    Container(
        padding: EdgeInsets.only(bottom: 20), child: BuyPaymentPage()),

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

  void validateBuyAmount() {
    isBuyAmount = isValidAmount();
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
      var response = await userRepository.getRequests(1);
      requestList = response ?? [];
      print("getRequest $requestList");
      setViewState(ViewState.Success);
      print("Success getRequest $requestList");
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
    notifyListeners();
  }

  /// Convert currency
  Future<ConvertData?> convertBuyCurrency(String query) async {
    try {
      setViewState(ViewState.Loading);
      var loginResponse = await userRepository.convertCurrency(query);
      setViewState(ViewState.Success);
      convertCurrency = loginResponse;
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
    notifyListeners();
  }

  /// get user getAgents
  Future<AgentsData?> getAgents() async {
    try {
      setViewState(ViewState.Loading);
      var response = await userRepository.getAgents();
      agents = response ?? [];
      print("Showing getAgents response::: $response");
      setViewState(ViewState.Success);
      print("Showing success getAgents response::: $agents");
      //return response;
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
    notifyListeners();
  }

  /// get user Agent
  Future<AgentsData?> getSingleAgents(String pk) async {
    try {
      setViewState(ViewState.Loading);
      var response = await userRepository.getSingleAgent(pk);
      setViewState(ViewState.Success);
      print("Showing getSingleAgents response::: $response");
      anAgents = response;
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
    notifyListeners();
  }

  /// purchase/buy dhoro
  Future<WithdrawData?> buyDhoro(BuildContext context) async {
    try {
      var value = amount;
      var agent = agentId;
      var currency = currencyType;
      var proofOfPayment = paymentId;

      setViewState(ViewState.Loading);
      var response = await userRepository.buyDhoro(value, agent, proofOfPayment, currency);
      purchase = response;
      print("Showing buyDhoro response::: $response");

      setViewState(ViewState.Success);
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.dashboard, (route) => false);
      showToast("Successfully bought Dhoro");
      //return response;
    } catch (error) {
      print("Showing buyDhoro error::: $error");
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


}
