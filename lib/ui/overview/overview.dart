import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/airdrop/airdrop_info.dart';
import 'package:dhoro_mobile/data/remote/model/rate/rate.dart';
import 'package:dhoro_mobile/data/remote/model/transfer_history/transfer_history_data.dart';
import 'package:dhoro_mobile/data/remote/model/transfer_history/transfer_history_response.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/data/remote/model/user/user_wallet_balance_model.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_status.dart';
import 'package:dhoro_mobile/domain/viewmodel/overview_viewmodel.dart';
import 'package:dhoro_mobile/main.dart';
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/ui/overview/transactions_details.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/change_statusbar_color.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/constant.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_progress_bar.dart';
import 'package:dhoro_mobile/widgets/app_toolbar.dart';
import 'package:dhoro_mobile/widgets/custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final overviewProvider =
    ChangeNotifierProvider.autoDispose<OverviewViewModel>((ref) {
  ref.onDispose(() {});
  final viewModel = locator.get<OverviewViewModel>();
  viewModel.getUser();
  viewModel.getAirdropStatus();
  viewModel.getRate();
  viewModel.getAirdropInfo();
  viewModel.walletBalance();
  viewModel.getWalletStatus();
  viewModel.getWalletPercentage();
  viewModel.getTransferHistory();
  return viewModel;
});

final _walletProvider = Provider.autoDispose<WalletData?>((ref) {
  return ref.watch(overviewProvider).walletData;
});
final walletProvider = Provider.autoDispose<WalletData?>((ref) {
  return ref.watch(_walletProvider);
});

final _percentageProvider = Provider.autoDispose<String?>((ref) {
  return ref.watch(overviewProvider).walletPercentage;
});
final percentageProvider = Provider.autoDispose<String?>((ref) {
  return ref.watch(_percentageProvider);
});

final _overviewStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(overviewProvider).viewState;
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

