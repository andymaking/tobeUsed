import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:dhoro_mobile/ui/withdraw_dhoro/withdraw_dhoro_pages_container.dart' as sharedProvider;
import 'package:dhoro_mobile/ui/buy_dhoro/buy_dhoro_pages_container.dart' as sharedBuyProvider;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppProgressBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: Pallet.colorBlue,
    );
  }
}

class BuyProgressBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          BuyStepNumbers(),
          SizedBox(height: 8.0,),
          BuyStepNames(
            true,
          )
        ],
      ),
    );
  }
}

class BuyStepNumbers extends HookWidget {

  @override
  Widget build(BuildContext context) {
    final currentPage = useProvider(sharedBuyProvider.userBuyProvider).currentPage;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundedBorderText(
              "1",
              currentPage == 0 ? true : false
          ),
          Container(
            width: MediaQuery.of(context).size.width/3 -30,
            child: Divider(
              height: 1,
              color: Pallet.colorBlue,
            ),
          ),
          RoundedBorderText(
              "2",
              currentPage == 1 ? true : false
          ),
          Container(
            width: MediaQuery.of(context).size.width/3 - 30,
            child: Divider(
              height: 1,
              color: Pallet.colorBlue,
            ),
          ),
          RoundedBorderText(
              "3",
              currentPage == 2 ? true : false
          )
        ],
      ),
    );
  }
}

class BuyStepNames extends HookWidget {
  bool isEnabled;

  BuyStepNames(this.isEnabled);

  @override
  Widget build(BuildContext context) {
    final currentPage = useProvider(sharedBuyProvider.userBuyProvider).currentPage;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AppFontsStyle.getAppTextViewBold(
              "Amount",
              weight: FontWeight.w500,
              size: AppFontsStyle.textFontSize12,
              color: currentPage == 0 ? Pallet.colorBlue : Pallet.colorGrey,
              textAlign: TextAlign.center),
          Container(
            width: MediaQuery.of(context).size.width/4 -22,
            child: Divider(
              height: 1,
              color: Colors.transparent,
            ),
          ),
          AppFontsStyle.getAppTextViewBold(
              "Checkout",
              weight: FontWeight.w500,
              size: AppFontsStyle.textFontSize12,
              color: currentPage == 1 ? Pallet.colorBlue : Pallet.colorGrey,
              textAlign: TextAlign.center),
          Container(
            width: MediaQuery.of(context).size.width/4 - 22,
            child: Divider(
              height: 1,
              color: Colors.transparent,
            ),
          ),
          AppFontsStyle.getAppTextViewBold(
              "Payment",
              weight: FontWeight.w500,
              size: AppFontsStyle.textFontSize12,
              color: currentPage == 2 ? Pallet.colorBlue : Pallet.colorGrey,
              textAlign: TextAlign.center)
        ],
      ),
    );
  }
}

class WithdrawProgressBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          WithdrawStepNumbers(),
          SizedBox(height: 8.0,),
          WithdrawStepNames(
            true,
          )
        ],
      ),
    );
  }
}

class WithdrawStepNumbers extends HookWidget {

  @override
  Widget build(BuildContext context) {
    final currentPage = useProvider(sharedProvider.userRequestProvider).currentPage;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundedBorderText(
              "1",
              currentPage == 0 ? true : false
          ),
          Container(
            width: MediaQuery.of(context).size.width/3 -30,
            child: Divider(
              height: 1,
              color: Pallet.colorBlue,
            ),
          ),
          RoundedBorderText(
              "2",
              currentPage == 1 ? true : false
          ),
          Container(
            width: MediaQuery.of(context).size.width/3 - 30,
            child: Divider(
              height: 1,
              color: Pallet.colorBlue,
            ),
          ),
          RoundedBorderText(
              "3",
              currentPage == 2 ? true : false
          )
        ],
      ),
    );
  }
}

class WithdrawStepNames extends HookWidget {
  bool isEnabled;

  WithdrawStepNames(this.isEnabled);

  @override
  Widget build(BuildContext context) {
    final currentPage = useProvider(sharedProvider.userRequestProvider).currentPage;
    //context.read(sharedProvider.userRequestProvider).currentPage;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AppFontsStyle.getAppTextViewBold(
              "Amount",
              weight: FontWeight.w500,
              size: AppFontsStyle.textFontSize12,
              color: currentPage == 0 ? Pallet.colorBlue : Pallet.colorGrey,
              textAlign: TextAlign.center),
          Container(
            width: MediaQuery.of(context).size.width/4 -22,
            child: Divider(
              height: 1,
              color: Colors.transparent,
            ),
          ),
          AppFontsStyle.getAppTextViewBold(
              "Bank Account",
              weight: FontWeight.w500,
              size: AppFontsStyle.textFontSize12,
              color: currentPage == 1 ? Pallet.colorBlue : Pallet.colorGrey,
              textAlign: TextAlign.center),
          Container(
            width: MediaQuery.of(context).size.width/4 - 22,
            child: Divider(
              height: 1,
              color: Colors.transparent,
            ),
          ),
          AppFontsStyle.getAppTextViewBold(
              "Summary",
              weight: FontWeight.w500,
              size: AppFontsStyle.textFontSize12,
              color: currentPage == 2 ? Pallet.colorBlue : Pallet.colorGrey,
              textAlign: TextAlign.center)
          // WithdrawStepName(
          //   "Amount",
          //   true
          // ),
          // Spacer(),
          // WithdrawStepName(
          //     "Wallet ID",
          //     false
          // ),
          // WithdrawStepName(
          //     "Summary",
          //     false
          // ),
        ],
      ),
    );
  }
}

class RoundedBorderText extends StatelessWidget {
String number;
bool isEnabled;

RoundedBorderText(this.number, this.isEnabled);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:  Border.all(
            width: 1.0,
          color: isEnabled ? Pallet.colorBlue : Pallet.colorGrey,),
        borderRadius: BorderRadius.all(Radius.circular(50)),),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
        child: AppFontsStyle.getAppTextViewBold(
            number,
            weight: FontWeight.w500,
            size: AppFontsStyle.textFontSize13,
            color: isEnabled ? Pallet.colorBlue : Pallet.colorGrey,
            textAlign: TextAlign.center),
      ),
    );
  }
}


class WithdrawStepName extends StatelessWidget {
  String name;
  bool isEnabled;

  WithdrawStepName(this.name, this.isEnabled);

  @override
  Widget build(BuildContext context) {
    return AppFontsStyle.getAppTextViewBold(
        name,
        weight: FontWeight.w500,
        size: AppFontsStyle.textFontSize12,
        color: isEnabled ? Pallet.colorBlue : Pallet.colorGrey,
        textAlign: TextAlign.center);
  }
}