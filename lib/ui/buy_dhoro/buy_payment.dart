import 'package:dhoro_mobile/data/remote/model/agents/agent.dart';
import 'package:dhoro_mobile/data/remote/model/payment_processor/payment_processor.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/ui/withdraw_dhoro/select_withdraw_payment_processor.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:dhoro_mobile/ui/buy_dhoro/buy_dhoro_pages_container.dart' as sharedProvider;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class BuyPaymentPage extends StatefulHookWidget {
  const BuyPaymentPage({Key? key}) : super(key: key);

  @override
  _BuyPaymentPageState createState() => _BuyPaymentPageState();
}

class _BuyPaymentPageState extends State<BuyPaymentPage> {

  @override
  Widget build(BuildContext context) {
    final isValidLogin = true;
    List<PaymentProcessorData>? userTransactions =
        useProvider(sharedProvider.userBuyProvider).paymentProcessor;
    context.read(sharedProvider.userBuyProvider).paymentId = "${userTransactions.first.pk}";
    GetUserData? userData = useProvider(sharedProvider.userBuyProvider).user;
    AgentsData? agent = useProvider(sharedProvider.userBuyProvider).anAgents;
    PushData? pushData;


    String paymentId = "";
    String userName = "";
    String bankName = "";
    String accountNumber = "";
    setState(() {
      print("pushData paymentId ... ${pushData?.paymentId}");
      print("pushData userName ... ${pushData?.userName}");
      print("pushData bankName ... ${pushData?.bankName}");
      print("pushData accountNumber ... ${pushData?.accountNumber}");

      paymentId = context.read(sharedProvider.userBuyProvider).paymentId;
      userName = context.read(sharedProvider.userBuyProvider).userName;
      bankName = context.read(sharedProvider.userBuyProvider).bankName;
      accountNumber = context.read(sharedProvider.userBuyProvider).accountNumber;
      print("paymentId ... $paymentId");
      print("userName ... $userName");
      print("bankName ... $bankName");
      print("accountNumber ... $accountNumber");
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 190.0,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                height: 113,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Pallet.colorBlue),
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          userName.isEmpty
                              ? AppFontsStyle.getAppTextViewBold("${userTransactions.first.label!.toTitleCase()!}",
                              weight: FontWeight.w500,
                              size: AppFontsStyle.textFontSize12)
                              : AppFontsStyle.getAppTextViewBold(userName,
                              weight: FontWeight.w500,
                              size: AppFontsStyle.textFontSize12),
                          SizedBox(height: 12.0,),
                          bankName.isEmpty
                          ? AppFontsStyle.getAppTextViewBold("${userTransactions.first.processor!.toTitleCase()!}",
                              weight: FontWeight.w500,
                              size: AppFontsStyle.textFontSize12)
                          : AppFontsStyle.getAppTextViewBold(bankName,
                              weight: FontWeight.w500,
                              size: AppFontsStyle.textFontSize12),
                          SizedBox(height: 12.0,),
                          accountNumber.isEmpty
                          ? AppFontsStyle.getAppTextViewBold("${userTransactions.first.value!}",
                              weight: FontWeight.w500,
                              size: AppFontsStyle.textFontSize12)
                          : AppFontsStyle.getAppTextViewBold(accountNumber,
                              weight: FontWeight.w500,
                              size: AppFontsStyle.textFontSize12),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              pushData = await Navigator.pushNamed(context, AppRoutes.selectBuyPaymentProcessor)as PushData;
                              print("recieved... ${pushData?.paymentId}, ${pushData?.userName}");
                              setState(() {

                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Pallet.colorBackground,
                                borderRadius: BorderRadius.all(Radius.circular(2)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                                child: AppFontsStyle.getAppTextViewBold("Change",
                                    weight: FontWeight.w400,
                                    size: AppFontsStyle.textFontSize10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
              child: Column(
                children: [
                  AppFontsStyle.getAppTextViewBold("Kindly make a transfer to the administrator account below:",
                      color: Pallet.colorGrey,
                      weight: FontWeight.w500,
                      size: AppFontsStyle.textFontSize12),
                  SizedBox(height: 16.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppFontsStyle.getAppTextViewBold("${agent?.accountName?.toTitleCase()!}",
                          weight: FontWeight.w400,
                          size: AppFontsStyle.textFontSize14),
                      AppFontsStyle.getAppTextViewBold("${agent?.accountNumber?.toTitleCase()!}",
                          weight: FontWeight.w400,
                          size: AppFontsStyle.textFontSize14),
                      AppFontsStyle.getAppTextViewBold("${agent?.bankName?.toTitleCase()!}",
                          weight: FontWeight.w400,
                          size: AppFontsStyle.textFontSize14),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AppFontsStyle.getAppTextViewBold("${agent?.phoneNumber?.toTitleCase()!} (Whatsapp and Telegram)",
                        weight: FontWeight.w400,
                        size: AppFontsStyle.textFontSize14),

                    SizedBox(
                      height: 12,
                    ),

                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read(sharedProvider.userBuyProvider).moveBuyToPreviousPage();
                          },
                          child: Container(
                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.0, color: Pallet.colorRed),
                                borderRadius:
                                BorderRadius.all(Radius.circular(2))),
                            child: Center(
                              child: AppFontsStyle.getAppTextViewBold(
                                "Cancel",
                                color: Pallet.colorRed,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 50,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Pallet.colorBlue,
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: AppButton(
                                onPressed: (){
                                  context.read(sharedProvider.userBuyProvider).buyDhoro(context);
                                },
                                title: "I HAVE MADE A TRANSFER",
                                disabledColor: Pallet.colorYellow.withOpacity(0.2),
                                titleColor: Pallet.colorWhite,
                                enabledColor: isValidLogin ? Pallet.colorBlue : Pallet.colorBlue.withOpacity(0.2),
                                enabled: isValidLogin ? true : false),
                          ),
                        ),
                      ],
                    ),
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
