
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/domain/viewmodel/verify_account_viewmodel.dart';
import 'package:dhoro_mobile/main.dart';
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_progress_bar.dart';
import 'package:dhoro_mobile/widgets/app_text_field.dart';
import 'package:dhoro_mobile/widgets/app_toolbar.dart';
import 'package:dhoro_mobile/widgets/button.dart';
import 'package:dhoro_mobile/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final verifyProvider =
ChangeNotifierProvider.autoDispose((ref) => locator.get<VerifyAccountViewModel>());

final _validVerifyProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(verifyProvider).isValidOTP;
});

final validVerifyProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(_validVerifyProvider);
});

final _verifyStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(verifyProvider).viewState;
});

final verifyStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_verifyStateProvider);
});

class EmailVerificationPage extends StatefulHookWidget {
  final String email;
  EmailVerificationPage({Key? key, required this.email}) : super(key: key);

  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  TextEditingController _verificationCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final isValidLogin = true;

  @override
  Widget build(BuildContext context) {
    final isValidVerify = useProvider(validVerifyProvider);
    final verifyViewState = useProvider(verifyStateProvider);

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20.0,),
                      AppToolBar(
                        trailingIconClicked: (){

                        },
                      ),
                      SizedBox(height: 70.0,),
                      AppFontsStyle.getAppTextViewBold(
                        AppString.emailVerification,
                        weight: FontWeight.w700,
                        size: AppFontsStyle.textFontSize32,
                      ),
                      SizedBox(height: 24.0,),
                      Container(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: (){
                              //Navigator.of(context).pushNamed(AppRoutes.signUp);
                            },
                            child: Center(
                              child: Text.rich(
                                TextSpan(
                                    text: AppString.completeYourRegistration,
                                    style: GoogleFonts.manrope(
                                      fontSize: AppFontsStyle.textFontSize14,
                                      height: 1.5,
                                      color: Pallet.colorGrey,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: widget.email,
                                        style: GoogleFonts.manrope(
                                          fontSize: AppFontsStyle.textFontSize14,
                                          height: 1.2,
                                          color: Pallet.colorBlue,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w600,),
                                      ),
                                    ]
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                      ),
                      SizedBox(height: 64.0,),
                      AppFormField(
                        label: AppString.verificationCode,
                        controller: _verificationCodeController,
                        onChanged: (value) {
                          context.read(verifyProvider).otp = value.trim();
                          context.read(verifyProvider).validateVerify();
                        },
                        validator: (value) {
                          if (context.read(verifyProvider).isValidOtp()) {
                            return "Enter a valid OTP code.";
                          }
                          return null;
                        },
                        isHidden: false,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      verifyViewState == ViewState.Loading
                          ? Center(child: AppProgressBar())
                          : AppButton(
                          onPressed: (){
                            // isValidVerify
                            //     ?
                            observeVerificationState(
                              context,
                            );
                               // : print('Seems like theres a problem');
                            //Navigator.of(context).pushNamed(AppRoutes.login);
                          },
                          title: "COMPLETE REGISTRATION",
                          disabledColor: Pallet.colorBlue.withOpacity(0.2),
                          titleColor: Pallet.colorWhite,
                          enabledColor: isValidVerify ? Pallet.colorBlue : Pallet.colorBlue.withOpacity(0.2),
                          enabled: isValidVerify ? true : false),
                      SizedBox(
                        height: 16,
                      ),

                    ],
                  ),
                ),
              ),
            ]

          ),
        ),
      ),
    );
  }

  void observeVerificationState(BuildContext context) async {
    final verifyViewModel = context.read(verifyProvider);
    await verifyViewModel.verifyAccount(
      verifyViewModel.otp,
    );
    if (verifyViewModel.viewState == ViewState.Success) {
      Navigator.of(context).pushNamed(AppRoutes.dashboard);
    } else {
      await showTopModalSheet<String>(
          context: context,
          child: ShowDialog(
            title: 'Verification failed. ${verifyViewModel.errorMessage}',
            isError: true,
            onPressed: () {},
          ));
    }
  }
}
