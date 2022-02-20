import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppButton extends StatelessWidget {
  Function()? onPressed;
  String title;
  Color disabledColor;
  Color titleColor;
  Color enabledColor;
  bool enabled;
  Widget? icon;
  bool? showIcon;

  AppButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      required this.disabledColor,
      required this.titleColor,
      required this.enabledColor,
      required this.enabled,
      this.icon,
      this.showIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: enabled ? enabledColor : disabledColor,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppFontsStyle.getAppTextViewBold(title,
                    size: AppFontsStyle.textFontSize16,
                    color: titleColor),
                Container(
                  padding: EdgeInsets.only(left: 6),
                  child: icon != null
                      ? SvgPicture.asset(
                          AppImages.iconGreenArrowUp,
                          width: 10,
                          height: 10,
                        )
                      : icon,
                )
              ],
            ),
          ),
        ),
        onPressed: enabled ? onPressed : null);
  }
}
