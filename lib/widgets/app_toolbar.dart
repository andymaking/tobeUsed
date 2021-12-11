import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/circle_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppToolBar extends StatelessWidget {
  Function()? trailingIconClicked;
  //String trailingIcon;
  AppToolBar(/*this.trailingIcon,*/ {this.trailingIconClicked});

  @override
  Widget build(BuildContext context) {
    return
      Container(
      child: Row(
        children: [
          SvgPicture.asset(AppImages.appLogo),
          Spacer(),
          GestureDetector(
              onTap: () {
                trailingIconClicked ?? Navigator.of(context).pop();
              },
              child:
              SvgPicture.asset(AppImages.iconClose)),
        ],
      ),
    );
  }
}

class OverViewToolBar extends StatelessWidget {
  Function()? trailingIconClicked;
  String title;
  String? initials;
  String userImage;
  OverViewToolBar(this.title, this.userImage, {this.trailingIconClicked, this.initials});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Row(
          children: [
            AppFontsStyle.getAppTextViewBold(
              AppString.verifyYourEmail,
              weight: FontWeight.w700,
              size: AppFontsStyle.textFontSize32,
            ),
            Spacer(),
            GestureDetector(
                onTap: () {
                  trailingIconClicked ?? Navigator.of(context).pop();
                },
                child:
                SvgPicture.asset(AppImages.icNotifications)),
            SizedBox(width: 24.0,),
            GestureDetector(
                onTap: () {
                  trailingIconClicked ?? Navigator.of(context).pop();
                },
                child:
                CircleImageFromNetwork(
                  userImage,
                  "assets/images/user_icon_checked.svg",
                  "assets/images/user_icon_checked.svg",
                  size: 80.0,
                  text: initials,
                ),
            ),
          ],
        ),
      );
  }
}