import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_text_field.dart';
import 'package:dhoro_mobile/widgets/app_toolbar.dart';
import 'package:dhoro_mobile/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentProcessorPage extends StatefulWidget {
  const PaymentProcessorPage({Key? key}) : super(key: key);

  @override
  _PaymentProcessorPageState createState() => _PaymentProcessorPageState();
}

class _PaymentProcessorPageState extends State<PaymentProcessorPage> {
  TextEditingController _accountNumberController = TextEditingController();
  TextEditingController _bankNameController = TextEditingController();
  TextEditingController _accountNameController = TextEditingController();
  final isValidLogin = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.colorBackground,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  OverViewToolBar(AppString.settings, ""),
                  SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 24),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            color: const Color(0xfffffffff)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppFontsStyle.getAppTextViewBold(
                                "Payment Processor",
                                weight: FontWeight.w600,
                                size: AppFontsStyle.textFontSize14,
                              ),
                              SizedBox(height: 32.0,),
                              AppFontsStyle.getAppTextViewBold(
                                "Payment Processor",
                                weight: FontWeight.w500,
                                size: AppFontsStyle.textFontSize12,
                              ),
                              SizedBox(height: 8.0,),
                              AppFontsStyle.getAppTextViewBold(
                                  "Add, edit your payment processor details. You will buy and withdraw Dhoro using this payment processor or institution.",
                                  size: AppFontsStyle.textFontSize12,
                                  weight: FontWeight.w400,
                                  color: Pallet.colorGrey
                              ),
                              SizedBox(height: 24.0,),

                              AppFormField(
                                label: "Account Number",
                                controller: _accountNameController,
                                onChanged: (value) {

                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              AppFormField(
                                label: "Name of Bank or Institution",
                                controller: _bankNameController,
                                onChanged: (value) {

                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              AppFormField(
                                label: "Account Name",
                                controller: _accountNameController,
                                onChanged: (value) {

                                },
                              ),
                              SizedBox(height: 32.0,),
                              AppButton(
                                  onPressed: (){
                                    Navigator.of(context).pushNamed(AppRoutes.dashboard);
                                  },
                                  title: "Add Payment Processor",
                                  disabledColor: Pallet.colorYellow.withOpacity(0.2),
                                  titleColor: Pallet.colorWhite,
                                  icon: SvgPicture.asset(
                                    AppImages.icSave,
                                  ),
                                  enabledColor: isValidLogin ? Pallet.colorBlue : Pallet.colorBlue.withOpacity(0.2),
                                  enabled: isValidLogin ? true : false),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectImage extends StatefulWidget {
  const SelectImage({Key? key}) : super(key: key);

  @override
  _SelectImageState createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            child: SvgPicture.asset(
              AppImages.icDefaultImage,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppImages.icOpen,
              ),
              Container(
                  width: double.infinity,
                  height: 70,
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                          text: "Click here ",
                          style: GoogleFonts.manrope(
                            fontSize: 12,
                            height: 1.5,
                            color: Pallet.colorBlue,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "to upload files",
                              style: GoogleFonts.manrope(
                                fontSize: 12,
                                height: 1.2,
                                color: Pallet.colorGrey,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,),
                            ),
                          ]
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}


class ImageToDisplay extends StatelessWidget {
  Function()? onClick;
  String title;
  double height;
  //double width;

  ImageToDisplay(this.title, this.height,/*this.width,*/ {onClick}) {
    this.onClick = onClick;
  }

  @override
  Widget build(BuildContext context) {
    bool isFile = title.isNotEmpty && !title.startsWith("http") && "$title" != "null";
    File? file = isFile ? File(title) : null;
    bool isShowImage = (title.isNotEmpty && "$title" != "null");

    return isShowImage
        ? GestureDetector(
      onTap: onClick,
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          child: isFile
              ? Image.file(
            file!,
            fit: BoxFit.cover,
            height: height,
            width: MediaQuery.of(context).size.width,
          )
              : CachedNetworkImage(
              width: double.infinity,
              height: double.infinity,
              imageUrl: title,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Image.asset(
                "assets/images/ic_avatar.svg",
                fit: BoxFit.cover,
              ) //Icon(Icons.error),
          ),
        ),
      ),
    )
        : GestureDetector(
      onTap: onClick,
      child: Container(
        height: 62,
        width: 267,
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color:Pallet.colorBlue),
            borderRadius: BorderRadius.all(Radius.circular(2)),
            color: const Color(0xfffffffff)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                AppImages.icOpen,
                width: 10,
                height: 10,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
                width: double.infinity,
                child: Center(
                  child: Text.rich(
                    TextSpan(
                        text: "Click here ",
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          height: 1.5,
                          color: Pallet.colorBlue,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "to upload files",
                            style: GoogleFonts.manrope(
                              fontSize: 12,
                              height: 1.2,
                              color: Pallet.colorGrey,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,),
                          ),
                        ]
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}