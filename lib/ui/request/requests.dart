
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/request/request_data.dart';
import 'package:dhoro_mobile/domain/viewmodel/request_viewmodel.dart';
import 'package:dhoro_mobile/main.dart';
import 'package:dhoro_mobile/route/routes.dart';
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

final requestProvider =
ChangeNotifierProvider.autoDispose<RequestViewModel>((ref) {
  ref.onDispose(() {});
  final viewModel = locator.get<RequestViewModel>();
  viewModel.getRequest();
  return viewModel;
});

final _requestStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(overviewProvider).viewState;
});
final requestStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_requestStateProvider);
});

class RequestsPage extends StatefulHookWidget {
  const RequestsPage({Key? key}) : super(key: key);

  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {

  @override
  Widget build(BuildContext context) {
    ViewState viewState = useProvider(requestStateProvider);
    List<RequestData>? requestList =
        useProvider(requestProvider).requestList;

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
                OverViewToolBar(AppString.requests, ""),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 23),
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: const Color(0xfffffffff)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 18,
                                      ),
                                      AppFontsStyle.getAppTextViewBold(
                                        "Purchase Request",
                                        color: Pallet.colorBlue,
                                        weight: FontWeight.w600,
                                        size: AppFontsStyle.textFontSize10,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 22,
                                  ),
                                  AppFontsStyle.getAppTextViewBold(
                                    "Buy Dhoro tokens with ease and join the Dhoro community.",
                                    weight: FontWeight.w700,
                                    size: AppFontsStyle.textFontSize16,
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Container(
                                      height: 50,
                                      width: 137,
                                      child: Center(
                                        child: AppFontsStyle.getAppTextViewBold(
                                            'BUY DHORO',
                                            size: AppFontsStyle.textFontSize12,
                                            color: Pallet.colorWhite,
                                            textAlign: TextAlign.center),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(2)),
                                        color: Pallet.colorBlue,
                                      )
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AppImages.icBuyer),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 23),
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        color: const Color(0xfffffffff)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 18,
                                      ),
                                      AppFontsStyle.getAppTextViewBold(
                                        "Withdrawal Request",
                                        color: Pallet.colorBlue,
                                        weight: FontWeight.w600,
                                        size: AppFontsStyle.textFontSize10,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 22,
                                  ),
                                  AppFontsStyle.getAppTextViewBold(
                                    "Seamlessly convert your Dhoro tokens to fiat at current rates.",
                                    weight: FontWeight.w700,
                                    size: AppFontsStyle.textFontSize16,
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).pushNamed(AppRoutes.withdraw);
                                  },
                                    child: Container(
                                        height: 50,
                                        width: 137,
                                        child: Center(
                                          child: AppFontsStyle.getAppTextViewBold(
                                              'WITHDRAW DHORO',
                                              size: AppFontsStyle.textFontSize12,
                                              color: Pallet.colorBlue,
                                              textAlign: TextAlign.center),
                                        ),
                                      decoration: BoxDecoration(
                                        border:  Border.all(width: 1.0, color: Pallet.colorBlue),
                                        borderRadius: BorderRadius.all(Radius.circular(2)),)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AppImages.icWithdraw),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: AppFontsStyle.getAppTextViewBold(
                    AppString.requests,
                    weight: FontWeight.w700,
                    size: AppFontsStyle.textFontSize16,
                  ),
                ),
                SizedBox(
                  height: 16,
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
                          "Latest 5 from a total of ${requestList.length} transactions",
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
                requestList.isNotEmpty == true
                    ? viewState == ViewState.Loading
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
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
                        children: List.generate(requestList.length, (index) {
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
                                        requestList[index]
                                            .pk ?? "",
                                        requestList[index]
                                            .status ?? "",
                                        requestList[index]
                                            .amount
                                            .toString(),
                                        requestList[index]
                                            .payment?.user ?? ""
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
                )
                    : buildEmptyView(),
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
            height: 60.0,
          ),
          Container(
            child: SvgPicture.asset("assets/images/ic_notifications.svg"),
          ),
          SizedBox(
            height: 24.0,
          ),
          AppFontsStyle.getAppTextViewBold("No request yet",
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
