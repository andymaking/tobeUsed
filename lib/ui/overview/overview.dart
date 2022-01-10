import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/rate/rate.dart';
import 'package:dhoro_mobile/data/remote/model/transfer_history/transfer_history_data.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/data/remote/model/user/user_wallet_balance_model.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_percentage/wallet_percentage.dart';
import 'package:dhoro_mobile/data/remote/model/wallet_status.dart';
import 'package:dhoro_mobile/domain/viewmodel/overview_viewmodel.dart';
import 'package:dhoro_mobile/main.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/change_statusbar_color.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_toolbar.dart';
import 'package:dhoro_mobile/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

final overviewProvider =
    ChangeNotifierProvider.autoDispose<OverviewViewModel>((ref) {
  ref.onDispose(() {});
  final viewModel = locator.get<OverviewViewModel>();
  viewModel.getTransferHistory();
  viewModel.getUser();
  viewModel.getRate();
  viewModel.walletBalance();
  viewModel.getWalletStatus();
  viewModel.getWalletPercentage();
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

  @override
  Widget build(BuildContext context) {
    changeStatusAndNavBarColor(
        Pallet.colorWhite, Pallet.colorWhite, false, false);
    ViewState viewState = useProvider(profileStateProvider);
    WalletData? walletBalance = useProvider(overviewProvider).walletData;
    bool? walletStatus = useProvider(overviewProvider).walletStatus;
    MessageResponse? lockUnlock = useProvider(overviewProvider).lockUnlock;
    GetUserData? userData = useProvider(overviewProvider).user;
    RateData? rateData = useProvider(overviewProvider).rateData;
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
    var dhrBalance = walletBalance?.dhrBalance?.toStringAsFixed(2);
    //observePercentageState(context);
    return Scaffold(
      backgroundColor: Pallet.colorBackground,
      body: SafeArea(
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
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 23),
                    height: 212,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: const Color(0xfffffffff)),
                    child: Column(
                      children: [
                        //walletStatus == true
                        !isLock
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppFontsStyle.getAppTextViewBold(
                                    "1 DHR = \$${rateData?.equivalentInDhoro ?? 0.0}",
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
                              )
                            : Row(
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
                          height: 18,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppImages.iconGreenArrowUp),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  AppFontsStyle.getAppTextViewBold(
                                    "5675 DHR",
                                    weight: FontWeight.w500,
                                    size: AppFontsStyle.textFontSize10,
                                  ),
                                ],
                              ),
                              Column(
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
                              GestureDetector(
                                  onTap: () {
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
                                        ))
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
                        ? Center(child: CircularProgressIndicator())
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
                                    return GestureDetector(
                                      onTap: () {},
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 2.0),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              TransactionList(
                                                  () => null,
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
              AppString.value,
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
    return Container(
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
                  color: widget.status.contains("DESTROY") ? Pallet.colorYellow : Pallet.colorGreen.withOpacity(0.4)),
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
    );
  }
}
