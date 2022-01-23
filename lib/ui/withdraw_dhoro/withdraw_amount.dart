import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/change_statusbar_color.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_text_field.dart';
import 'package:dhoro_mobile/widgets/button.dart';
import 'package:dhoro_mobile/widgets/size_24_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dhoro_mobile/ui/withdraw_dhoro/withdraw_dhoro_pages_container.dart' as sharedProvider;


final _validWithdrawAmount = Provider.autoDispose<bool>((ref) {
  return ref.watch(sharedProvider.userRequestProvider).isWithdrawAmount;
});

final validAmountProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(_validWithdrawAmount);
});

class WithdrawAmountPage extends StatefulHookWidget {
  //PageController controller;
  WithdrawAmountPage({Key? key, /*required this.controller*/}) : super(key: key);

  @override
  _WithdrawAmountPageState createState() => _WithdrawAmountPageState();
}

class _WithdrawAmountPageState extends State<WithdrawAmountPage> {
  List<String> options = [
    "DHR",
    "USD",
    "NGN",
  ];
  String selectedOption = "DHR";
  TextEditingController _amountController = TextEditingController();
  PageController controller = PageController();

  Future<void> initialiseAnswer() async {
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      _amountController.text = context.read(sharedProvider.userRequestProvider).getCurrentPageAnswer() ?? "";
    });
  }

  @override
  void initState() {
    initialiseAnswer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    changeStatusAndNavBarColor(
        Pallet.colorWhite, Pallet.colorWhite, false, false);

    FocusScopeNode currentFocus = FocusScope.of(context);
    final currentPage = useProvider(sharedProvider.userRequestProvider).currentPage;

    final isPageValidated = useProvider(sharedProvider.userRequestProvider).pages[currentPage];
    final totalPages = context.read(sharedProvider.userRequestProvider).pages.length - 1;
    final progress =
    (currentPage / totalPages == 0) ? 0.05 : currentPage / totalPages;
    final isValidAmount = useProvider(validAmountProvider);
    final convert = context.read(sharedProvider.userRequestProvider).convertData;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0,),
                          child: GestureDetector(
                            onTap: (){
                              print("Clicked");
                              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.request, (route) => false);
                            },
                            child: SvgPicture.asset(
                              "assets/images/back_arrow.svg",
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 250.0,),
                    AmountFormField(
                      label: AppString.amount,
                      controller: _amountController,
                      onChanged: (value) {
                        value.length >7 ? currentFocus.unfocus() : currentFocus.requestFocus();
                        context.read(sharedProvider.userRequestProvider)
                            .convertCurrency("$selectedOption=${_amountController.text.trim()}");
                        context.read(sharedProvider.userRequestProvider).amount = value.trim();
                        context.read(sharedProvider.userRequestProvider).validateWithdrawAmount();
                        context
                            .read(sharedProvider.userRequestProvider)
                            .pageValidated(true);
                        context
                            .read(sharedProvider.userRequestProvider)
                            .updatePageAnswers(value);
                      },
                      validator: (value) {
                        if (context.read(sharedProvider.userRequestProvider).isValidAmount()) {
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
                            context.read(sharedProvider.userRequestProvider)
                                .convertCurrency("$selectedOption=${_amountController.text.trim()}");
                            print("Showing selected and amount $selectedOption=$_amountController");
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
                        convert != null && _amountController.text.isNotEmpty
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
                        ) : Container(),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    AppButton(
                        onPressed: (){
                          currentFocus.unfocus();
                          context.read(sharedProvider.userRequestProvider).moveToNextPage();
                          setState(() {
                            context.read(sharedProvider.userRequestProvider).currencyType = selectedOption;
                            context.read(sharedProvider.userRequestProvider).amount = "${_amountController.text.trim()}";
                          });
                        },
                        title: "PROCEED",
                        disabledColor: Pallet.colorBlue.withOpacity(0.2),
                        titleColor: Pallet.colorWhite,
                        enabledColor: isValidAmount ? Pallet.colorBlue : Pallet.colorBlue.withOpacity(0.2),
                        enabled: isValidAmount ? true : false),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    selectedOption = "";
    super.dispose();
  }
}
