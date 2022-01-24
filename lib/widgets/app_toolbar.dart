import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_progress_bar.dart';
import 'package:dhoro_mobile/widgets/circle_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppToolBar extends StatelessWidget {
  Function()? trailingIconClicked;

  //String trailingIcon;
  AppToolBar(/*this.trailingIcon,*/ {this.trailingIconClicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Row(
            children: [
              Image.asset(
                AppImages.appLogo,
                width: 45,
                height: 45,
              ),
              //SizedBox(width: 8,),
              AppFontsStyle.getAppTextViewBold(
                "Dhoro",
                weight: FontWeight.w700,
                size: AppFontsStyle.textFontSize20,
              ),
            ],
          ),
          Spacer(),
          // GestureDetector(
          //     onTap: () {
          //       trailingIconClicked ?? Navigator.of(context).pop();
          //     },
          //     child:
          //     SvgPicture.asset(AppImages.iconClose)),
        ],
      ),
    );
  }
}

class OverViewToolBar extends StatelessWidget {
  Function()? trailingIconClicked;
  String title;
  String? initials;
  String? userImage;

  //ViewState? viewState;
  OverViewToolBar(
    this.title,
    this.userImage, {
    this.trailingIconClicked,
    this.initials,
    /*this.viewState*/
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(1)),
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
              child: SvgPicture.asset(AppImages.icNotifications)),
          SizedBox(
            width: 24.0,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: GestureDetector(
                onTap: () {
                  trailingIconClicked ?? Navigator.of(context).pop();
                },
                child: //viewState == ViewState.Loading ? AppProgressBar() :
                    userImage == null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Center(
                              child: AppFontsStyle.getAppTextViewBold(initials,
                                  color: Pallet.colorBlue, size: 20.0),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              'https://api.dhoro.io$userImage',
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return SvgPicture.asset(
                                  "assets/images/ic_avatar.svg",
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.contain,
                                );
                              },
                            ),
                          )
                ),
          ),
          //),
        ],
      ),
    );
  }
}
