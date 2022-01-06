import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_toolbar.dart';
import 'package:dhoro_mobile/widgets/size_24_container.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileImageOptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double imageSize = (MediaQuery.of(context).size.width / 2) - 24;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                OverViewToolBar(
                  "Upload Images from:",
                  "",
                  trailingIconClicked: () => null,
                  initials: "",
                ),
                SizedBox(
                  height: 24,
                ),
                Sized24Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final ImagePicker _picker = ImagePicker();
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          Navigator.of(context).pop(image?.path);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: (imageSize),
                              width: (imageSize  - 20),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                                  color: const Color(0xfff5f5f5)),
                              child: Center(
                                child: SvgPicture.asset(
                                    "assets/images/gallery.svg"),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            AppFontsStyle.getAppTextView("Your Photos")
                          ],
                        ),
                      ),
                      SizedBox(width: 4,),
                      GestureDetector(
                        onTap: () async {
                          final ImagePicker _picker = ImagePicker();
                          final XFile? photo = await _picker.pickImage(
                              source: ImageSource.camera);
                          Navigator.of(context).pop(photo?.path);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: (imageSize),
                              width: (imageSize - 20),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                                  color: const Color(0xfff5f5f5)),
                              child: Center(
                                child: SvgPicture.asset(
                                    "assets/images/camera_colored.svg"),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            AppFontsStyle.getAppTextView("Camera")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  show(context);
                },
                child: Container(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/camera_spark.png"),
                      SizedBox(
                        height: 8,
                      ),
                      AppFontsStyle.getAppTextViewBold(
                          "Images tips and guidelines",
                          size: 14),
                      SizedBox(
                        height: 8,
                      ),
                      SvgPicture.asset("assets/images/arrow_up_orange.svg")
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void show(BuildContext ctx) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        context: ctx,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        builder: (ctx) => Container(
          height: 300,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 8,
              ),
              SvgPicture.asset("assets/images/top_indicator.svg"),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/profile_correct.png"),
                  SizedBox(
                    width: 18,
                  ),
                  Image.asset("assets/images/profile_wrong1.png"),
                  SizedBox(
                    width: 18,
                  ),
                  Image.asset("assets/images/profile_wrong2.png"),
                ],
              ),
              SizedBox(
                height: 16,
              ),

              SizedBox(
                height: 24,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(ctx).pop();
                  },
                  child: AppFontsStyle.getAppTextViewBold("Upload Images",
                      color: Pallet.colorBlue, size: 12)),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ));
  }

}