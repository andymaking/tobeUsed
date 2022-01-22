import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/domain/viewmodel/change_password_viewmodel.dart';
import 'package:dhoro_mobile/domain/viewmodel/profile_viewmodel.dart';
import 'package:dhoro_mobile/main.dart';
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_text_field.dart';
import 'package:dhoro_mobile/widgets/app_toolbar.dart';
import 'package:dhoro_mobile/widgets/button.dart';
import 'package:dhoro_mobile/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final profileProvider =
ChangeNotifierProvider.autoDispose<ChangePasswordViewModel>((ref) {
  ref.onDispose(() {});
  final viewModel = locator.get<ChangePasswordViewModel>();
  viewModel.getUser();
  return viewModel;
});

final _validLoginProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(profileProvider).isValidChangePassword;
});

final validChangeProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(_validLoginProvider);
});

final _profileStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(profileProvider).viewState;
});
final profileStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_profileStateProvider);
});

class PasswordAndSecurityPage extends StatefulHookWidget {
  const PasswordAndSecurityPage({Key? key}) : super(key: key);

  @override
  _PasswordAndSecurityPageState createState() => _PasswordAndSecurityPageState();
}

class _PasswordAndSecurityPageState extends State<PasswordAndSecurityPage> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  final isValidLogin = true;
  bool smsValue = false;
  bool emailValue = false;

  @override
  Widget build(BuildContext context) {
    GetUserData? userData = useProvider(profileProvider).user;
    final initials =
        "${userData?.firstName?[0] ?? ""}${userData?.lastName?[0] ?? ""}";
    final viewState = useProvider(profileStateProvider);
    final isValidChange = useProvider(validChangeProvider);

    print("Showing initials $initials");
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
                  OverViewToolBar(
                    AppString.settings,
                    userData?.avatar ?? "",
                    trailingIconClicked: () => null,
                    initials: initials,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.settings, (route) => false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: SvgPicture.asset(
                        "assets/images/back_arrow.svg",
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
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
                                "Password and Security",
                                weight: FontWeight.w700,
                                size: AppFontsStyle.textFontSize14,
                              ),
                              SizedBox(height: 32.0,),
                              AppFontsStyle.getAppTextViewBold(
                                "Change Password",
                                weight: FontWeight.w700,
                                size: AppFontsStyle.textFontSize14,
                              ),
                              SizedBox(height: 8.0,),
                              AppFontsStyle.getAppTextViewBold(
                                  "Keep your password safe from breach",
                                  size: AppFontsStyle.textFontSize12,
                                  weight: FontWeight.w400,
                                  color: Pallet.colorGrey
                              ),
                              SizedBox(height: 24.0,),
                              AppFontsStyle.getAppTextViewBold(
                                "Password must contain:",
                                weight: FontWeight.w700,
                                size: AppFontsStyle.textFontSize14,
                              ),
                              SizedBox(height: 8.0,),
                              AppFontsStyle.getAppTextViewBold(
                                  "\u2022 At least 8 characters \n\u2022 Both uppercase and lower case \n\u2022 At least 1 number ",
                                  size: AppFontsStyle.textFontSize12,
                                  weight: FontWeight.w400,
                                  color: Pallet.colorGrey
                              ),
                              SizedBox(height: 24.0,),

                              AppFormField(
                                label: "Old Password",
                                controller: _oldPasswordController,
                                onChanged: (value) {
                                  context.read(profileProvider).oldPassword = value.trim();
                                  context.read(profileProvider).validateChange();
                                },
                                validator: (value) {
                                  if (context.read(profileProvider).isValidPassword()) {
                                    return "Enter a valid password.";
                                  }
                                  return null;
                                },
                                isHidden: false,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              AppFormField(
                                label: "New Password",
                                controller: _newPasswordController,
                                onChanged: (value) {
                                  context.read(profileProvider).newPassword = value.trim();
                                  context.read(profileProvider).validateChange();
                                },
                                validator: (value) {
                                  if (context.read(profileProvider).isValidNewPassword()) {
                                    return "Enter a valid password.";
                                  }
                                  return null;
                                },
                                isHidden: false,
                              ),
                              // SizedBox(
                              //   height: 16,
                              // ),
                              // AppFormField(
                              //   label: "Repeat New Password",
                              //   controller: _repeatPasswordController,
                              //   onChanged: (value) {
                              //
                              //   },
                              // ),
                              //SizedBox(height: 54.0,),
                              // AppFontsStyle.getAppTextViewBold(
                              //   "Multi factor Authentication",
                              //   weight: FontWeight.w500,
                              //   size: AppFontsStyle.textFontSize12,
                              // ),
                              // SizedBox(
                              //   height: 8,
                              // ),
                              //
                              // AppFontsStyle.getAppTextViewBold(
                              //     "Give your account extra layers of protection by one of the 2FA options",
                              //     size: AppFontsStyle.textFontSize12,
                              //     weight: FontWeight.w400,
                              //     color: Pallet.colorGrey
                              // ),
                              // SizedBox(height: 32.0,),
                              // Row(
                              //   children: [
                              //     Checkbox(
                              //       value: smsValue,
                              //       activeColor: Pallet.colorBlue,
                              //       onChanged: (value) {
                              //         setState(() {
                              //           smsValue = !smsValue;
                              //         });
                              //       },
                              //     ),
                              //     AppFontsStyle.getAppTextViewBold(
                              //       "SMS",
                              //       weight: FontWeight.w400,
                              //       size: AppFontsStyle.textFontSize12,
                              //     ),
                              //   ],
                              // ),
                              // Row(
                              //   children: [
                              //     Checkbox(
                              //       value: smsValue,
                              //     activeColor: Pallet.colorBlue,
                              //       onChanged: (value) {
                              //         setState(() {
                              //           smsValue = !smsValue;
                              //         });
                              //       },
                              //     ),
                              //     AppFontsStyle.getAppTextViewBold(
                              //       "Email",
                              //       weight: FontWeight.w400,
                              //       size: AppFontsStyle.textFontSize12,
                              //     ),
                              //   ],
                              // ),
                              SizedBox(height: 32.0,),
                              viewState == ViewState.Loading
                                  ? Center(child: CircularProgressIndicator())
                                  : AppButton(
                                  onPressed: (){
                                    observeChangePasswordState(context);
                                  },
                                  title: "SAVE CHANGES",
                                  disabledColor: Pallet.colorBlue.withOpacity(0.2),
                                  titleColor: Pallet.colorWhite,
                                  icon: SvgPicture.asset(
                                    AppImages.icSave,
                                  ),
                                  enabledColor: isValidChange ? Pallet.colorBlue : Pallet.colorBlue.withOpacity(0.2),
                                  enabled: isValidChange ? true : false),
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

  void observeChangePasswordState(BuildContext context) async {
    final viewModel = context.read(profileProvider);
    print('oldPassword ${viewModel.oldPassword} newPassword ${viewModel.newPassword}');
    var signIn = await viewModel.changePassword(
        context,
        viewModel.oldPassword,
        viewModel.newPassword);
    if (viewModel.viewState == ViewState.Success) {
      print('changePassword details $signIn');
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.dashboard, (route) => false);
    } else {
      print('changePassword details ${viewModel.errorMessage}');
      // await showTopModalSheet<String>(
      //     context: context,
      //     child: ShowDialog(
      //       title:
      //       '${viewModel.errorMessage}',
      //       isError: true,
      //       onPressed: () {},
      //     ));
    }
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