class OverviewPage extends StatefulHookWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  bool isLock = false;
  bool claimedAirdrop = false;
  bool airdropStatus = false;

  TransferHistoryDataResponse? transferHistoryDataResponse;
  int page = 1;


  @override
  void initState() {
    setState(() {
      context.read(overviewProvider).getAirdropInfo();
      context.read(overviewProvider).getRate();
      context.read(overviewProvider).getWalletPercentage();
      context.read(overviewProvider).walletBalance();
      context.read(overviewProvider).getTransferHistory();
      context.read(overviewProvider).getUser();
      context.read(overviewProvider).getAirdropStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    changeStatusAndNavBarColor(
        Pallet.colorWhite, Pallet.colorWhite, false, false);

    ViewState viewState = useProvider(profileStateProvider);
    WalletData? walletBalance = useProvider(overviewProvider).walletData;
    bool? walletStatus = useProvider(overviewProvider).walletStatus;
    LockAndUnlockWalletResponse? lockUnlock = useProvider(overviewProvider).lockUnlock;
    GetUserData? userData = useProvider(overviewProvider).user;
    RateData? rateData = useProvider(overviewProvider).rateData;
    AirdropInfoData? airdropInfoData = useProvider(overviewProvider).airdropInfoData;
    AirdropStatusData? airdropStatusData = useProvider(overviewProvider).airdropStatusData;

    print("Showing airdropInfoData : ${airdropInfoData?.amount}");
    final initials =
        "${userData?.firstName?[0] ?? ""}${userData?.lastName?[0] ?? ""}";
    /*WalletPercentage?*/
    String? percentage = useProvider(overviewProvider).walletPercentage;
    /*WalletPercentage?*/
    String? percent = useProvider(percentageProvider);
    //isLock = walletStatus!;
    List<TransferHistoryData>? userTransactions =
        useProvider(overviewProvider).transferHistory;
    print("Showing wallet percentage:: $percentage");
    print("Showing TransferHistoryData:: $userTransactions");
    print("Showing walletStatus:: $walletStatus");
    print("Showing percent:: $percent");
    var dhrBalance = walletBalance?.dhrBalance?.toStringAsFixed(3);
    //var priceInDollar = double.parse("${rateData?.priceInDollar}");

    setState(() {
      print("airdropStatus :: $airdropStatus");
      claimedAirdrop = airdropInfoData?.claimed ?? true;
      airdropStatus = airdropStatusData?.status ?? true;

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
                  context.read(overviewProvider).getAirdropInfo();
                  context.read(overviewProvider).getRate();
                  context.read(overviewProvider).getUser();
                  context.read(overviewProvider).getWalletPercentage();
                  context.read(overviewProvider).walletBalance();
                  context.read(overviewProvider).getTransferHistory();
                });
              });
        },
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  OverViewToolBar(
                    AppString.overView,
                    userData?.avatar.toString() ?? "",
                    trailingIconClicked: () => null,
                    initials: initials,
                  ),
                  Visibility(
                    visible: claimedAirdrop == false && airdropStatus == true,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 23),
                        //height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Pallet.colorBlue),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            children: [
                              //$DHR Airdrop is live
                              AppFontsStyle.getAppTextViewBold(
                                "\$${airdropInfoData?.amount ?? 0} Airdrop is live",
                                weight: FontWeight.w600,
                                color: Pallet.colorWhite,
                                textAlign: TextAlign.center,
                                size: AppFontsStyle.textFontSize24,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                                child: AppFontsStyle.getAppTextViewBold(
                                  "Take part in the \$${airdropInfoData?.amount ?? 0} Airdrop and claim free \$${airdropInfoData?.amountPerAddress ?? 0} tokens",
                                  weight: FontWeight.w500,
                                  color: Pallet.colorWhite,
                                  textAlign: TextAlign.center,
                                  size: AppFontsStyle.textFontSize12,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: (){
                                  context.read(overviewProvider).claimAirdrop(context, "${userData?.wid}");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(2)),
                                      color: Pallet.colorWhite),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: AppFontsStyle.getAppTextViewBold(
                                      "CLAIM AIRDROP",
                                      weight: FontWeight.w600,
                                      color: Pallet.colorBlue,
                                      textAlign: TextAlign.center,
                                      size: AppFontsStyle.textFontSize12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22.0, vertical: 10),
                      height: 212,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: const Color(0xfffffffff)),
                      child: Column(
                        children: [
                          //walletStatus == true
                          !isLock
                              ? Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppFontsStyle.getAppTextViewBold(
                                        "${rateData?.equivalentInDhoro ?? 0} DHR = \$${rateData?.priceInDollar?.substring(0,4)}",
                                        weight: FontWeight.w600,
                                        size: AppFontsStyle.textFontSize12,
                                      ),
                                      Spacer(),
                                      SvgPicture.asset(AppImages.triangleUp),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      AppFontsStyle.getAppTextViewBold(
                                        "$percentage%",
                                        color: Pallet.colorDeepGreen,
                                        weight: FontWeight.w600,
                                        size: AppFontsStyle.textFontSize12,
                                      ),
                                    ],
                                  ),
                              )
                              : Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(AppImages.triangleUp),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      AppFontsStyle.getAppTextViewBold(
                                        "${context.read(overviewProvider).walletPercentage}%",
                                        color: Pallet.colorDeepGreen,
                                        weight: FontWeight.w600,
                                        size: AppFontsStyle.textFontSize12,
                                      ),
                                    ],
                                  ),
                              ),
                          SizedBox(
                            height: 23,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // wallet!.usdEquivalent != null
                                  // ?
                                  AppFontsStyle.getAppTextViewBold(
                                    "\$${walletBalance?.usdEquivalent ?? 0}",
                                    color: isLock //walletStatus != true
                                        ? Pallet.colorGrey
                                        : Pallet.colorBlue,
                                    weight: FontWeight.w600,
                                    size: AppFontsStyle.textFontSize24,
                                  ),
                                  Visibility(
                                    visible: isLock == true,
                                    //walletStatus == true,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: SvgPicture.asset(AppImages.icLock),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              AppFontsStyle.getAppTextViewBold(
                                "${dhrBalance ?? 0} DHR",
                                color:
                                    isLock ? Pallet.colorGrey : Pallet.colorBlue,
                                weight: FontWeight.w700,
                                size: AppFontsStyle.textFontSize16,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CupertinoButton(
                                  onPressed: (){
                                    !isLock ? Navigator.pushNamed(context, AppRoutes.send) : null;
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          AppImages.iconGreenArrowUp,
                                      color: isLock ? Pallet.colorGreen.withOpacity(0.5) : null),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      AppFontsStyle.getAppTextViewBold(
                                        "Send DHR",
                                        color: isLock ? Pallet.colorBlue.withOpacity(0.4) : null,
                                        weight: FontWeight.w500,
                                        size: AppFontsStyle.textFontSize10,
                                      ),
                                    ],
                                  ),
                                ),
                                CupertinoButton(
                                  onPressed: (){
                                    showReceiveBottomSheet(
                                        context,
                                        "${userData?.qrCode?.code}",
                                        "${userData?.wid}");
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(AppImages.redArrowDown),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      AppFontsStyle.getAppTextViewBold(
                                        "Receive DHR",
                                        weight: FontWeight.w500,
                                        size: AppFontsStyle.textFontSize10,
                                      ),
                                    ],
                                  ),
                                ),
                                CupertinoButton(
                                  onPressed: (){
                                    //print("print");
                                    observeLockAndUnlockState(context);
                                    setState(() {
                                      isLock = !isLock;
                                    });
                                  },
                                  child: isLock //walletStatus == true
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                              SvgPicture.asset(
                                                  AppImages.icUnlock),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              AppFontsStyle.getAppTextViewBold(
                                                "Unlock Wallet",
                                                weight: FontWeight.w500,
                                                size: AppFontsStyle
                                                    .textFontSize10,
                                              ),
                                            ])
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(AppImages.icLock),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            AppFontsStyle.getAppTextViewBold(
                                              "Lock Wallet",
                                              weight: FontWeight.w500,
                                              size:
                                                  AppFontsStyle.textFontSize10,
                                            ),
                                          ],
                                        ),
                                )
                              ])
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: AppFontsStyle.getAppTextViewBold(
                      AppString.recentTransactions,
                      weight: FontWeight.w700,
                      size: AppFontsStyle.textFontSize16,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TransactionHeader(),
                  userTransactions.isNotEmpty == true
                      ? viewState == ViewState.Loading
                          ? Center(child: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: AppProgressBar(),
                          ))
                          : Padding(
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
                                    children: List.generate(
                                        userTransactions.length, (index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 2.0),
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
                  if (context.read(overviewProvider).shouldFetchNextPage == true)
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {
                    //         setState(() {
                    //           print("Pressed one");
                    //           context
                    //               .read(overviewProvider)
                    //               .getTransferHistoryWithPaging(1);
                    //         });
                    //       },
                    //       child: Container(
                    //         height: 40,
                    //         padding: EdgeInsets.symmetric(
                    //             vertical: 2.5, horizontal: 16),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(2),
                    //           color: Pallet.colorWhite,
                    //         ),
                    //         child: Center(
                    //           child: AppFontsStyle.getAppTextViewBold("First",
                    //               size: AppFontsStyle.textFontSize16,
                    //               color: Pallet.colorBlue),
                    //         ),
                    //       ),
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {
                    //         setState(() {
                    //           page -= 1;
                    //           print("Pressed:: $page");
                    //           context
                    //               .read(overviewProvider)
                    //               .getTransferHistoryWithPaging(page);
                    //         });
                    //       },
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(left: 8.0),
                    //         child: Center(
                    //           child: SvgPicture.asset(
                    //             "assets/images/back_arrow.svg",
                    //             width: 40,
                    //             height: 40,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 8.0, right: 8),
                    //       child: CupertinoButton(
                    //           padding: EdgeInsets.zero,
                    //           child: Container(
                    //             height: 40,
                    //             padding: EdgeInsets.symmetric(
                    //                 vertical: 2.5, horizontal: 16),
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(2),
                    //               color: Pallet.colorWhite,
                    //             ),
                    //             child: Center(
                    //               child: AppFontsStyle.getAppTextViewBold(
                    //                   "1 of ${context.read(overviewProvider).lastPage}",
                    //                   size: AppFontsStyle.textFontSize12,
                    //                   color: Pallet.colorBlue),
                    //             ),
                    //           ),
                    //           onPressed: () {
                    //             setState(() {
                    //               page += 1;
                    //               print("Pressed:: $page");
                    //               context
                    //                   .read(overviewProvider)
                    //                   .getTransferHistoryWithPaging(page);
                    //             });
                    //           }),
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {
                    //         setState(() {
                    //           page += 1;
                    //           print("Pressed:: $page");
                    //           context
                    //               .read(overviewProvider)
                    //               .getTransferHistoryWithPaging(page);
                    //         });
                    //       },
                    //       child: SvgPicture.asset(
                    //         "assets/images/arrow_forward.svg",
                    //         width: 40,
                    //         height: 40,
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 8,
                    //     ),
                    //     GestureDetector(
                    //       onTap: () async {
                    //         var last = await sharedPreference.getTransLastPage();
                    //         setState(() {
                    //           print("Pressed:: $last");
                    //           context
                    //               .read(overviewProvider)
                    //               .getTransferHistoryWithPaging(last);
                    //         });
                    //       },
                    //       child: Container(
                    //         height: 40,
                    //         padding: EdgeInsets.symmetric(
                    //             vertical: 2.5, horizontal: 16),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(2),
                    //           color: Pallet.colorWhite,
                    //         ),
                    //         child: Center(
                    //           child: AppFontsStyle.getAppTextViewBold("Last",
                    //               size: AppFontsStyle.textFontSize16,
                    //               color: Pallet.colorBlue),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void observeSignUpState(BuildContext context) async {
    final overviewViewModel = context.read(overviewProvider);
    await overviewViewModel.getTransferHistory();
    if (overviewViewModel.viewState == ViewState.Success) {
      await showTopModalSheet<String>(
          context: context,
          child: ShowDialog(
            title:
                'Gotten User Info. ${overviewViewModel.transferHistory[0].pk}',
            isError: false,
            onPressed: () {},
          ));
    } else {
      await showTopModalSheet<String>(
          context: context,
          child: ShowDialog(
            title: 'Failed to get user info. ${overviewViewModel.errorMessage}',
            isError: true,
            onPressed: () {},
          ));
    }
  }

  void observeLockAndUnlockState(BuildContext context) async {
    final lockUnlockViewModel = context.read(overviewProvider);
    await lockUnlockViewModel.lockOrUnlockWallet(isLock, context);
  }

  void observePercentageState(BuildContext context) async {
    final viewModel = context.read(overviewProvider);
    await viewModel.getWalletPercentage();
    if (viewModel.viewState == ViewState.Success) {
      await showTopModalSheet<String>(
          context: context,
          child: ShowDialog(
            title: 'Percentage ${viewModel.walletPercentage}',
            isError: false,
            onPressed: () {},
          ));
    } else {
      await showTopModalSheet<String>(
          context: context,
          child: ShowDialog(
            title: 'Failed to get wallet percentage. ${viewModel.errorMessage}',
            isError: true,
            onPressed: () {},
          ));
    }
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
            height: 60.0,
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

  showReceiveBottomSheet(
      BuildContext context, String qrcode, String walletAddress) {
    showModalBottomSheet(
        elevation: 10,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        builder: (context) => Container(
          height: 435,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 8,
              ),
              SvgPicture.asset("assets/images/top_indicator.svg"),
              SizedBox(
                height: 24,
              ),
              AppFontsStyle.getAppTextViewBold("Deposit Dhoro",
                  color: Pallet.colorRed,
                  weight: FontWeight.w700,
                  size: AppFontsStyle.textFontSize16),
              SizedBox(
                height: 22,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  'https://api.dhoro.io$qrcode',
                  height: 116,
                  width: 116,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return SvgPicture.asset(
                      "assets/images/ic_error_qrcode.svg",
                      height: 116,
                      width: 116,
                      fit: BoxFit.contain,
                    );
                  },
                ),



                // CachedNetworkImage(
                //   height: 116,
                //   width: 116,
                //   fit: BoxFit.contain,
                //   imageUrl: "https://api.dhoro.io$qrcode",
                //   placeholder: (context, url) => SvgPicture.asset(
                //     "assets/images/ic_qrcode.svg",
                //     height: 116,
                //     width: 116,
                //     fit: BoxFit.contain,
                //   ),
                //   errorWidget: (context, url, error) => SvgPicture.asset(
                //     "assets/images/ic_error_qrcode.svg",
                //     height: 116,
                //     width: 116,
                //     fit: BoxFit.contain,
                //   ),
                // ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: AppFontsStyle.getAppTextViewBold(
                  "The sender can scan the QR code to send DHR or Dhoro tokens to this DHR wallet.",
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  size: AppFontsStyle.textFontSize12,
                ),
              ),
              SizedBox(
                height: 38,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Pallet.colorWhite,
                  border: Border.all(width: 1.0, color: Pallet.colorBlue),
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: AppFontsStyle.getAppTextViewBold(
                        walletAddress,
                        weight: FontWeight.w400,
                        size: AppFontsStyle.textFontSize12,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                              ClipboardData(text: walletAddress));
                          Fluttertoast.showToast(
                              msg: "Wallet ID copied to clipboard");
                          walletAddress.isNotEmpty
                              ? Fluttertoast.showToast(
                              msg: "Wallet ID copied to clipboard")
                              : Fluttertoast.showToast(
                              msg: "Nothing to copied to clipboard");
                        },
                        child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                              color: Pallet.buttonColor,
                              borderRadius:
                              BorderRadius.all(Radius.circular(2))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0),
                            child: Center(
                              child: AppFontsStyle.getAppTextViewBold(
                                  "Copy",
                                  weight: FontWeight.w400,
                                  textAlign: TextAlign.center,
                                  size: AppFontsStyle.textFontSize10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16),
                child: AppFontsStyle.getAppTextViewBold(
                  "This address can only be used to receive DHR or Dhoro tokens on the Dhoro network.",
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  size: AppFontsStyle.textFontSize12,
                ),
              ),
            ],
          ),
        ));
  }
}

