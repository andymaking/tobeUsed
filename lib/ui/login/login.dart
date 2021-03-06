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
import 'package:socket_io_client/socket_io_client.dart' as IO;

final signInProvider =
    ChangeNotifierProvider.autoDispose<LoginViewModel>((ref) {
  ref.onDispose(() {});
  final viewModel = locator.get<LoginViewModel>();
  //viewModel.getUser();
  return viewModel;
});

final _validLoginProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(signInProvider).isValidLogin;
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

final _togglePasswordProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(signInProvider).isHidePassword;
});

final togglePasswordProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(_togglePasswordProvider);
});

final _loggedInUserProvider = Provider.autoDispose<GetUserData?>((ref) {
  return ref.watch(signInProvider).user;
});
final loggedInUserProvider = Provider.autoDispose<GetUserData?>((ref) {
  return ref.watch(_loggedInUserProvider);
});

class LoginPage extends StatefulHookWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final isValidLogin = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socketIO();
  }

  void socketIO(){
    print('Loading socketIO');
    IO.Socket socket = IO.io('https://notify.dhoro.io', <String, dynamic> {
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    //socket.send(['notification', "${user?.email}"]);
    socket.emit('notification', "email");
    socket.onConnect((data) {print('Connected');});
    socket.on('notification', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    print(socket.connected);
  }

  @override
  Widget build(BuildContext context) {
    final isValidSignIn = useProvider(validSignInProvider);
    final signInViewState = useProvider(signInStateProvider);
    GetUserData? loggedInUser = useProvider(loggedInUserProvider);
    final isHidden = useProvider(togglePasswordProvider);

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
                        AppString.welcomeBack,
                        weight: FontWeight.w700,
                        size: AppFontsStyle.textFontSize32,
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: AppFontsStyle.getAppTextView(
                            AppString.accessYourDhoro,
                            size: AppFontsStyle.textFontSize14,
                            textAlign: TextAlign.center,
                            color: Pallet.colorGrey),
                      ),
                      SizedBox(
                        height: 64.0,
                      ),
                      AppFormField(
                        label: AppString.emailAddress,
                        controller: _emailController,
                        onChanged: (value) {
                          context.read(signInProvider).email = value.trim();
                          context.read(signInProvider).validateLogin();
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
                        height: 16,
                      ),
                      AppFormField(
                        label: AppString.password,
                        controller: _passwordController,
                        onChanged: (value) {
                          context.read(signInProvider).password = value.trim();
                          context.read(signInProvider).validateLogin();
                        },
                        validator: (value) {
                          if (context.read(signInProvider).isValidPassword()) {
                            return "Enter a valid password";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          iconSize: 18,
                          color: Pallet.colorWhite,
                          onPressed: () =>
                              context.read(signInProvider).togglePassword(),
                          icon: isHidden
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.black,
                                )
                              : const Icon(Icons.visibility,
                                  color: Colors.black),
                        ),
                        isHidden: isHidden,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.forgotPassword);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, bottom: 8.0, left: 8.0),
                              child: AppFontsStyle.getAppTextViewBold(
                                "Forgot Password?",
                                size: AppFontsStyle.textFontSize14,
                                textAlign: TextAlign.center,
                                color: Pallet.colorBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      signInViewState == ViewState.Loading
                          ? Center(child: AppProgressBar())
                          : AppButton(
                              onPressed: () {
                                isValidSignIn
                                    ? observeSignInState(
                                        context,
                                      )
                                    : print('Seems like theres a problem');
                              },
                              title: AppString.login,
                              disabledColor: Pallet.colorBlue.withOpacity(0.2),
                              titleColor: Pallet.colorWhite,
                              enabledColor: isValidSignIn
                                  ? Pallet.colorBlue
                                  : Pallet.colorBlue.withOpacity(0.2),
                              enabled: isValidSignIn ? true : false),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRoutes.signUp);
                            },
                            child: Center(
                              child: Text.rich(
                                TextSpan(
                                    text: AppString.doNotHaveAccount,
                                    style: GoogleFonts.manrope(
                                      fontSize: 14,
                                      height: 1.5,
                                      color: Pallet.colorGrey,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: AppString.registerInstead,
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

  void observeSignInState(BuildContext context) async {
    final signInViewModel = context.read(signInProvider);
    print('email ${signInViewModel.email}');
    var signIn = await signInViewModel.login(
        signInViewModel.email, signInViewModel.password);
    if (signInViewModel.viewState == ViewState.Success) {
      print('signin details $signIn');
      updateLoginStatus();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoutes.dashboard, (route) => false);
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
