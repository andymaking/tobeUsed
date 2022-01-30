import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/transfer_history/transfer_history_data.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/domain/viewmodel/transactions_viewmodel.dart';
import 'package:dhoro_mobile/main.dart';
import 'package:dhoro_mobile/ui/overview/overview.dart';
import 'package:dhoro_mobile/ui/overview/transactions_details.dart';
import 'package:dhoro_mobile/ui/transactions/popup_view.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/change_statusbar_color.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/constant.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_progress_bar.dart';
import 'package:dhoro_mobile/widgets/app_text_field.dart';
import 'package:dhoro_mobile/widgets/app_toolbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final transactionsProvider =
    ChangeNotifierProvider.autoDispose<TransactionsViewModel>((ref) {
  ref.onDispose(() {});
  final viewModel = locator.get<TransactionsViewModel>();
  viewModel.getTransferHistory();
  viewModel.getUser();
  return viewModel;
});

final _transactionsStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(transactionsProvider).viewState;
});
final transactionsStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_transactionsStateProvider);
});

final _userTransfersProvider =
    Provider.autoDispose<List<TransferHistoryData>>((ref) {
  return ref.watch(transactionsProvider).transferHistory;
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
  int page = 1;
  int lastPage = 0;

  @override
  void initState() {
    super.initState();
    page = 1;
    context.read(transactionsProvider).getTransferHistory();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    page = 1;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //context.read(transactionsProvider).getTransferHistory();
    changeStatusAndNavBarColor(
        Pallet.colorWhite, Pallet.colorWhite, false, false);
    final viewState = useProvider(transactionsStateProvider);
    List<TransferHistoryData>? userTransactions =
        useProvider(userTransferProvider);
    GetUserData? userData = useProvider(transactionsProvider).user;
    final initials =
        "${userData?.firstName?[0] ?? ""}${userData?.lastName?[0] ?? ""}";
    print("Transaction pageSige ${userTransactions?.length}");

    setState(() {
      page = context.read(transactionsProvider).currentPaginationPage ?? 1;
    });

    return Scaffold(
      backgroundColor: Pallet.colorBackground,
      body: RefreshIndicator(
        color: Pallet.colorBlue,
        onRefresh: () {
          return Future.delayed(
              Duration(seconds: 1),
                  () {
                setState(() {
                  context.read(transactionsProvider).getTransferHistory();
                });
              });
        },
        child: SafeArea(
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
                              "Latest 12 from a total of ${userTransactions?.length} transactions",
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
                    userTransactions?.isNotEmpty == true
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 24.0, right: 24, bottom: 24),
                            child: viewState == ViewState.Loading
                                ? Padding(
                                  padding: const EdgeInsets.only(top: 140.0),
                                  child: Center(child: AppProgressBar()),
                                )
                                : Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(2)),
                                        color: const Color(0xfffffffff)),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: List.generate(
                                            userTransactions!.length, (index) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2.0),
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  TransactionList(() {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            TransactionsDetailsPage(
                                                                data:
                                                                    userTransactions[
                                                                        index]),
                                                      ),
                                                    );
                                                  },
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
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                          )
                        : buildEmptyView(),
                    viewState == ViewState.Loading ? Container()
                    : context.read(transactionsProvider).lastPage != null &&
                        context.read(transactionsProvider).lastPage! > 1
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              ///page = 1;
                              print("Pressed one");
                              context
                                  .read(transactionsProvider)
                                  .getTransferHistoryWithPaging(1);
                            });
                          },
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(
                                vertical: 2.5, horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Pallet.colorWhite,
                            ),
                            child: Center(
                              child: AppFontsStyle.getAppTextViewBold("First",
                                  size: AppFontsStyle.textFontSize16,
                                  color: Pallet.colorBlue),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              page -= 1;
                              print("Pressed:: $page");
                              context
                                  .read(transactionsProvider)
                                  .getTransferHistoryWithPaging(page);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/images/back_arrow.svg",
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Container(
                                height: 40,
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.5, horizontal: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Pallet.colorWhite,
                                ),
                                child: Center(
                                  child: AppFontsStyle.getAppTextViewBold(
                                      "${context.read(transactionsProvider).currentPaginationPage} of ${context.read(transactionsProvider).lastPage}",
                                      size: AppFontsStyle.textFontSize12,
                                      color: Pallet.colorBlue),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  page += 1;
                                  print("Pressed:: $page");
                                  context
                                      .read(transactionsProvider)
                                      .getTransferHistoryWithPaging(page);
                                });
                              }),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              page += 1;
                              print("Pressed:: $page");
                              context
                                  .read(transactionsProvider)
                                  .getTransferHistoryWithPaging(page);
                            });
                          },
                          child: SvgPicture.asset(
                            "assets/images/arrow_forward.svg",
                            width: 40,
                            height: 40,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () async {
                            var last = await sharedPreference.getTransLastPage();
                            page = last;
                            setState(() {
                              print("Pressed:: $last");
                              context
                                  .read(transactionsProvider)
                                  .getTransferHistoryWithPaging(last);
                            });
                          },
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(
                                vertical: 2.5, horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Pallet.colorWhite,
                            ),
                            child: Center(
                              child: AppFontsStyle.getAppTextViewBold("Last",
                                  size: AppFontsStyle.textFontSize16,
                                  color: Pallet.colorBlue),
                            ),
                          ),
                        ),
                      ],
                    ) : Container(),
                    SizedBox(
                      height: 16,
                    ),
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
                ? Center(child: AppProgressBar())
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
