import 'dart:io';

import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/payment_processor/payment_processor.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/ui/withdraw_dhoro/withdraw_dhoro_pages_container.dart' as sharedProvider;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _overviewStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(sharedProvider.userRequestProvider).viewState;
});
final processorStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_overviewStateProvider);
});

class SelectWithdrawPaymentProcessorPage extends StatefulHookWidget {
  const SelectWithdrawPaymentProcessorPage({Key? key}) : super(key: key);

  @override
  _SelectWithdrawPaymentProcessorPageState createState() => _SelectWithdrawPaymentProcessorPageState();
}

class _SelectWithdrawPaymentProcessorPageState extends State<SelectWithdrawPaymentProcessorPage> {
  final isValidLogin = true;


  @override
  Widget build(BuildContext context) {
    ViewState viewState = useProvider(processorStateProvider);
    List<PaymentProcessorData>? userTransactions =
        useProvider(sharedProvider.userRequestProvider).paymentProcessor;
    GetUserData? userData = useProvider(sharedProvider.userRequestProvider).user;
    final initials =
        "${userData?.firstName?[0] ?? ""}${userData?.lastName?[0] ?? ""}";

    return Scaffold(
      backgroundColor: Pallet.colorBackground,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 24),
                    child: Container(
                      height: 500,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            color: const Color(0xfffffffff)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppFontsStyle.getAppTextViewBold(
                                "Payment Processor",
                                weight: FontWeight.w600,
                                size: AppFontsStyle.textFontSize14,
                              ),
                              SizedBox(height: 32.0,),
                              AppFontsStyle.getAppTextViewBold(
                                "Click on select button to select the one you wish to use.",
                                weight: FontWeight.w500,
                                size: AppFontsStyle.textFontSize12,
                              ),
                              SizedBox(height: 24.0,),
                              userTransactions.isNotEmpty == true
                               ? viewState == ViewState.Loading
                                  ? Center(child: CircularProgressIndicator())
                                  : Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(2)),
                                    color: const Color(0xfffffffff)),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: List.generate(userTransactions.length, (index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 2.0),
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                PaymentDetailsView(
                                                    (){
                                                      setState(() {
                                                        context.read(sharedProvider.userRequestProvider).paymentId = userTransactions[index].pk!;
                                                        context.read(sharedProvider.userRequestProvider).userName = userTransactions[index].label!.toTitleCase()!;
                                                        context.read(sharedProvider.userRequestProvider).bankName = userTransactions[index].processor!.toTitleCase()!;
                                                        context.read(sharedProvider.userRequestProvider).accountNumber = userTransactions[index].label!;

                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    userTransactions[index].label!.toTitleCase()!,
                                                    userTransactions[index].processor!,
                                                    userTransactions[index].value!
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              )
                              : Center(
                                child: Container(
                                  child: AppFontsStyle.getAppTextViewBold(
                                      "You do not have any Payment Processor,\n Add one now",
                                      size: AppFontsStyle.textFontSize12,
                                      weight: FontWeight.w600,
                                      textAlign: TextAlign.center,
                                      color: Pallet.colorGrey
                                  ),
                                ),
                              ),

                              SizedBox(height: 32.0,),

                            ],
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}


class PaymentDetailsView extends StatefulWidget {
  Function()? onDeleteClicked;
  String label;
  String processor;
  String value;

  PaymentDetailsView(
      this.onDeleteClicked, this.label, this.processor, this.value,
      {Key? key})
      : super(key: key);

  @override
  _PaymentDetailsViewState createState() => _PaymentDetailsViewState();
}

class _PaymentDetailsViewState extends State<PaymentDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1.0, color:Pallet.colorGrey),
          borderRadius: BorderRadius.all(Radius.circular(2)),
          color: const Color(0xfffffffff)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // for (var index = 0;
            // index < uploadTwoImages.length;
            // index++)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppFontsStyle.getAppTextViewBold(
                    widget.label,
                    weight: FontWeight.w500,
                    size: AppFontsStyle.textFontSize12,
                  ),
                  SizedBox(height: 12.0,),
                  AppFontsStyle.getAppTextViewBold(
                    widget.value,
                    weight: FontWeight.w500,
                    size: AppFontsStyle.textFontSize12,
                  ),
                  SizedBox(height: 12.0,),
                  AppFontsStyle.getAppTextViewBold(
                    widget.processor,
                    weight: FontWeight.w500,
                    size: AppFontsStyle.textFontSize12,
                  ),
                  //SizedBox(height: 8.0,),
                ],
              ),
            ),
            SizedBox(width: 24.0,),
            GestureDetector(
              onTap: widget.onDeleteClicked,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    color: const Color(0xffD2DFEA)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppFontsStyle.getAppTextViewBold(
                    "Select",
                    weight: FontWeight.w500,
                    color: Pallet.colorBlue,
                    size: AppFontsStyle.textFontSize10,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0,),
          ],
        ),
      ),
    );
  }
}
