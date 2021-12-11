
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_text_field.dart';
import 'package:dhoro_mobile/widgets/app_toolbar.dart';
import 'package:dhoro_mobile/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
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
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                  AppString.getStartedWithDhoro,
                  weight: FontWeight.w700,
                  size: AppFontsStyle.textFontSize32,
                ),
                SizedBox(height: 24.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: AppFontsStyle.getAppTextView(
                      AppString.getStartedTwoSteps,
                      size: AppFontsStyle.textFontSize14,
                      textAlign: TextAlign.center,
                      color: Pallet.colorGrey
                  ),
                ),
                SizedBox(height: 64.0,),
                AppFormField(
                  label: AppString.firstName,
                  controller: _firstNameController,
                  onChanged: (value) {

                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AppFormField(
                  label: AppString.lastName,
                  controller: _lastNameController,
                  onChanged: (value) {

                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AppFormField(
                  label: AppString.emailAddress,
                  controller: _emailController,
                  onChanged: (value) {

                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AppFormField(
                  label: AppString.choosePassword,
                  controller: _passwordController,
                  onChanged: (value) {

                  },
                ),
                SizedBox(height: 16.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: AppFontsStyle.getAppTextView(
                      AppString.termsAndConditions,
                      size: AppFontsStyle.textFontSize14,
                      textAlign: TextAlign.center,
                      color: Pallet.colorGrey
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                AppButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed(AppRoutes.verifyYourEmail);
                    },
                    title: AppString.createAccount,
                    disabledColor: Pallet.colorYellow.withOpacity(0.2),
                    titleColor: Pallet.colorWhite,
                    enabledColor: isValidLogin ? Pallet.colorBlue : Pallet.colorGrey,
                    enabled: isValidLogin ? true : false),
                SizedBox(
                  height: 16,
                ),
                Container(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: (){
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
                                    fontWeight: FontWeight.w700,),
                                ),
                              ]
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
