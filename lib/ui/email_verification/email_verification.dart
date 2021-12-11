
import 'package:dhoro_mobile/ui/route/routes.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_text_field.dart';
import 'package:dhoro_mobile/widgets/app_toolbar.dart';
import 'package:dhoro_mobile/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({Key? key}) : super(key: key);

  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  TextEditingController _verificationCodeController = TextEditingController();
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
                  AppString.emailVerification,
                  weight: FontWeight.w700,
                  size: AppFontsStyle.textFontSize32,
                ),
                SizedBox(height: 24.0,),
                Container(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed(AppRoutes.signUp);
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
                                  text: "rajeshkuthrapoli@gmail.com",
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

                  },
                ),
                SizedBox(
                  height: 24,
                ),
                AppButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed(AppRoutes.home);
                    },
                    title: "COMPLETE REGISTRATION",
                    disabledColor: Pallet.colorYellow.withOpacity(0.2),
                    titleColor: Pallet.colorWhite,
                    enabledColor: isValidLogin ? Pallet.colorBlue : Pallet.colorBlue.withOpacity(0.2),
                    enabled: isValidLogin ? true : false),
                SizedBox(
                  height: 16,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
