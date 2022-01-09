
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyYourEmailPage extends StatefulWidget {
  const VerifyYourEmailPage({Key? key}) : super(key: key);

  @override
  _VerifyYourEmailPageState createState() => _VerifyYourEmailPageState();
}

class _VerifyYourEmailPageState extends State<VerifyYourEmailPage> {
  final isValidLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppImages.appLogo),
                      ],
                    ),

                    SizedBox(height: 70.0,),
                    AppFontsStyle.getAppTextViewBold(
                      AppString.verifyYourEmail,
                      weight: FontWeight.w700,
                      size: AppFontsStyle.textFontSize32,
                    ),
                    SizedBox(height: 24.0,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: AppFontsStyle.getAppTextView(
                          AppString.confirmYourEmailAddress,
                          size: AppFontsStyle.textFontSize14,
                          textAlign: TextAlign.center,
                          color: Pallet.colorGrey
                      ),
                    ),
                    SizedBox(height: 64.0,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: AppFontsStyle.getAppTextView(
                          AppString.yourOneTimeVerificationCode,
                          size: AppFontsStyle.textFontSize14,
                          textAlign: TextAlign.center,
                          color: Pallet.colorGrey
                      ),
                    ),
                    SizedBox(height: 8.0,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: AppFontsStyle.getAppTextViewBold(
                        "756354",
                        weight: FontWeight.w700,
                        size: AppFontsStyle.textFontSize32,
                      ),
                    ),
                    SizedBox(height: 80.0,),
                    AppButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed(AppRoutes.login);
                        },
                        title: AppString.verifyBtn,
                        disabledColor: Pallet.colorYellow.withOpacity(0.2),
                        titleColor: Pallet.colorWhite,
                        enabledColor: isValidLogin ? Pallet.colorBlue : Pallet.colorBlue.withOpacity(0.2),
                        enabled: isValidLogin ? true : false),
                    SizedBox(
                      height: 150,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppImages.icDhoroFinance),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppImages.icFacebook),
                        SizedBox(
                          width: 24,
                        ),
                        SvgPicture.asset(AppImages.icYouTube),
                        SizedBox(
                          width: 24,
                        ),
                        SvgPicture.asset(AppImages.inInstagram),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppFontsStyle.getAppTextView(
                            AppString.unsubscribe,
                            size: AppFontsStyle.textFontSize14,
                            textAlign: TextAlign.center,
                            color: Pallet.colorBlue
                        ),
                        AppFontsStyle.getAppTextView(
                            AppString.termsAndCondition,
                            size: AppFontsStyle.textFontSize14,
                            textAlign: TextAlign.center,
                            color: Pallet.colorBlue
                        ),
                        AppFontsStyle.getAppTextView(
                            AppString.privacyPolicy,
                            size: AppFontsStyle.textFontSize14,
                            textAlign: TextAlign.center,
                            color: Pallet.colorBlue
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
