import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/transfer_history/transfer_history_data.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/domain/viewmodel/overview_viewmodel.dart';
import 'package:dhoro_mobile/main.dart';
import 'package:dhoro_mobile/ui/overview/overview.dart';
import 'package:dhoro_mobile/ui/transactions/popup_view.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_text_field.dart';
import 'package:dhoro_mobile/widgets/app_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final transactionsProvider =
    ChangeNotifierProvider.autoDispose<OverviewViewModel>((ref) {
  ref.onDispose(() {});
  final viewModel = locator.get<OverviewViewModel>();
  viewModel.getTransferHistory();
  viewModel.getUser();
  // viewModel.walletBalance();
  // viewModel.getWalletStatus();
  // viewModel.getWalletPercentage();
  return viewModel;
});

final _percentageProvider = Provider.autoDispose<String?>((ref) {
  return ref.watch(transactionsProvider).walletPercentage;
});
final percentageProvider = Provider.autoDispose<String?>((ref) {
  return ref.watch(_percentageProvider);
});

final _overviewStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(transactionsProvider).viewState;
});
final profileStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_overviewStateProvider);
});

final _userTransfersProvider =
    Provider.autoDispose<List<TransferHistoryData>>((ref) {
  return ref.watch(overviewProvider).transferHistory;
});
final userTransferProvider =
    Provider.autoDispose<List<TransferHistoryData>>((ref) {
  return ref.watch(_userTransfersProvider);
});

