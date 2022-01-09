import 'package:dhoro_mobile/data/remote/model/convert/withdraw/convert.dart';
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_text_field.dart';
import 'package:dhoro_mobile/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dhoro_mobile/ui/buy_dhoro/buy_dhoro_pages_container.dart' as sharedProvider;


final _validBuyAmount = Provider.autoDispose<bool>((ref) {
  return ref.watch(sharedProvider.userBuyProvider).isBuyAmount;
});

final validAmountProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(_validBuyAmount);
});

class BuyAmountPage extends StatefulHookWidget {
  BuyAmountPage({Key? key, /*required this.controller*/}) : super(key: key);

  @override
  _BuyAmountPageState createState() => _BuyAmountPageState();
}

class _BuyAmountPageState extends State<BuyAmountPage> {
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
      _amountController.text = context.read(sharedProvider.userBuyProvider).getCurrentPageAnswer() ?? "";
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
    ConvertData? convert = useProvider(sharedProvider.userBuyProvider).convertCurrency;
    print("convert +++= $convert");
    final currentPage = useProvider(sharedProvider.userBuyProvider).currentPage;

    final isPageValidated = useProvider(sharedProvider.userBuyProvider).pages[currentPage];
    final totalPages = context.read(sharedProvider.userBuyProvider).pages.length - 1;
    final progress =
    (currentPage / totalPages == 0) ? 0.05 : currentPage / totalPages;
    final isValidAmount = useProvider(validAmountProvider);

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
                        value.length >2 ? currentFocus.unfocus() : currentFocus.requestFocus();
                        context.read(sharedProvider.userBuyProvider)
                            .convertBuyCurrency("$selectedOption=${_amountController.text.trim()}");
                        context.read(sharedProvider.userBuyProvider).amount = value.trim();
                        context.read(sharedProvider.userBuyProvider).validateBuyAmount();
                        context
                            .read(sharedProvider.userBuyProvider)
                            .pageValidated(true);
                        context
                            .read(sharedProvider.userBuyProvider)
                            .updatePageAnswers(value);
                      },
                      validator: (value) {
                        if (context.read(sharedProvider.userBuyProvider).isValidAmount()) {
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
                            context.read(sharedProvider.userBuyProvider)
                                .convertBuyCurrency("$selectedOption=${_amountController.text.trim()}");
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
                    SizedBox(
                      height: 100,
                    ),
                    AppButton(
                        onPressed: (){
                          currentFocus.unfocus();
                          context.read(sharedProvider.userBuyProvider).moveToNextPage();
                          setState(() {
                            context.read(sharedProvider.userBuyProvider).currencyType = selectedOption;
                            context.read(sharedProvider.userBuyProvider).amount = "${_amountController.text.trim()}";
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

}
