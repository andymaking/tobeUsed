import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PopupView extends StatelessWidget {
  Function()? onPressed;
  String title;
  PopupView({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 150,
        height: 22,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppFontsStyle.getAppTextViewBold(title,
                size: 14, textAlign: TextAlign.center, color: Pallet.colorBlue),
            Spacer(),
            SvgPicture.asset("assets/images/ic_arrow_forward.svg"),
          ],
        ),
      ),
    );
  }
}