class TransactionsPage extends StatefulHookWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage>
    with WidgetsBindingObserver {
  TextEditingController _inputController = TextEditingController();
  bool focus = false;
  bool focusPopStatus = false;
  bool focusPopInput = false;
  String selectedOption = "Status";
  String selectedStatus = "DESTROY";
  String inputValue = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    context.read(transactionsProvider).getTransferHistory();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        focus = false;
        focusPopInput = false;
        focusPopStatus = false;
        print(
            "app in paused.. focus: $focus, focusPopInput: $focusPopInput, focusPopStatus: $focusPopStatus");
        break;
      case AppLifecycleState.detached:
        focus = false;
        focusPopInput = false;
        focusPopStatus = false;
        print(
            "app in detached.. focus: $focus, focusPopInput: $focusPopInput, focusPopStatus: $focusPopStatus");
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<TransferHistoryData>? userTransactions =
        useProvider(transactionsProvider).transferHistory;
    GetUserData? userData = useProvider(transactionsProvider).user;
    final initials =
        "${userData?.firstName?[0] ?? ""}${userData?.lastName?[0] ?? ""}";
    //FocusScopeNode currentFocus = FocusScope.of(context);

    return Scaffold(
      backgroundColor: Pallet.colorBackground,
      body: SafeArea(
        child: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  OverViewToolBar(
                    AppString.transactions,
                    userData?.avatar.toString() ?? "",
                    trailingIconClicked: () => null,
                    initials: initials,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(AppImages.icFilter),
                          SizedBox(
                            width: 8,
                          ),
                          AppFontsStyle.getAppTextViewBold(
                            "Latest 12 from a total of ${userTransactions.length} transactions",
                            weight: FontWeight.w500,
                            size: AppFontsStyle.textFontSize10,
                          ),
                          Spacer(),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  focus = !focus;
                                  focusPopInput = false;
                                  focusPopStatus = false;
                                  _inputController.text = "";
                                });
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset(AppImages.iconMenu),
                                ],
                              )),
                        ],
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  TransactionHeader(),
                  userTransactions.isNotEmpty == true
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 24.0, right: 24, bottom: 24),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                                color: const Color(0xfffffffff)),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(userTransactions.length,
                                    (index) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 2.0),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            TransactionList(
                                                () {},
                                                userTransactions[index]
                                                    .pk
                                                    .toString(),
                                                userTransactions[index]
                                                    .status
                                                    .toString(),
                                                userTransactions[index]
                                                    .amount
                                                    .toString(),
                                                userTransactions[index]
                                                    .send
                                                    .toString()),
                                            // SizedBox(
                                            //   height: 8,
                                            // ),
                                            Divider(
                                              height: 1,
                                              color: Pallet.colorBlue
                                                  .withOpacity(0.3),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        )
                      : buildEmptyView(),
                ],
              ),
            ]),
          ),
          Visibility(
            visible: focus == true,
            child: Padding(
              padding: const EdgeInsets.only(top: 110.0, right: 24),
              child: Align(
                  alignment: Alignment.topRight,
                  child: popView(
                    () {
                      setState(() {
                        print("pressed status");
                        focus = false;
                        focusPopInput = false;
                        selectedOption = "status";
                        focusPopStatus = !focusPopStatus;
                      });
                    },
                    () {
                      setState(() {
                        print("pressed Amount");
                        focus = false;
                        focusPopStatus = false;
                        selectedOption = "amount";
                        focusPopInput = !focusPopInput;
                      });
                    },
                    () {
                      setState(() {
                        print("pressed Sent from");
                        focus = false;
                        focusPopStatus = false;
                        focusPopInput = !focusPopInput;
                        selectedOption = "receive";
                      });
                    },
                    () {
                      setState(() {
                        print("pressed Sent to");
                        focus = false;
                        focusPopStatus = false;
                        focusPopInput = !focusPopInput;
                        selectedOption = "send";
                      });
                    },
                  )),
            ),
          ),
          Visibility(
            visible: focusPopStatus == true,
            child: Padding(
              padding: const EdgeInsets.only(top: 110.0, right: 24),
              child: Align(
                  alignment: Alignment.topRight,
                  child: statusPopView(
                    () {
                      setState(() {
                        print("pressed DESTROY");
                        selectedStatus = "DESTROY";
                        focusPopStatus = false;
                        context
                            .read(transactionsProvider)
                            .getTransferHistoryQuery(
                                "$selectedOption=$selectedStatus");
                      });
                    },
                    () {
                      setState(() {
                        print("pressed Received");
                        selectedStatus = "RECEIVED";
                        focusPopStatus = false;
                        context
                            .read(transactionsProvider)
                            .getTransferHistoryQuery(
                                "$selectedOption=$selectedStatus");
                      });
                    },
                  )),
            ),
          ),
          Visibility(
              visible: focusPopInput,
              child: Padding(
                padding: const EdgeInsets.only(top: 110.0, right: 24),
                child: Align(
                  alignment: Alignment.topRight,
                  child: inputPopView(
                      selectedOption.contains("amount")
                          ? "Enter Amount"
                          : selectedOption.contains("receive")
                              ? "Sent From Wallet ID"
                              : selectedOption.contains("send")
                                  ? "Sent to Wallet ID"
                                  : "", (value) {
                    setState(() {
                      inputValue = value.trim();
                      context
                          .read(transactionsProvider)
                          .getTransferHistoryQuery(
                              "$selectedOption=$inputValue");
                    });
                  }, (value) {
                    if (inputValue.isEmpty) {
                      return "Field can not be empty";
                    }
                    return null;
                  },
                      _inputController,
                      selectedOption.contains("amount")
                          ? TextInputType.numberWithOptions(decimal: true)
                          : TextInputType.text),
                ),
              )),
        ]),
      ),
    );
  }

  Widget popView(Function()? onPressedStatus, Function()? onPressedAmount,
      Function()? onPressedReceivedFrom, Function()? onPressedSentTo) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: Pallet.colorWhite,
        border: Border.all(width: 1.0, color: Pallet.colorBlue),
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            PopupView(
              title: "Status",
              onPressed: onPressedStatus,
            ),
            SizedBox(
              height: 16,
            ),
            PopupView(
              title: "Amount",
              onPressed: onPressedAmount,
            ),
            SizedBox(
              height: 16,
            ),
            PopupView(
              title: "Received from",
              onPressed: onPressedReceivedFrom,
            ),
            SizedBox(
              height: 16,
            ),
            PopupView(
              title: "Sent to",
              onPressed: onPressedSentTo,
            ),
            context.read(transactionsProvider).viewState == ViewState.Loading
                ? Center(child: CircularProgressIndicator())
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        focusPopStatus = false;
                        focus = false;
                        focusPopInput = false;
                        context.read(transactionsProvider).getTransferHistory();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: AppFontsStyle.getAppTextView("Clear filter",
                          size: 14,
                          textAlign: TextAlign.center,
                          color: Pallet.colorRed),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget statusPopView(
      Function()? onPressedDestroy, Function()? onPressedReceived) {
    return Container(
      height: 105,
      decoration: BoxDecoration(
        color: Pallet.colorWhite,
        border: Border.all(width: 1.0, color: Pallet.colorBlue),
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            PopupView(
              title: "DESTROY",
              onPressed: onPressedDestroy,
            ),
            SizedBox(
              height: 16,
            ),
            PopupView(
              title: "RECEIVED",
              onPressed: onPressedReceived,
            ),
          ],
        ),
      ),
    );
  }

  Widget inputPopView(
      String label,
      Function(String)? onChanged,
      FormFieldValidator<String>? validator,
      TextEditingController? controller,
      TextInputType? keyboardType) {
    return Container(
      //height: 55,
      width: 182,
      decoration: BoxDecoration(
        color: Pallet.colorWhite,
        //border: Border.all(width: 1.0, color: Pallet.colorBlue),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppFormField(
          label: label,
          width: MediaQuery.of(context).size.width - 50,
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          keyboardType: keyboardType,
          isHidden: false,
        ),
      ),
    );
  }

  Widget buildEmptyView() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100.0,
          ),
          Container(
            child: SvgPicture.asset("assets/images/ic_notifications.svg"),
          ),
          SizedBox(
            height: 24.0,
          ),
          AppFontsStyle.getAppTextViewBold("No transactions yet",
              size: 14, textAlign: TextAlign.center, color: Pallet.colorBlue),
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: AppFontsStyle.getAppTextView(
                "You might need to interact more.",
                size: 14,
                textAlign: TextAlign.center,
                color: Pallet.colorBlue),
          ),
        ],
      ),
    );
  }
}
