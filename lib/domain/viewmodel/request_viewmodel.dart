import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/agents/agent.dart';
import 'package:dhoro_mobile/data/remote/model/convert/withdraw/convert.dart';
import 'package:dhoro_mobile/data/remote/model/payment_processor/payment_processor.dart';
import 'package:dhoro_mobile/data/remote/model/request/request_data.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/data/remote/model/user/user_wallet_balance_model.dart';
import 'package:dhoro_mobile/data/remote/model/withdraw/withdraw.dart';
import 'package:dhoro_mobile/data/repository/user_repository.dart';
import 'package:dhoro_mobile/domain/viewmodel/base/base_view_model.dart';
import 'package:dhoro_mobile/main.dart';
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/ui/withdraw_dhoro/withdraw_account_details.dart';
import 'package:dhoro_mobile/ui/withdraw_dhoro/withdraw_amount.dart';
import 'package:dhoro_mobile/ui/withdraw_dhoro/withdraw_summary.dart';
import 'package:dhoro_mobile/utils/constant.dart';
import 'package:dhoro_mobile/widgets/custom_dialog.dart';
import 'package:dhoro_mobile/widgets/toast.dart';
import 'package:flutter/cupertino.dart';


class RequestViewModel extends BaseViewModel {
  final userRepository = locator<UserRepository>();
  PageController controller = PageController(
    initialPage: 0,
  );

  List<RequestData> requestList = [];
  ViewState _state = ViewState.Idle;
  ConvertData? convertData;
  List<PaymentProcessorData> paymentProcessor = [];
  List<AgentsData> agents = [];
  WithdrawData? purchase;
  AgentsData? anAgents;
  GetUserData? user;
  WalletData? walletData;
  ViewState get viewState => _state;
  Set<String> currentUserGender = Set();
  Set<String> currentUserInterest = Set();
  Set<String> selectedPhoto = Set();
  String photoId = "";

  String errorMessage = "";
  String bankName = "";
  String userName = "";
  String accountNumber = "";
  bool isWithdrawAmount = true;
  bool isBankDetails = true;
  String amount = "";
  String agentId = "";
  String paymentId = "";
  String currencyType = "";
  int? lastPage;

  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController genderControllerId = new TextEditingController();

  int currentPage = 0;

  void disposeSellDhoroControllers(){
    print("dispose Buy Dhoro");
    pagesAnswers = _initSetupAnswers();
    pages = _initWidgetPages();
    amount = "";
    agentId = "";
    currencyType = "";
    paymentId = "";
    isWithdrawAmount = false;
    currentPage = 0;
    controller = PageController(
      initialPage: 0,
    );
  }

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
      var response = await userRepository.getRequests(1);
      print("getRequest $requestList");
      setViewState(ViewState.Success);
      requestList = response ?? [];
      lastPage = await sharedPreference.getRequestLastPage();
      print("Success viewModel getRequest $requestList");
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
  }
  Future<RequestData?> getRequestWithPaging(page) async {
    try {
      setViewState(ViewState.Loading);
      var response = await userRepository.getRequests(page);
      print("getRequest $requestList");
      setViewState(ViewState.Success);
      requestList = response ?? [];
      print("Success viewModel getRequest $requestList");
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
  }

  /// get request with query
  Future<RequestData?> getRequestQuery(String query) async {
    try {
      setViewState(ViewState.Loading);
      var response = await userRepository.getRequestsQuery(query);
      print("getRequestQuery $requestList");
      setViewState(ViewState.Success);
      requestList = response ?? [];
      print("Success viewModel getRequestQuery $requestList");
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
      setViewState(ViewState.Success);
      user = response;
      walletBalance();
      print("Showing withdraw user data::: $user");
      print("Showing withdraw getUser response::: $response");
      return response;
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
  }

  /// withdraw/sell dhoro
  Future<WithdrawData?> withdrawDhoro(BuildContext context) async {
    try {
      var value = amount;
      var agent = agentId;
      var currency = currencyType;
      var proofOfPayment = paymentId.isEmpty ? paymentProcessor.first.pk : paymentId;
      setViewState(ViewState.Loading);
      var response = await userRepository.withdrawDhoro(double.parse(value), currency, proofOfPayment!, agent);
      setViewState(ViewState.Success);
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.dashboard, (route) => false);
      showToast("Successfully withdrawn Dhoro");
      print("Showing withdrawDhoro response::: $response");
      purchase = response;
      return response;
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
  }

  /// user walletBalance
  Future<WalletData?> walletBalance() async {
    try {
      setViewState(ViewState.Loading);
      var walletBalanceResponse = await userRepository.walletBalance();
      setViewState(ViewState.Success);
      print("Showing walletBalance response::: $walletBalanceResponse");
      walletData = walletBalanceResponse;
      return walletBalanceResponse;
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
  }

}
