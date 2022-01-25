
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/domain/viewmodel/profile_viewmodel.dart';
import 'package:dhoro_mobile/main.dart';
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_toolbar.dart';
import 'package:dhoro_mobile/widgets/button.dart';
import 'package:dhoro_mobile/widgets/size_24_container.dart';
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

final _profileStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(profileProvider).viewState;
});
final profileStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_profileStateProvider);
});

class SettingsPage extends StatefulHookWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isPersonalInfoSelected = false;
  bool isPasswordAndSecuritySelected = false;
  bool isPaymentProcessorSelected = false;

  @override
  Widget build(BuildContext context) {
    GetUserData? userData = useProvider(profileProvider).user;
    final initials =
        "${userData?.firstName?[0] ?? ""}${userData?.lastName?[0] ?? ""}";

    return Scaffold(
      backgroundColor: Pallet.colorBackground,
      body: SafeArea(
        child: Container(
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
                height: 24,
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    isPersonalInfoSelected = !isPersonalInfoSelected;
                    isPasswordAndSecuritySelected = false;
                    isPaymentProcessorSelected = false;
                  });
                  Navigator.of(context).pushNamed(AppRoutes.personalInfo);
                },
                child: Sized24Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: isPersonalInfoSelected == true ? Pallet.colorWhite : Colors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.icUser),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0,top: 8.0, bottom: 8.0),
                          child: AppFontsStyle.getAppTextView("Personal Information",
                              color: isPersonalInfoSelected == true ? Pallet.colorBlue : Pallet.colorBlue.withOpacity(0.7),
                              size: AppFontsStyle.textFontSize14),
                        ),
                        Spacer(),
                        SvgPicture.asset(AppImages.icArrowForward),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    isPersonalInfoSelected = false;
                    isPasswordAndSecuritySelected = !isPasswordAndSecuritySelected;
                    isPaymentProcessorSelected = false;
                  });
                  Navigator.of(context).pushNamed(AppRoutes.passwordAndSecurity);
                },
                child: Sized24Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: isPasswordAndSecuritySelected == true ? Pallet.colorWhite : Colors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.icShield),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0,top: 8.0, bottom: 8.0),
                          child: AppFontsStyle.getAppTextView("Password and Security",
                              color: isPasswordAndSecuritySelected == true ? Pallet.colorBlue : Pallet.colorBlue.withOpacity(0.7),
                              size: AppFontsStyle.textFontSize14),
                        ),
                        Spacer(),
                        SvgPicture.asset(AppImages.icArrowForward),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    isPersonalInfoSelected = false;
                    isPasswordAndSecuritySelected = false;
                    isPaymentProcessorSelected = !isPaymentProcessorSelected;
                  });
                  Navigator.of(context).pushNamed(AppRoutes.paymentProcessorList);
                },
                child: Sized24Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: isPaymentProcessorSelected == true ? Pallet.colorWhite : Colors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.icPayment),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0,top: 8.0, bottom: 8.0),
                          child: AppFontsStyle.getAppTextView("Payment Processor",
                              color: isPaymentProcessorSelected == true ? Pallet.colorBlue : Pallet.colorBlue.withOpacity(0.7),
                              size: AppFontsStyle.textFontSize14),
                        ),
                        Spacer(),
                        SvgPicture.asset(AppImages.icArrowForward),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () async {
                  showBottomSheet(context);
                },
                child: Sized24Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.icLogout),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 8.0,top: 8.0, bottom: 8.0),
                          child: AppFontsStyle.getAppTextView("Log Out",
                              color: Pallet.colorRed,
                              size: AppFontsStyle.textFontSize14),
                        ),
                        Spacer(),
                        SvgPicture.asset(AppImages.icArrowForward),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        context: ctx,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        builder: (ctx) => Container(
          height: 425,
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
              AppFontsStyle.getAppTextViewBold("Log Out",
                  color: Pallet.colorRed,
                  weight: FontWeight.w700,
                  size: AppFontsStyle.textFontSize16),
              SizedBox(
                height: 24,
              ),
              SvgPicture.asset(AppImages.icLogout, height: 80, width: 80,),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppFontsStyle.getAppTextView("Are you sure you want to log out of your Dhoro account?",
                    size: AppFontsStyle.textFontSize12),
              ),
              SizedBox(
                height: 40,
              ),
              Sized24Container(
                child: AppButton(
                  title: 'LOG OUT',
                  titleColor: Pallet.colorWhite,
                  enabledColor: Pallet.colorRed,
                  enabled: true,
                  disabledColor: Pallet.colorGrey,
                  onPressed: () async {
                    setState(() {
                      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
                    });
                  },
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Sized24Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color:Pallet.colorBlue),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    color: Pallet.colorWhite),
                child: AppButton(
                  title: 'Cancel',
                  titleColor: Pallet.colorBlue,
                  enabledColor: Pallet.colorWhite,
                  enabled: true,
                  disabledColor: Pallet.colorWhite,
                  onPressed: () async {
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ));
  }

}
