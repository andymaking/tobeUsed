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
    GetUserData? userData = useProvider(sharedProvider.userRequestProvider).user;

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
