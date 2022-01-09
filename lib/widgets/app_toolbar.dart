import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
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
        height: 56,
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.all(Radius.circular(1)),
            color: const Color(0xfffffffff)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: AppFontsStyle.getAppTextViewBold(
                title,
                weight: FontWeight.w700,
                size: AppFontsStyle.textFontSize16,
              ),
            ),
            Spacer(),
            GestureDetector(
                onTap: () {
                  trailingIconClicked ?? Navigator.of(context).pop();
                },
                child:
                SvgPicture.asset(AppImages.icNotifications)),
            SizedBox(width: 24.0,),
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: GestureDetector(
                  onTap: () {
                    trailingIconClicked ?? Navigator.of(context).pop();
                  },
                  child:
                  CircleImageFromNetwork(
                    userImage,
                    "assets/images/ic_avatar.svg",
                    "assets/images/ic_avatar.svg",
                    size: 32.0,
                    text: initials,
                  ),
              ),
            ),
          ],
        ),
      );
  }
}