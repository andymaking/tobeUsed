import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OverviewPage extends StatefulHookWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  bool isLock = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                OverViewToolBar(AppString.overView, ""),
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
                        !isLock
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppFontsStyle.getAppTextViewBold(
                                    "1 DHR = \$1.14",
                                    weight: FontWeight.w600,
                                    size: AppFontsStyle.textFontSize12,
                                  ),
                                  Spacer(),
                                  SvgPicture.asset(AppImages.triangleUp),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  AppFontsStyle.getAppTextViewBold(
                                    "1.2%",
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
                                    "1.2%",
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
                                AppFontsStyle.getAppTextViewBold(
                                  "\$236,100.50",
                                  color: isLock
                                      ? Pallet.colorGrey
                                      : Pallet.colorBlue,
                                  weight: FontWeight.w600,
                                  size: AppFontsStyle.textFontSize24,
                                ),
                                Visibility(
                                  visible: isLock == true,
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
                              "5675 DHR",
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
                                    setState(() {
                                      isLock = !isLock;
                                    });
                                  },
                                  child: isLock
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
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0, right: 24, bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(10, (index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TransactionList(),
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
              ],
            ),
          ]),
        ),
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
  //Function()? onApproveBtnClicked;
  // String amount;
  // String DHRAmount;
  // String oneDHR;
  // String percent;

  TransactionList(
      //this.onApproveBtnClicked,
      // this.amount, this.DHRAmount,
      // this.oneDHR, this.percent,
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
            AppFontsStyle.getAppTextView(
              "TejskidhijeihirHn",
              color: Pallet.colorBlue,
              size: AppFontsStyle.textFontSize12,
            ),
            SizedBox(
              width: 12,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  color: Pallet.colorGreen.withOpacity(0.4)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                child: AppFontsStyle.getAppTextView(
                  "Approved",
                  color: Pallet.colorBlue,
                  size: AppFontsStyle.textFontSize8,
                ),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            AppFontsStyle.getAppTextView(
              "23 DHR",
              color: Pallet.colorBlue,
              size: AppFontsStyle.textFontSize12,
            ),
            SizedBox(
              width: 12,
            ),
            Flexible(
              child: Container(
                child: Text("D1jskidhijeihirHnJrqdkbQQRS9",
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
