import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
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
                    SizedBox(height: 280.0,),

                    AmountFormField(
                      label: AppString.amount,
                      controller: _amountController,
                      onChanged: (value) {
                        currentFocus.unfocus();
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
                        //elevation: 5,
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
                        convert == null ? Container()
                        : Column(
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
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 4.0),
                        //   child: SvgPicture.asset(
                        //     AppImages.icArrowSwap,
                        //     width: 10,
                        //     height: 10,
                        //   ),
                        // ),
                        Spacer(),
                        // AppFontsStyle.getAppTextViewBold("Transaction Fee: ",
                        //     weight: FontWeight.w500,
                        //     color: Pallet.colorGrey,
                        //     size: AppFontsStyle.textFontSize12),
                        // AppFontsStyle.getAppTextViewBold("3 DHR",
                        //     weight: FontWeight.w500,
                        //     size: AppFontsStyle.textFontSize12),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    AppButton(
                        onPressed: (){
                          context.read(sharedProvider.userRequestProvider).moveToNextPage();
                          // context
                          //     .read(sharedProvider.userRequestProvider).
                          //Navigator.of(context).pushNamed(AppRoutes.dashboard);
                          //controller.jumpToPage(currentPage - 1);
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

  void showBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        context: ctx,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        builder: (ctx) => Container(
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
              AppFontsStyle.getAppTextViewBold("Log Out",
                  color: Pallet.colorRed,
                  weight: FontWeight.w700,
                  size: AppFontsStyle.textFontSize16),
              SizedBox(
                height: 24,
              ),
              SvgPicture.asset(AppImages.icLogout, height: 80, width: 80,),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppFontsStyle.getAppTextView("Are you sure you want to log out of your Dhoro account?",
                    size: AppFontsStyle.textFontSize12),
              ),
              SizedBox(
                height: 40,
              ),
              Sized24Container(
                child: AppButton(
                  title: 'LOG OUT',
                  titleColor: Pallet.colorWhite,
                  enabledColor: Pallet.colorRed,
                  enabled: true,
                  disabledColor: Pallet.colorGrey,
                  onPressed: () async {
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Sized24Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color:Pallet.colorBlue),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    color: Pallet.colorWhite),
                child: AppButton(
                  title: 'Cancel',
                  titleColor: Pallet.colorBlue,
                  enabledColor: Pallet.colorWhite,
                  enabled: true,
                  disabledColor: Pallet.colorWhite,
                  onPressed: () async {
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ));
  }

}
