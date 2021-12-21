import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:dhoro_mobile/ui/withdraw_dhoro/withdraw_dhoro_pages_container.dart' as sharedProvider;
import 'package:flutter_riverpod/src/provider.dart';

class WithdrawAccountDetailsPage extends StatefulWidget {
  const WithdrawAccountDetailsPage({Key? key}) : super(key: key);

  @override
  _WithdrawAccountDetailsPageState createState() => _WithdrawAccountDetailsPageState();
}

class _WithdrawAccountDetailsPageState extends State<WithdrawAccountDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final isValidLogin = true;

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
                    SizedBox(height: 280.0,),

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
                                AppFontsStyle.getAppTextViewBold("Jason Smith",
                                    weight: FontWeight.w500,
                                    size: AppFontsStyle.textFontSize12),
                                SizedBox(height: 12.0,),
                                AppFontsStyle.getAppTextViewBold("4682 3674 3676",
                                    weight: FontWeight.w500,
                                    size: AppFontsStyle.textFontSize12),
                                SizedBox(height: 12.0,),
                                AppFontsStyle.getAppTextViewBold("First Bank of Nigeria",
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

                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap:(){
                            context.read(sharedProvider.userRequestProvider).moveToPreviousPage();
              },
                          child: Container(
                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.0, color: Pallet.colorRed),
                              borderRadius: BorderRadius.all(Radius.circular(2))),
                            child: Center(
                              child: AppFontsStyle.getAppTextViewBold("Cancel",
                                  color: Pallet.colorRed,),
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: (){
                            context.read(sharedProvider.userRequestProvider).moveToNextPage();
                          },
                          child: Container(
                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Pallet.colorBlue,
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(
                                color: Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: AppFontsStyle.getAppTextViewBold("PROCEED",
                                  color: Pallet.colorWhite,),
                            ),
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
