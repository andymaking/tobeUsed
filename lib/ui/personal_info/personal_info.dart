import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/domain/viewmodel/profile_viewmodel.dart';
import 'package:dhoro_mobile/main.dart';
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_text_field.dart';
import 'package:dhoro_mobile/widgets/app_toolbar.dart';
import 'package:dhoro_mobile/widgets/button.dart';
import 'package:dhoro_mobile/widgets/circle_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final profileProvider =
ChangeNotifierProvider.autoDispose<ProfileViewModel>((ref) {
  ref.onDispose(() {});
  final viewModel = locator.get<ProfileViewModel>();
  //viewModel.getTransferHistory();
  viewModel.getUser();
  return viewModel;
});

final _validProfileProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(profileProvider).isValidProfile;
});

final validProfileProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(_validProfileProvider);
});

final _profileStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(profileProvider).viewState;
});
final profileStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_profileStateProvider);
});

class PersonalInformationPage extends StatefulHookWidget {
  const PersonalInformationPage({Key? key}) : super(key: key);

  @override
  _PersonalInformationPageState createState() => _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _imageController = TextEditingController();

  @override
  void initState() {
    context.read(profileProvider).getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final viewState = useProvider(profileStateProvider);
    final isValidLogin = useProvider(validProfileProvider);
    GetUserData? userData = useProvider(profileProvider).user;
    final initials =
        "${userData?.firstName?[0] ?? ""}${userData?.lastName?[0] ?? ""}";

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
                    AppString.overView,
                    userData?.avatar ?? "",
                    trailingIconClicked: () => null,
                    initials: initials,
                  ),
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
                              "Personal Information",
                              weight: FontWeight.w700,
                              size: AppFontsStyle.textFontSize14,
                            ),
                            SizedBox(height: 32.0,),
                            AppFontsStyle.getAppTextViewBold(
                              "Name",
                              weight: FontWeight.w500,
                              size: AppFontsStyle.textFontSize12,
                            ),
                            SizedBox(height: 8.0,),
                            AppFontsStyle.getAppTextViewBold(
                                "Update how your name is displayed on your profile on Dhoro",
                                size: AppFontsStyle.textFontSize12,
                                weight: FontWeight.w400,
                                color: Pallet.colorGrey
                            ),
                            SizedBox(height: 24.0,),
                            AppFormField(
                              label: AppString.firstName,
                              controller: _firstNameController,
                              onChanged: (value) {
                                context.read(profileProvider).firstName = value.trim();
                                context.read(profileProvider).validateProfile();
                              },
                              validator: (value) {
                                if (context.read(profileProvider).isValidFirstName()) {
                                  return "Enter a valid first name.";
                                }
                                return null;
                              },
                              isHidden: false,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            AppFormField(
                              label: AppString.lastName,
                              controller: _lastNameController,
                              onChanged: (value) {
                                context.read(profileProvider).lastName = value.trim();
                                context.read(profileProvider).validateProfile();
                              },
                              validator: (value) {
                                if (context.read(profileProvider).isValidLastName()) {
                                  return "Enter a valid last name.";
                                }
                                return null;
                              },
                              isHidden: false,
                            ),
                            SizedBox(height: 32.0,),
                            AppFontsStyle.getAppTextViewBold(
                              "Profile Image/Avatar",
                              weight: FontWeight.w500,
                              size: AppFontsStyle.textFontSize12,
                            ),
                            SizedBox(
                              height: 8,
                            ),

                            AppFontsStyle.getAppTextViewBold(
                                "Make changes to the image used for your avatar. Dhoro supports SVG, PNG, JPG or GIF file formats",
                                size: AppFontsStyle.textFontSize12,
                                weight: FontWeight.w400,
                                color: Pallet.colorGrey
                            ),
                            SizedBox(height: 32.0,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // for (var index = 0;
                                // index < uploadTwoImages.length;
                                // index++)
                                Container(
                                  child: CircleImageFromNetwork(
                                    userData?.avatar ?? "",
                                    "assets/images/ic_avatar.svg",
                                    "assets/images/ic_avatar.svg",
                                    size: 40.0,
                                    text: initials,
                                  ),
                                ),
                                SizedBox(width: 24.0,),
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      child: ImageToDisplay(
                                        "",
                                        MediaQuery.of(context).size.width,
                                        //MediaQuery.of(context).size.width,
                                        onClick: () async {
                                          final result = await Navigator.of(context)
                                              .pushNamed(AppRoutes.uploadPhotosOptions);
                                          final path = result.toString();
                                          if(path == "null") return;
                                          context.read(profileProvider).addAvatar(context,path);
                                        },
                                      )
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 32.0,),
                            AppFontsStyle.getAppTextViewBold(
                              "Mobile Contact",
                              weight: FontWeight.w500,
                              size: AppFontsStyle.textFontSize12,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            AppFontsStyle.getAppTextViewBold(
                                "Add a mobile number to your account for SMS based notifications and multi-factor authentication",
                                size: AppFontsStyle.textFontSize12,
                                weight: FontWeight.w400,
                                color: Pallet.colorGrey
                            ),
                            SizedBox(height: 24.0,),
                            AppFormField(
                              label: "Enter phone number",
                              controller: _phoneController,
                              onChanged: (value) {
                                context.read(profileProvider).phoneNumber = value.trim();
                                context.read(profileProvider).validateProfile();
                              },
                              validator: (value) {
                                if (context.read(profileProvider).isValidPhoneNumber()) {
                                  return "Enter a valid phone bumber.";
                                }
                                return null;
                              },
                              isHidden: false,
                            ),
                            SizedBox(height: 32.0,),
                            viewState == ViewState.Loading
                                ? Center(child: CircularProgressIndicator())
                                : AppButton(
                                onPressed: (){
                                  final viewModel = context.read(profileProvider);
                                  context.read(profileProvider).updateUserProfile(
                                    context,
                                      viewModel.firstName,
                                      viewModel.lastName,
                                      viewModel.phoneNumber
                                  );
                                },
                                title: "SAVE CHANGES",
                                disabledColor: Pallet.colorBlue.withOpacity(0.2),
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