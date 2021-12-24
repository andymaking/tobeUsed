
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/transfer_history/transfer_history_data.dart';
import 'package:dhoro_mobile/domain/viewmodel/overview_viewmodel.dart';
import 'package:dhoro_mobile/main.dart';
import 'package:dhoro_mobile/ui/overview/overview.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
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
  //viewModel.getUser();
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

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  Widget build(BuildContext context) {
    List<TransferHistoryData>? userTransactions =
        useProvider(transactionsProvider).transferHistory;

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
                OverViewToolBar(AppString.transactions, ""),
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
                        "Latest 12 from a total of 12 transactions",
                        weight: FontWeight.w500,
                        size: AppFontsStyle.textFontSize10,
                      ),
                      Spacer(),
                      SvgPicture.asset(AppImages.iconMenu),
                    ],
                  )
                ),
                SizedBox(
                  height: 16,
                ),
                TransactionHeader(),
                userTransactions.isNotEmpty == true
                ? Padding(
                  padding:
                  const EdgeInsets.only(left: 24.0, right: 24, bottom: 24),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        color: const Color(0xfffffffff)),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(userTransactions.length, (index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TransactionList(
                                            (){},
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
                                      .toString()
                                    ),
                                    // SizedBox(
                                    //   height: 8,
                                    // ),
                                    Divider(
                                      height: 1,
                                      color: Pallet.colorBlue.withOpacity(0.3),
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
                ) : buildEmptyView(),
              ],
            ),
          ]),
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
