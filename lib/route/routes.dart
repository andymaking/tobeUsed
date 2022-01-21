import 'package:dhoro_mobile/ui/buy_dhoro/buy_dhoro_pages_container.dart';
import 'package:dhoro_mobile/ui/buy_dhoro/select_payment_processor.dart';
import 'package:dhoro_mobile/ui/changePassword/change_password.dart';
import 'package:dhoro_mobile/ui/createAccount/signup.dart';
import 'package:dhoro_mobile/ui/dashboard/dashboard.dart';
import 'package:dhoro_mobile/ui/email_verification/email_verification.dart';
import 'package:dhoro_mobile/ui/login/login.dart';
import 'package:dhoro_mobile/ui/overview/overview.dart';
import 'package:dhoro_mobile/ui/overview/send.dart';
import 'package:dhoro_mobile/ui/overview/send_dhoro.dart';
import 'package:dhoro_mobile/ui/password_and_security/password_and_security.dart';
import 'package:dhoro_mobile/ui/payment_processor/payment_processor.dart';
import 'package:dhoro_mobile/ui/payment_processor/payment_processor_list.dart';
import 'package:dhoro_mobile/ui/personal_info/edit_profile_image_options.dart';
import 'package:dhoro_mobile/ui/personal_info/personal_info.dart';
import 'package:dhoro_mobile/ui/request/requests.dart';
import 'package:dhoro_mobile/route/route_error_page.dart';
import 'package:dhoro_mobile/ui/settings/settings.dart';
import 'package:dhoro_mobile/ui/transactions/transactions.dart';
import 'package:dhoro_mobile/ui/verify_your_email/verify_your_email.dart';
import 'package:dhoro_mobile/ui/withdraw_dhoro/select_withdraw_payment_processor.dart';
import 'package:dhoro_mobile/ui/withdraw_dhoro/withdraw_dhoro_pages_container.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const home = '/home';
  static const login = '/login';
  static const verifyYourEmail = '/verifyYourEmail';
  static const emailVerification = '/emailVerification';
  static const onBoarding = '/onboarding';
  static const signUp = '/sign-up';
  static const forgotPassword = '/forgot-password';
  static const successForgotPassword = '/success-forgot-password';
  static const resetPassword = '/reset-password';
  static const personalInfo = '/personalInfo';
  static const editProfile = '/edit-profile';
  static const changePassword = '/change-password';
  static const overview = '/overview';
  static const dashboard = '/dashboard';
  static const settings = '/settings';
  static const transactions = '/transactions';
  static const requests = '/requests';
  static const passwordAndSecurity = '/passwordAndSecurity';
  static const paymentProcessor = '/paymentProcessor';
  static const paymentProcessorList = '/paymentProcessorList';
  static const withdraw = '/stepper';
  static const buy = '/buyStepper';
  static const uploadPhotosOptions = '/uploadPhotosOptions';
  static const selectBuyPaymentProcessor = '/selectBuyPaymentProcessor';
  static const selectWithdrawPaymentProcessor = '/selectWithdrawPaymentProcessor';
  static const sendDhoro = '/sendDhoro';
  static const send = '/send';



}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // E.g Navigator.of(context).pushNamed(AppRoutes.home);
    switch (settings.name) {
      case AppRoutes.dashboard:
        return MaterialPageRoute<dynamic>(
          builder: (_) => DashboardPage(selectedIndex: 0,),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.overview:
        return MaterialPageRoute<dynamic>(
          builder: (_) => OverviewPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.transactions:
        return MaterialPageRoute<dynamic>(
          builder: (_) => TransactionsPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.requests:
        return MaterialPageRoute<dynamic>(
          builder: (_) => RequestsPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.login:
        return MaterialPageRoute<dynamic>(
          builder: (_) => LoginPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.signUp:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SignUpPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.verifyYourEmail:
        return MaterialPageRoute<dynamic>(
          builder: (_) => VerifyYourEmailPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.uploadPhotosOptions:
        return MaterialPageRoute<dynamic>(
          builder: (_) => EditProfileImageOptionsPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.selectWithdrawPaymentProcessor:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SelectWithdrawPaymentProcessorPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.settings:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SettingsPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.changePassword:
        return MaterialPageRoute<dynamic>(
          builder: (_) => ChangePasswordPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.selectBuyPaymentProcessor:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SelectPaymentProcessorPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.personalInfo:
        return MaterialPageRoute<dynamic>(
          builder: (_) => PersonalInformationPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.passwordAndSecurity:
        return MaterialPageRoute<dynamic>(
          builder: (_) => PasswordAndSecurityPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.paymentProcessor:
        return MaterialPageRoute<dynamic>(
          builder: (_) => PaymentProcessorPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.paymentProcessorList:
        return MaterialPageRoute<dynamic>(
          builder: (_) => PaymentProcessorListPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.withdraw:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SetupPagerContainer(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.buy:
        return MaterialPageRoute<dynamic>(
          builder: (_) => BuySetupPagerContainer(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.sendDhoro:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SendDhoroPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.send:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SendPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => ErrorPage(),
          settings: settings,
          fullscreenDialog: true,
        );
    }
  }
}
