import 'package:dhoro_mobile/data/remote/model/payment_processor/payment_processor.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:dhoro_mobile/ui/withdraw_dhoro/withdraw_dhoro_pages_container.dart' as sharedProvider;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class WithdrawSummaryPage extends StatefulHookWidget {
  const WithdrawSummaryPage({Key? key}) : super(key: key);

  @override
  _WithdrawSummaryPageState createState() => _WithdrawSummaryPageState();
}

class _WithdrawSummaryPageState extends State<WithdrawSummaryPage> {

  @override
  void dispose() {
    context.read(sharedProvider.userRequestProvider).controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isValidLogin = true;
    GetUserData? userData = useProvider(sharedProvider.userRequestProvider).user;
    print("userData walletId... ${userData?.wid}");
    List<PaymentProcessorData>? userTransactions =
        useProvider(sharedProvider.userRequestProvider).paymentProcessor;
    context.read(sharedProvider.userRequestProvider).paymentId = "${userTransactions.first.pk}";
    context.read(sharedProvider.userRequestProvider).userName = "${userTransactions.first.label!.toTitleCase()!}";
    context.read(sharedProvider.userRequestProvider).bankName = "${userTransactions.first.processor}";
    context.read(sharedProvider.userRequestProvider).accountNumber = "${userTransactions.first.value}";


    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 220.0,),
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
                                context.read(sharedProvider.userRequestProvider).userName.isEmpty
                                    ? AppFontsStyle.getAppTextViewBold("${userTransactions.first.label!.toTitleCase()!}",
                                    weight: FontWeight.w500,
                                    size: AppFontsStyle.textFontSize12)
                                : AppFontsStyle.getAppTextViewBold(context.read(sharedProvider.userRequestProvider).userName,
                                weight: FontWeight.w500,
                                size: AppFontsStyle.textFontSize12),
                                SizedBox(height: 12.0,),
                                context.read(sharedProvider.userRequestProvider).bankName.isEmpty
                                    ? AppFontsStyle.getAppTextViewBold("${userTransactions.first.processor!}",
                                    weight: FontWeight.w500,
                                    size: AppFontsStyle.textFontSize12)
                                    : AppFontsStyle.getAppTextViewBold(context.read(sharedProvider.userRequestProvider).bankName,
                                    weight: FontWeight.w500,
                                    size: AppFontsStyle.textFontSize12),
                                SizedBox(height: 12.0,),
                                context.read(sharedProvider.userRequestProvider).accountNumber.isEmpty
                                    ? AppFontsStyle.getAppTextViewBold("${userTransactions.first.value!}",
                                    weight: FontWeight.w500,
                                    size: AppFontsStyle.textFontSize12)
                                    : AppFontsStyle.getAppTextViewBold(context.read(sharedProvider.userRequestProvider).accountNumber,
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
                                  onTap: (){
                                    Navigator.pushNamed(context, AppRoutes.selectWithdrawPaymentProcessor);
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
                    SizedBox(height: 16.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppFontsStyle.getAppTextViewBold("You are withdrawing "
                            "${context.read(sharedProvider.userRequestProvider).amount} "
                            "${context.read(sharedProvider.userRequestProvider).currencyType}",
                            weight: FontWeight.w400,
                            size: AppFontsStyle.textFontSize14),
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    Row(
                      children: [
                        AppFontsStyle.getAppTextViewBold("Wallet ID",
                            color: Pallet.colorGrey,
                            weight: FontWeight.w500,
                            size: AppFontsStyle.textFontSize12),
                        Spacer(),
                        AppFontsStyle.getAppTextViewBold("${userData?.wid}",
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
                        AppFontsStyle.getAppTextViewBold("Agent Name:",
                            color: Pallet.colorGrey,
                            weight: FontWeight.w500,
                            size: AppFontsStyle.textFontSize12),
                        Spacer(),
                        AppFontsStyle.getAppTextViewBold(""
                            "${context.read(sharedProvider.userRequestProvider)
                            .anAgents?.accountName?.toTitleCase()}",
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
                        AppFontsStyle.getAppTextViewBold("Agent Bank:",
                            color: Pallet.colorGrey,
                            weight: FontWeight.w500,
                            size: AppFontsStyle.textFontSize12),
                        Spacer(),
                        AppFontsStyle.getAppTextViewBold(""
                            "${context.read(sharedProvider.userRequestProvider)
                            .anAgents?.bankName?.toTitleCase()}",
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
                        AppFontsStyle.getAppTextViewBold("Agent Phone:",
                            color: Pallet.colorGrey,
                            weight: FontWeight.w500,
                            size: AppFontsStyle.textFontSize12),
                        Spacer(),
                        AppFontsStyle.getAppTextViewBold(""
                            "${context.read(sharedProvider.userRequestProvider)
                            .anAgents?.phoneNumber}",
                            weight: FontWeight.w500,
                            size: AppFontsStyle.textFontSize12),
                        SizedBox(height: 12.0,),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    AppButton(
                        onPressed: (){
                          context.read(sharedProvider.userRequestProvider).withdrawDhoro(context);
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
