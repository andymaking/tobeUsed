// import 'package:dhoro_mobile/data/core/view_state.dart';
// import 'package:dhoro_mobile/data/remote/model/user/user_wallet_balance_model.dart';
// import 'package:dhoro_mobile/utils/app_fonts.dart';
// import 'package:dhoro_mobile/utils/color.dart';
// import 'package:dhoro_mobile/utils/strings.dart';
// import 'package:dhoro_mobile/widgets/app_text_field.dart';
// import 'package:dhoro_mobile/widgets/button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/user/user_wallet_balance_model.dart';
import 'package:dhoro_mobile/ui/overview/overview.dart' as sharedProvider;
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/widgets/app_text_field.dart';
import 'package:dhoro_mobile/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';



class SendDhoroPage extends StatefulHookWidget {
  const SendDhoroPage({Key? key}) : super(key: key);

  @override
  _SendDhoroPageState createState() => _SendDhoroPageState();
}

class _SendDhoroPageState extends State<SendDhoroPage> {
  List<String> options = [
    "DHR",
    "USD",
    "NGN",
  ];
  String selectedOption = "DHR";


  @override
  Widget build(BuildContext context) {
    TextEditingController _walletIdController = TextEditingController();
    TextEditingController _amountController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    WalletData? walletBalance = useProvider(sharedProvider.overviewProvider).walletData;
    var dhrBalance = walletBalance?.dhrBalance?.toStringAsFixed(3);
    final convert = context.read(sharedProvider.overviewProvider).convertData;
    ViewState viewState = useProvider(sharedProvider.overviewProvider).viewState;
    final isValid = useProvider(sharedProvider.overviewProvider).isValidSendAmount;


    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                     // height: 570,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                            height: 20,
                          ),
                          AppFormField(
                            label: "Recipient’s DHR wallet ID",
                            controller: _walletIdController,
                            onChanged: (value) {
                              setState(() {
                                context.read(sharedProvider.overviewProvider).walletId =
                                    value.trim();
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
                          // AmountFormField(
                          //   label: AppString.amount,
                          //   controller: _amountController,
                          //   onChanged: (value) {
                          //     //value.length >2 ? currentFocus.unfocus() : currentFocus.requestFocus();
                          //     context.read(sharedProvider.overviewProvider)
                          //         .convertCurrency("$selectedOption=${_amountController.text.trim()}");
                          //     context.read(sharedProvider.overviewProvider).sendAmount = value.trim();
                          //     context.read(sharedProvider.overviewProvider).validateSendAmount();
                          //   },
                          //   validator: (value) {
                          //     if (context.read(sharedProvider.overviewProvider).isValidAmount()) {
                          //       return "Enter a valid amount";
                          //     }
                          //     return null;
                          //   },
                          //   dropdown: DropdownButton<String>(
                          //     focusColor: Pallet.colorBlue,
                          //     underline: Container(),
                          //     value: selectedOption,
                          //     isExpanded: true,
                          //     icon: Icon(
                          //       Icons.keyboard_arrow_down_rounded,
                          //       color: Pallet.colorBlack,
                          //       size: 14,
                          //     ),
                          //     style: GoogleFonts.manrope(
                          //         color: Pallet.colorBlue,
                          //         fontSize: AppFontsStyle.textFontSize12,
                          //         fontWeight: FontWeight.w500,
                          //         fontStyle: FontStyle.normal,
                          //         height: 1.5),
                          //     iconEnabledColor: Pallet.colorBlue,
                          //     onChanged: (String? value) {
                          //       setState(() {
                          //         selectedOption = value!;
                          //         //currentFocus.unfocus();
                          //         context.read(sharedProvider.overviewProvider)
                          //             .convertCurrency("$selectedOption=${_amountController.text.trim()}");
                          //         print("Showing selected and amount $selectedOption=$_amountController");
                          //       });
                          //     },
                          //     items: <String>[
                          //       'DHR',
                          //       'USD',
                          //       'NGN',
                          //     ].map<DropdownMenuItem<String>>((String value) {
                          //       return DropdownMenuItem<String>(
                          //         value: value,
                          //         child: AppFontsStyle.getAppTextView(value),
                          //       );
                          //     }).toList(),
                          //   ),
                          // ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              convert != null
                                  ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  selectedOption == "USD" ? Container() : AppFontsStyle.getAppTextViewBold("${convert.usd ?? 0.0}",
                                      weight: FontWeight.w500,
                                      size: AppFontsStyle.textFontSize12),
                                  SizedBox(height: 4,),
                                  selectedOption == "DHR" ? Container() : AppFontsStyle.getAppTextViewBold("${convert.dhr ?? 0.0}",
                                      weight: FontWeight.w500,
                                      size: AppFontsStyle.textFontSize12),
                                  SizedBox(height: 4,),
                                  selectedOption == "NGN" ? Container() : AppFontsStyle.getAppTextViewBold("${convert.ngn ?? 0.0}",
                                      weight: FontWeight.w500,
                                      size: AppFontsStyle.textFontSize12),
                                ],
                              )
                                  : Container(),
                            ],
                          ),
                          // AmountFormField(
                          //   label: AppString.amount,
                          //   controller: _amountController,
                          //   onChanged:  (value) {
                          //     setState(() {
                          //       context.read(sharedProvider.overviewProvider).sendAmount = value.trim();
                          //       context.read(sharedProvider.overviewProvider).validateSendAmount();
                          //       context.read(sharedProvider.overviewProvider).convertCurrency(
                          //           "$selectedOption=${_amountController.text.trim()}");
                          //       print(
                          //           "Showing selected and amount $selectedOption=$_amountController");
                          //     });
                          //   },
                          //   validator: (value) {
                          //     if (context.read(sharedProvider.overviewProvider).isValidAmount()) {
                          //       return "Enter a valid amount";
                          //     }
                          //     return null;
                          //   },
                          //   dropdown: DropdownButton<String>(
                          //     focusColor: Pallet.colorBlue,
                          //     underline: Container(),
                          //     value: selectedOption,
                          //     isExpanded: true,
                          //     icon: Icon(
                          //       Icons.keyboard_arrow_down_rounded,
                          //       color: Pallet.colorBlack,
                          //       size: 14,
                          //     ),
                          //     style: GoogleFonts.manrope(
                          //         color: Pallet.colorBlue,
                          //         fontSize: AppFontsStyle.textFontSize12,
                          //         fontWeight: FontWeight.w500,
                          //         fontStyle: FontStyle.normal,
                          //         height: 1.5),
                          //     iconEnabledColor: Pallet.colorBlue,
                          //     onChanged: (String? value) {
                          //       setState(() {
                          //         selectedOption = value!;
                          //         context.read(sharedProvider.overviewProvider).convertCurrency(
                          //             "$selectedOption=${_amountController.text.trim()}");
                          //         print(
                          //             "Showing selected and amount $selectedOption=$_amountController");
                          //       });
                          //     },
                          //     items: <String>[
                          //       'DHR',
                          //       'USD',
                          //       'NGN',
                          //     ].map<DropdownMenuItem<String>>((String value) {
                          //       return DropdownMenuItem<String>(
                          //         value: value,
                          //         child: AppFontsStyle.getAppTextView(value),
                          //       );
                          //     }).toList(),
                          //   ),
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              convert == null
                                  ? Container()
                                  : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  selectedOption == "USD"
                                      ? Container()
                                      : AppFontsStyle.getAppTextViewBold("${convert.usd ?? ""}",
                                      weight: FontWeight.w500,
                                      size: AppFontsStyle.textFontSize12),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  selectedOption == "DHR"
                                      ? Container()
                                      : AppFontsStyle.getAppTextViewBold(convert.dhr ?? "",
                                      weight: FontWeight.w500,
                                      size: AppFontsStyle.textFontSize12),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  selectedOption == "NGN"
                                      ? Container()
                                      : AppFontsStyle.getAppTextViewBold(convert.ngn ?? "",
                                      weight: FontWeight.w500,
                                      size: AppFontsStyle.textFontSize12),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
            viewState == ViewState.Loading
                  ? Center(
                  child:
                  CircularProgressIndicator())
                  : AppButton(
                  onPressed: () {
                    FocusScope.of(context)
                        .unfocus();
                    setState(() {
                      context
                          .read(sharedProvider.overviewProvider)
                          .sendDhoro(
                          context,
                          "${_amountController.text.trim()}",
                          selectedOption,
                          "${_walletIdController.text.trim()}");
                    });
                  },
                  title: "SEND DHORO",
                  disabledColor: Pallet.colorBlue
                      .withOpacity(0.2),
                  titleColor: Pallet.colorWhite,
                  enabledColor: isValid
                      ? Pallet.colorBlue
                      : Pallet.colorBlue
                      .withOpacity(0.2),
                  enabled:
                  isValid ? true : false),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
