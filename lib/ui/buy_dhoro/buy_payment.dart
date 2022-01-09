import 'package:dhoro_mobile/data/remote/model/agents/agent.dart';
import 'package:dhoro_mobile/data/remote/model/payment_processor/payment_processor.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
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
  void dispose() {
    context.read(sharedProvider.userRequestProvider).controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isValidLogin = true;
    List<PaymentProcessorData>? userTransactions =
        useProvider(sharedProvider.userRequestProvider).paymentProcessor;
    GetUserData? userData = useProvider(sharedProvider.userRequestProvider).user;
    AgentsData? agent = useProvider(sharedProvider.userRequestProvider).anAgents;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
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
                        // userTransactions[index].label!.toTitleCase()!,
                        // userTransactions[index].processor!,
                        // userTransactions[index].value!
                        AppFontsStyle.getAppTextViewBold("${userTransactions.first.label!}",
                            weight: FontWeight.w500,
                            size: AppFontsStyle.textFontSize12),
                        SizedBox(height: 12.0,),
                        AppFontsStyle.getAppTextViewBold("${userTransactions.first.processor!}",
                            weight: FontWeight.w500,
                            size: AppFontsStyle.textFontSize12),
                        SizedBox(height: 12.0,),
                        AppFontsStyle.getAppTextViewBold("${userTransactions.first.value!}",
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
                        Container(
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  AppFontsStyle.getAppTextViewBold("Kindly make a transfer to the administrator account below:",
                      color: Pallet.colorGrey,
                      weight: FontWeight.w500,
                      size: AppFontsStyle.textFontSize12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppFontsStyle.getAppTextViewBold("You are withdrawing ",
                          weight: FontWeight.w400,
                          size: AppFontsStyle.textFontSize14),
                      AppFontsStyle.getAppTextViewBold("${context.read(sharedProvider.userRequestProvider).amount}",
                          weight: FontWeight.w600,
                          size: AppFontsStyle.textFontSize14),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 250.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppFontsStyle.getAppTextViewBold("You are withdrawing ",
                            weight: FontWeight.w400,
                            size: AppFontsStyle.textFontSize14),
                        AppFontsStyle.getAppTextViewBold("${context.read(sharedProvider.userRequestProvider).amount}",
                            weight: FontWeight.w600,
                            size: AppFontsStyle.textFontSize14),
                      ],
                    ),
                    SizedBox(height: 43.0,),
                    Row(
                      children: [
                        AppFontsStyle.getAppTextViewBold("Wallet ID",
                            color: Pallet.colorGrey,
                            weight: FontWeight.w500,
                            size: AppFontsStyle.textFontSize12),
                        Spacer(),
                        AppFontsStyle.getAppTextViewBold("${userData?.wid ?? ""}",
                            weight: FontWeight.w500,
                            size: AppFontsStyle.textFontSize12),
                        SizedBox(height: 12.0,),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        AppFontsStyle.getAppTextViewBold("Amount:",
                            color: Pallet.colorGrey,
                            weight: FontWeight.w500,
                            size: AppFontsStyle.textFontSize12),
                        Spacer(),
                        AppFontsStyle.getAppTextViewBold("${context.read(sharedProvider.userRequestProvider).amount}",
                            weight: FontWeight.w500,
                            size: AppFontsStyle.textFontSize12),
                        SizedBox(height: 12.0,),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    // Row(
                    //   children: [
                    //     AppFontsStyle.getAppTextViewBold("Transaction Fee:",
                    //         color: Pallet.colorGrey,
                    //         weight: FontWeight.w500,
                    //         size: AppFontsStyle.textFontSize12),
                    //     Spacer(),
                    //     AppFontsStyle.getAppTextViewBold("\$34",
                    //         weight: FontWeight.w500,
                    //         size: AppFontsStyle.textFontSize12),
                    //     SizedBox(height: 12.0,),
                    //   ],
                    // ),
                    SizedBox(
                      height: 100,
                    ),
                    AppButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed(AppRoutes.dashboard);
                        },
                        title: "COMPLETE REQUEST",
                        disabledColor: Pallet.colorYellow.withOpacity(0.2),
                        titleColor: Pallet.colorWhite,
                        enabledColor: isValidLogin ? Pallet.colorBlue : Pallet.colorBlue.withOpacity(0.2),
                        enabled: isValidLogin ? true : false),
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
