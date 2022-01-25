import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/domain/viewmodel/signup_viewmodel.dart';
import 'package:dhoro_mobile/main.dart';
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/ui/email_verification/email_verification.dart';
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

final signUpProvider =
    ChangeNotifierProvider.autoDispose((ref) => locator.get<SignUpViewModel>());

final _validLoginProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(signUpProvider).isValidSignUp;
});

final validSignUpProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(_validLoginProvider);
});

final _signUpStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(signUpProvider).viewState;
});

final signUpStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_signUpStateProvider);
});

class SignUpPage extends StatefulHookWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final isValidLogin = true;

  @override
  Widget build(BuildContext context) {
    final isValidSignUp = useProvider(validSignUpProvider);
    final signUpViewState = useProvider(signUpStateProvider);

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
                      SizedBox(
                        height: 20.0,
                      ),
                      AppToolBar(
                        trailingIconClicked: () {},
                      ),
                      SizedBox(
                        height: 70.0,
                      ),
                      AppFontsStyle.getAppTextViewBold(
                        AppString.getStartedWithDhoro,
                        weight: FontWeight.w700,
                        size: AppFontsStyle.textFontSize32,
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: AppFontsStyle.getAppTextView(
                            AppString.getStartedTwoSteps,
                            size: AppFontsStyle.textFontSize14,
                            textAlign: TextAlign.center,
                            color: Pallet.colorGrey),
                      ),
                      SizedBox(
                        height: 64.0,
                      ),
                      AppFormField(
                        label: AppString.firstName,
                        controller: _firstNameController,
                        onChanged: (value) {
                          context.read(signUpProvider).firstName = value.trim();
                          context.read(signUpProvider).validateSignUp();
                        },
                        validator: (value) {
                          if (context.read(signUpProvider).isValidFirstName()) {
                            return "Enter a valid first name.";
                          }
                          return null;
                        },
                        isHidden: false,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      AppFormField(
                        label: AppString.lastName,
                        controller: _lastNameController,
                        onChanged: (value) {
                          context.read(signUpProvider).lastName = value.trim();
                          context.read(signUpProvider).validateSignUp();
                        },
                        validator: (value) {
                          if (context.read(signUpProvider).isValidLastName()) {
                            return "Enter a valid last name.";
                          }
                          return null;
                        },
                        isHidden: false,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      AppFormField(
                        label: AppString.emailAddress,
                        controller: _emailController,
                        onChanged: (value) {
                          context.read(signUpProvider).email = value.trim();
                          context.read(signUpProvider).validateSignUp();
                        },
                        validator: (value) {
                          if (context.read(signUpProvider).isValidEmail()) {
                            return "Enter a valid email address.";
                          }
                          return null;
                        },
                        isHidden: false,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      AppFormField(
                        label: AppString.choosePassword,
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          context.read(signUpProvider).password = value.trim();
                          context.read(signUpProvider).validateSignUp();
                        },
                        validator: (value) {
                          if (context.read(signUpProvider).isValidPassword()) {
                            return "Enter a valid password";
                          }
                          return null;
                        },
                        isHidden: false,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: AppFontsStyle.getAppTextView(
                            AppString.termsAndConditions,
                            size: AppFontsStyle.textFontSize14,
                            textAlign: TextAlign.center,
                            color: Pallet.colorGrey),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      signUpViewState == ViewState.Loading
                          ? Center(child: AppProgressBar())
                          : AppButton(
                              onPressed: () {
                                isValidSignUp
                                    ? observeSignUpState(
                                        context,
                                      )
                                    : print('Seems like theres a problem');
                                //Navigator.of(context).pushNamed(AppRoutes.verifyYourEmail);
                              },
                              title: AppString.createAccount,
                              disabledColor: Pallet.colorBlue.withOpacity(0.2),
                              titleColor: Pallet.colorWhite,
                              enabledColor: isValidSignUp
                                  ? Pallet.colorBlue
                                  : Pallet.colorGrey,
                              enabled: isValidSignUp ? true : false),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRoutes.login);
                            },
                            child: Center(
                              child: Text.rich(
                                TextSpan(
                                    text: AppString.alreadyHaveAccount,
                                    style: GoogleFonts.manrope(
                                      fontSize: 14,
                                      height: 1.5,
                                      color: Pallet.colorGrey,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: AppString.loginSecurely,
                                        style: GoogleFonts.manrope(
                                          fontSize: 14,
                                          height: 1.2,
                                          color: Pallet.colorBlue,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ]),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void observeSignUpState(BuildContext context) async {
    final signUpViewModel = context.read(signUpProvider);
    await signUpViewModel.register(
      signUpViewModel.firstName,
      signUpViewModel.lastName,
      signUpViewModel.email,
      signUpViewModel.password,
    );
    if (signUpViewModel.viewState == ViewState.Success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EmailVerificationPage(
             email: signUpViewModel.email,
          ),
        ),
      );
      //Navigator.of(context).pushNamed(AppRoutes.verifyYourEmail);
    } else {
      await showTopModalSheet<String>(
          context: context,
          child: ShowDialog(
            title: 'Sign up failed. ${signUpViewModel.errorMessage}',
            isError: true,
            onPressed: () {},
          ));
    }
  }
}
