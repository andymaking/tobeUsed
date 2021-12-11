import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/size_24_container.dart';
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
