
import 'package:dhoro_mobile/data/core/table_constants.dart';
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/data/remote/model/user/logged_in_user.dart';
import 'package:dhoro_mobile/domain/viewmodel/login_viewmodel.dart';
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
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final signInProvider =
ChangeNotifierProvider.autoDispose<LoginViewModel>((ref) {
  ref.onDispose(() {});
  final viewModel = locator.get<LoginViewModel>();
  //viewModel.getUser();
  return viewModel;
});

final _validLoginProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(signInProvider).isValidForgotPassword;
});

final validSignInProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(_validLoginProvider);
});

final _signInStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(signInProvider).viewState;
});

final signInStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_signInStateProvider);
});


class ForgotPasswordPage extends StatefulHookWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final isValidLogin = true;

  @override
  Widget build(BuildContext context) {
    final isValidSignIn = useProvider(validSignInProvider);
    final signInViewState = useProvider(signInStateProvider);

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
                        "Forgot Password",
                        weight: FontWeight.w700,
                        size: AppFontsStyle.textFontSize32,
                      ),
                      SizedBox(height: 64.0,),
                      AppFormField(
                        label: AppString.emailAddress,
                        controller: _emailController,
                        onChanged: (value) {
                          context.read(signInProvider).email = value.trim();
                          context.read(signInProvider).validateForgotPassword();
                        },
                        validator: (value) {
                          if (context.read(signInProvider).isValidEmail()) {
                            return "Enter a valid email address.";
                          }
                          return null;
                        },
                        isHidden: false,
                      ),

                      SizedBox(
                        height: 64,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                title: "Cancel",
                                disabledColor: Pallet.colorBlue.withOpacity(0.2),
                                titleColor: Pallet.colorRed,
                                enabledColor: Pallet.colorBlue,
                                enabled: true),
                          ),
                          SizedBox(
                            width: 35,
                          ),
                          signInViewState == ViewState.Loading
                              ? Center(child: AppProgressBar())
                              : Expanded(
                              child: AppButton(
                                  onPressed: () async {
                                    await context.read(signInProvider).forgotPassword(context,_emailController.text.trim());
                                  },
                                  title: "Proceed",
                                  disabledColor: Pallet.colorBlue.withOpacity(0.2),
                                  titleColor: Pallet.colorWhite,
                                  enabledColor: isValidSignIn ? Pallet.colorBlue : Pallet.colorBlue.withOpacity(0.2),
                                  enabled: isValidSignIn ? true : false),)
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
      ),
    );
  }

  void observeSignInState(BuildContext context) async {
    final signInViewModel = context.read(signInProvider);
    print('email ${signInViewModel.email}');
    var signIn = await signInViewModel.forgotPassword(context,signInViewModel.email);
    if (signInViewModel.viewState == ViewState.Success) {
      print('forgotPassword details $signIn');
      updateLoginStatus();
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.dashboard, (route) => false);
    } else {
      await showTopModalSheet<String>(
          context: context,
          child: ShowDialog(
            title:
            'Login failed. ${signInViewModel.errorMessage}. Kindly confirm your login details and try again.',
            isError: true,
            onPressed: () {},
          ));
    }
  }

  void updateLoginStatus() async {
    final box = await Hive.openBox<bool>(DbTable.LOGIN_TABLE_NAME);
    box.add(true);
    print("Print login status $box");
  }
}
