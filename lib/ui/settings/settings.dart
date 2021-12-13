
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_toolbar.dart';
import 'package:dhoro_mobile/widgets/size_24_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isPersonalInfoSelected = false;
  bool isPasswordAndSecuritySelected = false;
  bool isPaymentProcessorSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.colorBackground,
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              OverViewToolBar(AppString.settings, ""),
              SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    isPersonalInfoSelected = !isPersonalInfoSelected;
                    isPasswordAndSecuritySelected = false;
                    isPaymentProcessorSelected = false;
                  });
                  Navigator.of(context).pushNamed(AppRoutes.personalInfo);
                },
                child: Sized24Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: isPersonalInfoSelected == true ? Pallet.colorWhite : Colors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.icUser),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0,top: 8.0, bottom: 8.0),
                          child: AppFontsStyle.getAppTextView("Personal Information",
                              color: isPersonalInfoSelected == true ? Pallet.colorBlue : Pallet.colorBlue.withOpacity(0.7),
                              size: AppFontsStyle.textFontSize14),
                        ),
                        Spacer(),
                        SvgPicture.asset(AppImages.icArrowForward),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    isPersonalInfoSelected = false;
                    isPasswordAndSecuritySelected = !isPasswordAndSecuritySelected;
                    isPaymentProcessorSelected = false;
                  });
                },
                child: Sized24Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: isPasswordAndSecuritySelected == true ? Pallet.colorWhite : Colors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.icShield),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0,top: 8.0, bottom: 8.0),
                          child: AppFontsStyle.getAppTextView("Password and Security",
                              color: isPasswordAndSecuritySelected == true ? Pallet.colorBlue : Pallet.colorBlue.withOpacity(0.7),
                              size: AppFontsStyle.textFontSize14),
                        ),
                        Spacer(),
                        SvgPicture.asset(AppImages.icArrowForward),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    isPersonalInfoSelected = false;
                    isPasswordAndSecuritySelected = false;
                    isPaymentProcessorSelected = !isPaymentProcessorSelected;
                  });
                },
                child: Sized24Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: isPaymentProcessorSelected == true ? Pallet.colorWhite : Colors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.icPayment),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0,top: 8.0, bottom: 8.0),
                          child: AppFontsStyle.getAppTextView("Payment Processor",
                              color: isPaymentProcessorSelected == true ? Pallet.colorBlue : Pallet.colorBlue.withOpacity(0.7),
                              size: AppFontsStyle.textFontSize14),
                        ),
                        Spacer(),
                        SvgPicture.asset(AppImages.icArrowForward),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
