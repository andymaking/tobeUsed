import 'package:dhoro_mobile/data/remote/model/convert/withdraw/convert.dart';
import 'package:dhoro_mobile/data/remote/model/validate/validate.dart';
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
    "USD",
    "DHR",
    "NGN",
  ];
  bool showCovertCurrency = false;
  String selectedOption = "USD";
  TextEditingController _amountController = TextEditingController();
  PageController controller = PageController();

  Future<void> initialiseAnswer() async {
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      _amountController.text = context.read(sharedProvider.userBuyProvider).getBuyCurrentPageAnswer() ?? "";
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
    ConvertData? convert = useProvider(sharedProvider.userBuyProvider).convertData;
    ValidateBuyResponse? validateBuyResponse = useProvider(sharedProvider.userBuyProvider).validateBuyResponse;
    print("convert +++= $convert");
    final currentPage = useProvider(sharedProvider.userBuyProvider).buyCurrentPage;

    final isPageValidated = useProvider(sharedProvider.userBuyProvider).buyPages[currentPage];
    final totalPages = context.read(sharedProvider.userBuyProvider).buyPages.length - 1;
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
                    SizedBox(height: 180.0,),
                    validateBuyResponse?.data == true ? Container()
                    : Row(
                      children: [
                        AppFontsStyle.getAppTextViewBold("${validateBuyResponse?.message ?? ""}",
                            weight: FontWeight.w500,
                            size: AppFontsStyle.textFontSize12),
                      ],
                    ),
                    SizedBox(height: 8.0,),
                    AmountFormField(
                      label: AppString.amount,
                      controller: _amountController,
                      onChanged: (value) {
                        value.length >7 ? currentFocus.unfocus() : currentFocus.requestFocus();
                        context.read(sharedProvider.userBuyProvider)
                            .convertBuyCurrency("$selectedOption=${_amountController.text.trim()}");
                        _amountController.text.isNotEmpty
                            ? context.read(sharedProvider.userBuyProvider).
                        validateBuyDhoro("${_amountController.text.trim()}", selectedOption)
                        : context.read(sharedProvider.userBuyProvider).validateBuyDhoro("0", selectedOption);
                        context.read(sharedProvider.userBuyProvider).buyAmount = value.trim();
                        context.read(sharedProvider.userBuyProvider).validateBuyAmount();
                        context
                            .read(sharedProvider.userBuyProvider)
                            .pageBuyValidated(true);
                        context
                            .read(sharedProvider.userBuyProvider)
                            .updateBuyPageAnswers(value);
                      },
                      validator: (value) {
                        if (context.read(sharedProvider.userBuyProvider).isValidBuyAmount()) {
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
                            context.read(sharedProvider.userBuyProvider)
                                .convertBuyCurrency("$selectedOption=${_amountController.text.trim()}");
                            print("Showing selected and amount $selectedOption=$_amountController");
                          });
                        },
                        items: <String>[
                          'USD',
                          'DHR',
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
                          context.read(sharedProvider.userBuyProvider).moveBuyToNextPage();
                          setState(() {
                            context.read(sharedProvider.userBuyProvider).buyCurrencyType = selectedOption;
                            context.read(sharedProvider.userBuyProvider).buyAmount = "${_amountController.text.trim()}";
                            context.read(sharedProvider.userBuyProvider).ngnConvert = "${convert?.ngn ?? 0.0}";
                          });
                        },
                        title: "PROCEED",
                        disabledColor: Pallet.colorBlue.withOpacity(0.2),
                        titleColor: Pallet.colorWhite,
                        enabledColor: validateBuyResponse?.data != null &&
                            validateBuyResponse?.data == true &&
                            isValidAmount ? Pallet.colorBlue : Pallet.colorBlue.withOpacity(0.2),
                        enabled: validateBuyResponse?.data != null &&
                            validateBuyResponse?.data == true &&
                            isValidAmount ? true : false),
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
