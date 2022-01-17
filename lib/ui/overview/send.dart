import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/convert/withdraw/convert.dart';
import 'package:dhoro_mobile/data/remote/model/user/user_wallet_balance_model.dart';
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_text_field.dart';
import 'package:dhoro_mobile/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dhoro_mobile/ui/overview/overview.dart' as sharedProvider;

final _validBuyAmount = Provider.autoDispose<bool>((ref) {
  return ref.watch(sharedProvider.overviewProvider).isValidSendAmount;
});

final validAmountProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(_validBuyAmount);
});

class SendPage extends StatefulHookWidget {
  SendPage({
    Key? key,
    /*required this.controller*/
  }) : super(key: key);

  @override
  _SendPageState createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  List<String> options = [
    "DHR",
    "USD",
    "NGN",
  ];
  String selectedOption = "DHR";
  TextEditingController _walletIdController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  Future<void> initialiseAnswer() async {
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {});
  }

  @override
  void initState() {
    initialiseAnswer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    ConvertData? convert =
        useProvider(sharedProvider.overviewProvider).convertData;
    print("convert +++= $convert");
    WalletData? walletBalance =
        useProvider(sharedProvider.overviewProvider).walletData;
    var dhrBalance = walletBalance?.dhrBalance?.toStringAsFixed(3);
    final isValidAmount = useProvider(validAmountProvider);
    ViewState viewState =
        useProvider(sharedProvider.overviewProvider).viewState;

    return Scaffold(
      backgroundColor: Pallet.colorBackground,
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8)),
                    color: const Color(0xfffffffff)),
                //color: Pallet.colorWhite,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 7,
                      ),
                      SvgPicture.asset(
                        "assets/images/top_indicator.svg",
                      ),
                      SizedBox(
                        height: 19,
                      ),
                      AppFontsStyle.getAppTextViewBold("Send Dhoro",
                          color: Pallet.colorRed,
                          weight: FontWeight.w700,
                          size: AppFontsStyle.textFontSize16),
                      SizedBox(
                        height: 16,
                      ),
                      SvgPicture.asset(
                        "assets/images/ic_dhr.svg",
                        height: 60,
                        width: 60,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: AppFontsStyle.getAppTextViewBold(
                          "\$${walletBalance?.usdEquivalent ?? 0}",
                          weight: FontWeight.w400,
                          textAlign: TextAlign.center,
                          size: AppFontsStyle.textFontSize12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 16.0,
                        ),
                        child: AppFontsStyle.getAppTextViewBold(
                          "${dhrBalance ?? 0} DHR",
                          weight: FontWeight.w400,
                          textAlign: TextAlign.center,
                          size: AppFontsStyle.textFontSize12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: AppFontsStyle.getAppTextViewBold(
                          "You can only send Dhoro tokens to Dhoro wallets. Dhoro wallets are unique to every user on the network.",
                          weight: FontWeight.w400,
                          textAlign: TextAlign.center,
                          size: AppFontsStyle.textFontSize12,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      AppFormField(
                        label: "Recipient’s DHR wallet ID",
                        controller: _walletIdController,
                        onChanged: (value) {
                          setState(() {
                            context
                                .read(sharedProvider.overviewProvider)
                                .walletId = value.trim();
                            context
                                .read(sharedProvider.overviewProvider)
                                .validateSendAmount();
                          });
                        },
                        validator: (value) {
                          if (context
                              .read(sharedProvider.overviewProvider)
                              .isValidWalletId()) {
                            return "Enter a valid Wallet ID.";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AmountFormField(
                        label: AppString.amount,
                        controller: _amountController,
                        onChanged: (value) {
                          // value.length > 2
                          //     ? currentFocus.unfocus()
                          //     : currentFocus.requestFocus();
                          context
                              .read(sharedProvider.overviewProvider)
                              .convertCurrency(
                                  "$selectedOption=${_amountController.text.trim()}");
                          context
                              .read(sharedProvider.overviewProvider)
                              .sendAmount = value.trim();
                          context
                              .read(sharedProvider.overviewProvider)
                              .isValidAmount();
                        },
                        validator: (value) {
                          if (context
                              .read(sharedProvider.overviewProvider)
                              .isValidAmount()) {
                            return "Enter a valid amount";
                          }
                          return null;
                        },
                        dropdown: DropdownButton<String>(
                          focusColor: Pallet.colorBlue,
                          underline: Container(),
                          value: selectedOption,
                          isExpanded: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Pallet.colorBlack,
                            size: 14,
                          ),
                          style: GoogleFonts.manrope(
                              color: Pallet.colorBlue,
                              fontSize: AppFontsStyle.textFontSize12,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              height: 1.5),
                          iconEnabledColor: Pallet.colorBlue,
                          onChanged: (String? value) {
                            setState(() {
                              selectedOption = value!;
                              currentFocus.unfocus();
                              context
                                  .read(sharedProvider.overviewProvider)
                                  .convertCurrency(
                                      "$selectedOption=${_amountController.text.trim()}");
                              print(
                                  "Showing selected and amount $selectedOption=$_amountController");
                            });
                          },
                          items: <String>[
                            'DHR',
                            'USD',
                            'NGN',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: AppFontsStyle.getAppTextView(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          convert != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    selectedOption == "USD"
                                        ? Container()
                                        : AppFontsStyle.getAppTextViewBold(
                                            "${convert.usd ?? 0.0}",
                                            weight: FontWeight.w500,
                                            size: AppFontsStyle.textFontSize12),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    selectedOption == "DHR"
                                        ? Container()
                                        : AppFontsStyle.getAppTextViewBold(
                                            "${convert.dhr ?? 0.0}",
                                            weight: FontWeight.w500,
                                            size: AppFontsStyle.textFontSize12),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    selectedOption == "NGN"
                                        ? Container()
                                        : AppFontsStyle.getAppTextViewBold(
                                            "${convert.ngn ?? 0.0}",
                                            weight: FontWeight.w500,
                                            size: AppFontsStyle.textFontSize12),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      viewState == ViewState.Loading
                          ? Center(child: CircularProgressIndicator())
                          : AppButton(
                              onPressed: () {
                                currentFocus.unfocus();
                                setState(() {
                                  context
                                      .read(sharedProvider.overviewProvider)
                                      .sendDhoro(
                                          context,
                                          "${_amountController.text.trim()}",
                                          selectedOption,
                                          "${_walletIdController.text.trim()}");
                                  //observeState(context);
                                });
                              },
                              title: "SEND DHORO",
                              disabledColor: Pallet.colorBlue.withOpacity(0.2),
                              titleColor: Pallet.colorWhite,
                              enabledColor: isValidAmount
                                  ? Pallet.colorBlue
                                  : Pallet.colorBlue.withOpacity(0.2),
                              enabled: isValidAmount ? true : false),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void observeState(BuildContext context) async {
  //   final sendViewModel = context.read(sharedProvider.overviewProvider);
  //   context.read(sharedProvider.overviewProvider).sendDhoro(
  //       context,
  //       "${_amountController.text.trim()}",
  //       selectedOption,
  //       "${_walletIdController.text.trim()}");
  //   var viewModel = await sendViewModel.sendDhoro(
  //       context,
  //       "${_amountController.text.trim()}",
  //       selectedOption,
  //       "${_walletIdController.text.trim()}");
  //   if (sendViewModel.viewState == ViewState.Success) {
  //     //print('signin details $signIn');
  //     showSuccessBottomSheet(context, "${_amountController.text.trim()}$selectedOption",
  //         _walletIdController.text.trim());
  //     //Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.dashboard, (route) => false);
  //   } else {
  //     showFailedBottomSheet(context, viewModel!.message.toString(),
  //         "${_amountController.text.trim()}$selectedOption", _walletIdController.text.trim());
  //   }
  // }

}

showSuccessBottomSheet(BuildContext context, String amount, String wid) {
  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      builder: (context) => Container(
        height: 325,
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
            AppFontsStyle.getAppTextViewBold("Transaction Successful",
                color: Pallet.colorBlue,
                weight: FontWeight.w700,
                size: AppFontsStyle.textFontSize16),
            SizedBox(
              height: 24,
            ),
            SvgPicture.asset("assets/images/ic_success_send.svg"),
            SizedBox(
              height: 16,
            ),
            Container(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pushNamed(AppRoutes.signUp);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                            text: 'Your transaction of ',
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              height: 1.5,
                              color: Pallet.colorGrey,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '$amount',
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                  height: 1.5,
                                  color: Pallet.colorBlue,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: ' to',
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                  height: 1.5,
                                  color: Pallet.colorGrey,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: ' $wid',
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                  height: 1.5,
                                  color: Pallet.colorBlue,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: " was successful",
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                  height: 1.5,
                                  color: Pallet.colorGrey,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ));
}

showFailedBottomSheet(
    BuildContext context, String message, String amount, String wid) {
  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      builder: (context) => Container(
        height: 325,
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
            AppFontsStyle.getAppTextViewBold("Transaction Failed",
                color: Pallet.colorBlue,
                weight: FontWeight.w700,
                size: AppFontsStyle.textFontSize16),
            SizedBox(
              height: 24,
            ),
            SvgPicture.asset("assets/images/ic_failed_send.svg"),
            SizedBox(
              height: 16,
            ),
            Container(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    //Navigator.of(context).pushNamed(AppRoutes.signUp);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                            text: 'Your transaction of ',
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              height: 1.5,
                              color: Pallet.colorGrey,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,

                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '$amount',
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                  height: 1.5,
                                  color: Pallet.colorBlue,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: ' to',
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                  height: 1.5,
                                  color: Pallet.colorGrey,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: ' $wid',
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                  height: 1.5,
                                  color: Pallet.colorBlue,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: " failed due to ",
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                  height: 1.5,
                                  color: Pallet.colorGrey,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: "$message",
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                  height: 1.5,
                                  color: Pallet.colorBlue,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ]),
                        textAlign: TextAlign.center,

                        //textHeightBehavior: ,
                      ),
                    ),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ));
}