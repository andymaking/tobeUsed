import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/payment_processor/payment_processor.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/domain/viewmodel/payment_processor_viewmodel.dart';
import 'package:dhoro_mobile/main.dart';
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_text_field.dart';
import 'package:dhoro_mobile/widgets/app_toolbar.dart';
import 'package:dhoro_mobile/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dhoro_mobile/utils/strings.dart';

final processorProvider =
ChangeNotifierProvider.autoDispose<PaymentProcessorViewModel>((ref) {
  ref.onDispose(() {});
  final viewModel = locator.get<PaymentProcessorViewModel>();
  viewModel.getPaymentProcessor();
  return viewModel;
});

final _overviewStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(processorProvider).viewState;
});
final processorStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_overviewStateProvider);
});

class PaymentProcessorListPage extends StatefulHookWidget {
  const PaymentProcessorListPage({Key? key}) : super(key: key);

  @override
  _PaymentProcessorListPageState createState() => _PaymentProcessorListPageState();
}

class _PaymentProcessorListPageState extends State<PaymentProcessorListPage> {
  final isValidLogin = true;


  @override
  Widget build(BuildContext context) {
    ViewState viewState = useProvider(processorStateProvider);
    List<PaymentProcessorData>? userTransactions =
        useProvider(processorProvider).paymentProcessor;
    GetUserData? userData = useProvider(processorProvider).user;
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
                  OverViewToolBar(
                    AppString.overView,
                    userData?.avatar ?? "",
                    trailingIconClicked: () => null,
                    initials: initials,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 24),
                    child: Container(
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
                                "Payment Processor",
                                weight: FontWeight.w500,
                                size: AppFontsStyle.textFontSize12,
                              ),
                              SizedBox(height: 8.0,),
                              AppFontsStyle.getAppTextViewBold(
                                  "Add, edit your payment processor details. You will buy and withdraw Dhoro using this payment processor or institution.",
                                  size: AppFontsStyle.textFontSize12,
                                  weight: FontWeight.w400,
                                  color: Pallet.colorGrey
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
                                                      context.read(processorProvider).deletePaymentProcessor(userTransactions[index].pk!, context);
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
                              AppButton(
                                  onPressed: (){
                                    Navigator.of(context).pushNamed(AppRoutes.paymentProcessor);
                                  },
                                  title: "Add Payment Processor",
                                  disabledColor: Pallet.colorBlue.withOpacity(0.2),
                                  titleColor: Pallet.colorWhite,
                                  icon: SvgPicture.asset(
                                    AppImages.icSave,
                                  ),
                                  enabledColor: userTransactions.length == 2 ? Pallet.colorBlue.withOpacity(0.2) : Pallet.colorBlue,
                                  enabled: userTransactions.length == 2 ? false : true),
                              SizedBox(
                                height: 16,
                              ),
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

  // void observeDeleteProcessor(BuildContext context) async {
  //   final viewModel = context.read(processorProvider);
  //   await viewModel.deletePaymentProcessor(pk);
  //   if (viewModel.viewState == ViewState.Success) {
  //     await showTopModalSheet<String>(
  //         context: context,
  //         child: ShowDialog(
  //           title:
  //           'Percentage ${viewModel.walletPercentage}',
  //           isError: false,
  //           onPressed: () {},
  //         ));
  //   } else {
  //     await showTopModalSheet<String>(
  //         context: context,
  //         child: ShowDialog(
  //           title: 'Failed to get wallet percentage. ${viewModel.errorMessage}',
  //           isError: true,
  //           onPressed: () {},
  //         ));
  //   }
  // }
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
                    "Delete",
                    weight: FontWeight.w400,
                    color: Pallet.colorRed,
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
