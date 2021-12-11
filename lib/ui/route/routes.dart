import 'package:dhoro_mobile/ui/changePassword/change_password.dart';
import 'package:dhoro_mobile/ui/createAccount/signup.dart';
import 'package:dhoro_mobile/ui/login/login.dart';
import 'package:dhoro_mobile/ui/overview/overview.dart';
import 'package:dhoro_mobile/ui/request/requests.dart';
import 'package:dhoro_mobile/ui/route/route_error_page.dart';
import 'package:dhoro_mobile/ui/settings/settings.dart';
import 'package:dhoro_mobile/ui/transactions/transactions.dart';
import 'package:dhoro_mobile/ui/verify_your_email/verify_your_email.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const home = '/home';
  static const login = '/login';
  static const verifyYourEmail = '/verifyYourEmail';
  static const onBoarding = '/onboarding';
  static const signUp = '/sign-up';
  static const forgotPassword = '/forgot-password';
  static const successForgotPassword = '/success-forgot-password';
  static const resetPassword = '/reset-password';
  static const personalInfo = '/personalInfo';
  static const editProfile = '/edit-profile';
  static const changePassword = '/change-password';
  static const overview = '/overview';
  static const settings = '/settings';
  static const transactions = '/transactions';
  static const requests = '/requests';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // E.g Navigator.of(context).pushNamed(AppRoutes.home);
    switch (settings.name) {
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
      case AppRoutes.settings:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SettingsPage(),
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
