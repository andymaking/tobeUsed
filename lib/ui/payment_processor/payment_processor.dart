import 'package:dhoro_mobile/data/core/view_state.dart';
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
import 'package:hooks_riverpod/hooks_riverpod.dart';

final processorProvider =
ChangeNotifierProvider.autoDispose<PaymentProcessorViewModel>((ref) {
  ref.onDispose(() {});
  final viewModel = locator.get<PaymentProcessorViewModel>();
  viewModel.getPaymentProcessor();
  viewModel.getUser();
  return viewModel;
});

final _overviewStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(processorProvider).viewState;
});
final processorStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_overviewStateProvider);
});

class PaymentProcessorPage extends StatefulHookWidget {
  const PaymentProcessorPage({Key? key}) : super(key: key);

  @override
  _PaymentProcessorPageState createState() => _PaymentProcessorPageState();
}

class _PaymentProcessorPageState extends State<PaymentProcessorPage> {
  TextEditingController _accountNumberController = TextEditingController();
  TextEditingController _bankNameController = TextEditingController();
  TextEditingController _accountNameController = TextEditingController();
  final isValidLogin = true;


  @override
  Widget build(BuildContext context) {
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
                    userData!.avatar.toString(),
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

                              AppFormField(
                                label: "Account Number",
                                controller: _accountNumberController,
                                onChanged: (value) {

                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              AppFormField(
                                label: "Name of Bank or Institution",
                                controller: _bankNameController,
                                onChanged: (value) {

                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              AppFormField(
                                label: "Account Name",
                                controller: _accountNameController,
                                onChanged: (value) {

                                },
                              ),
                              SizedBox(height: 32.0,),
                              AppButton(
                                  onPressed: (){
                                    Navigator.of(context).pushNamed(AppRoutes.paymentProcessorList);
                                  },
                                  title: "Add Payment Processor",
                                  disabledColor: Pallet.colorYellow.withOpacity(0.2),
                                  titleColor: Pallet.colorWhite,
                                  icon: SvgPicture.asset(
                                    AppImages.icSave,
                                  ),
                                  enabledColor: isValidLogin ? Pallet.colorBlue : Pallet.colorBlue.withOpacity(0.2),
                                  enabled: isValidLogin ? true : false),
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
}