showClaimAirdropBottomSheet(
    BuildContext context, String qrcode, String walletAddress) {
  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      builder: (context) => Container(
        height: 425,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 8,
            ),
            SvgPicture.asset("assets/images/top_indicator.svg"),
            SizedBox(
              height: 24,
            ),
            AppFontsStyle.getAppTextViewBold("Deposit Dhoro",
                color: Pallet.colorRed,
                weight: FontWeight.w700,
                size: AppFontsStyle.textFontSize16),
            SizedBox(
              height: 24,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(
                height: 116,
                width: 116,
                fit: BoxFit.contain,
                imageUrl: "https://api.dhoro.io$qrcode",
                placeholder: (context, url) => SvgPicture.asset(
                  "assets/images/ic_qrcode.svg",
                  height: 116,
                  width: 116,
                  fit: BoxFit.contain,
                ),
                errorWidget: (context, url, error) => SvgPicture.asset(
                  "assets/images/ic_error_qrcode.svg",
                  height: 116,
                  width: 116,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: AppFontsStyle.getAppTextViewBold(
                "The sender can scan the QR code to send DHR or Dhoro tokens to this DHR wallet.",
                weight: FontWeight.w400,
                textAlign: TextAlign.center,
                size: AppFontsStyle.textFontSize12,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Pallet.colorWhite,
                border: Border.all(width: 1.0, color: Pallet.colorBlue),
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: AppFontsStyle.getAppTextViewBold(
                      walletAddress,
                      weight: FontWeight.w400,
                      size: AppFontsStyle.textFontSize12,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: walletAddress));
                        Fluttertoast.showToast(
                            msg: "Wallet ID copied to clipboard");
                        walletAddress.isNotEmpty
                            ? Fluttertoast.showToast(
                            msg: "Wallet ID copied to clipboard")
                            : Fluttertoast.showToast(
                            msg: "Nothing to copied to clipboard");
                      },
                      child: Container(
                        height: 25,
                        decoration: BoxDecoration(
                            color: Pallet.buttonColor,
                            borderRadius:
                            BorderRadius.all(Radius.circular(2))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0),
                          child: Center(
                            child: AppFontsStyle.getAppTextViewBold(
                                "Copy",
                                weight: FontWeight.w400,
                                textAlign: TextAlign.center,
                                size: AppFontsStyle.textFontSize10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: AppFontsStyle.getAppTextViewBold(
                "This address can only be used to receive DHR or Dhoro tokens on the Dhoro network.",
                weight: FontWeight.w400,
                textAlign: TextAlign.center,
                size: AppFontsStyle.textFontSize12,
              ),
            ),
          ],
        ),
      ));
}


class TransactionHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        color: Pallet.colorBlue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 34,
            ),
            AppFontsStyle.getAppTextViewBold(
              AppString.transactionId,
              color: Pallet.colorWhite,
              size: AppFontsStyle.textFontSize12,
            ),
            SizedBox(
              width: 28,
            ),
            AppFontsStyle.getAppTextViewBold(
              AppString.status,
              color: Pallet.colorWhite,
              size: AppFontsStyle.textFontSize12,
            ),
            SizedBox(
              width: 24,
            ),
            AppFontsStyle.getAppTextViewBold(
              "Amount",
              color: Pallet.colorWhite,
              size: AppFontsStyle.textFontSize12,
            ),
            SizedBox(
              width: 24,
            ),
            AppFontsStyle.getAppTextViewBold(
              AppString.from,
              color: Pallet.colorWhite,
              size: AppFontsStyle.textFontSize12,
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionList extends StatefulWidget {
  Function()? onItemClicked;
  String transId;
  String status;
  String value;
  String senderId;

  TransactionList(
      this.onItemClicked, this.transId, this.status, this.value, this.senderId,
      {Key? key})
      : super(key: key);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onItemClicked,
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 9.0, right: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(AppImages.icEye),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 90,
                child: Text(widget.transId,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: GoogleFonts.manrope(
                        color: Pallet.colorBlue,
                        fontSize: AppFontsStyle.textFontSize12,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        height: 1.5)),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 58,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    color: widget.status.contains("DESTROY")
                        ? Pallet.colorYellow
                        : Pallet.colorGreen.withOpacity(0.4)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                  child: AppFontsStyle.getAppTextView(
                    widget.status,
                    color: Pallet.colorBlue,
                    textAlign: TextAlign.center,
                    size: AppFontsStyle.textFontSize8,
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                width: 35,
                child: Text(widget.value,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: GoogleFonts.manrope(
                        color: Pallet.colorBlue,
                        fontSize: AppFontsStyle.textFontSize12,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        height: 1.5)),
              ),
              // AppFontsStyle.getAppTextView(
              //   widget.value,
              //   color: Pallet.colorBlue,
              //   size: AppFontsStyle.textFontSize12,
              // ),
              SizedBox(
                width: 12,
              ),
              Flexible(
                child: Container(
                  child: Text(widget.senderId,
                      textAlign: TextAlign.left,
                      //maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: GoogleFonts.manrope(
                          color: Pallet.colorBlue,
                          fontSize: AppFontsStyle.textFontSize12,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          height: 1.5)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
