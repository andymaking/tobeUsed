import 'package:intl/intl.dart';

class AppString{
  static const String appTitle = "Dhoro";
  static const String createAccount = "CREATE A DHORO ACCOUNT";
  static const String login = "LOGIN SECURELY";
  static const String password = "Password";
  static const String firstName = "First Name";
  static const String lastName = "Last Name";
  static const String choosePassword = "Choose Password";
  static const String emailAddress = "Email Address";
  static const String amount = "Amount";
  static const String welcomeBack = "Welcome back!";
  static const String getStartedWithDhoro = "Get started with Dhoro";
  static const String doNotHaveAccount = "Don’t have a Dhoro account? ";
  static const String alreadyHaveAccount = "Already have an account? ";
  static const String loginSecurely = "Log In securely";
  static const String verifyYourEmail = "Verify your Email";
  static const String confirmYourEmailAddress = "Confirm your Email Address to get started with Dhoro and become the latest member of our community";
  static const String yourOneTimeVerificationCode = "Your one time verification code is:";
  static const String verifyBtn = "VERIFY EMAIL ADDRESS";
  static const String unsubscribe = "Unsubscribe";
  static const String termsAndCondition = "Terms and Conditions";
  static const String privacyPolicy = "Privacy Policy";
  static const String emailVerification = "Email Verification";
  static const String verificationCode = "Verification Code";
  static const String registerInstead ="Register instead";
  static const String transactions ="Transactions";
  static const String overView ="Overview";
  static const String requests ="Requests";
  static const String settings ="Settings";
  static const String drm = "1 DHR = \$1.14";
  static const String recentTransactions = "Recent Transactions";
  static const String transactionId = "Transaction ID";
  static const String status = "Status";
  static const String value = "Value";
  static const String from = "From";
  static const String completeYourRegistration = "Complete your registration by providing the six-digit verification code sent to ";
  static const String getStartedTwoSteps = "Get started with Dhoro in two easy steps. Fill out the form below and verify your Email address.";
  static const String accessYourDhoro = "Access your Dhoro account by providing the Email address you signed up with and your password.";
  static const String termsAndConditions ="By clicking the “Create a Dhoro account’ button, you are creating a Dhoro account and you agree to our Privacy Policy and Terms and Conditions";
}

class AppImages{
  static const String appLogo = "assets/images/ic_icon.png";
  static const String icYouTube = "assets/images/ic_youtube.svg";
  static const String icDhoroFinance = "assets/images/ic_dhoro_finance.svg";
  static const String icFacebook = "assets/images/ic_facebook_white.svg";
  static const String inInstagram = "assets/images/ic_instagram_white.svg";
  static const String iconDrawer = "assets/images/ic_drawer.svg";
  static const String iconClose = "assets/images/ic_close.svg";
  static const String iconGreenArrowUp = "assets/images/ic_arrow_green.svg";
  static const String icNotifications = "assets/images/ic_notifications.svg";
  static const String icOverView = "assets/images/ic_overview.svg";
  static const String icTransactions = "assets/images/ic_transactions.svg";
  static const String icRequest = "assets/images/ic_request.svg";
  static const String icSettings = "assets/images/ic_settings.svg";
  static const String icOverViewInActive = "assets/images/ic_overview_inactive.svg";
  static const String icTransactionsInActive = "assets/images/ic_transactions_inactive.svg";
  static const String icRequestInActive = "assets/images/ic_request_inactive.svg";
  static const String icSettingsInActive = "assets/images/ic_settings_inactive.svg";
  static const String triangleUp = "assets/images/ic_triangle_up.svg";
  static const String redArrowDown = "assets/images/ic_red_arrow_down.svg";
  static const String icLock = "assets/images/ic_lock.svg";
  static const String icUnlock = "assets/images/ic_lock_open.svg";
  static const String icEye = "assets/images/ic_eye.svg";
  static const String iconMenu = "assets/images/ic_menu.svg";
  static const String icFilter = "assets/images/ic_filter.svg";
  static const String icBuyer = "assets/images/ic_buy_dhoro.svg";
  static const String icWithdraw = "assets/images/ic_withdraw_dhoro.svg";
  static const String icArrowForward = "assets/images/ic_arrow_forward.svg";
  static const String icUser = "assets/images/ic_user.svg";
  static const String icShield = "assets/images/ic_shield_check.svg";
  static const String icPayment = "assets/images/ic_payment.svg";
  static const String icSave = "assets/images/ic_save.svg";
  static const String icDefaultImage = "assets/images/ic_default_image.png";
  static const String icOpen = "assets/images/ic_open.svg";
  static const String icLogout = "assets/images/ic_logout.svg";
  static const String icArrowSwap = "assets/images/ic_arrow_swap.svg";

}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get formatNull => this.toLowerCase() == "null" ? "Not Available" : this;
  String get formatNullNA => this.toLowerCase() == "null" ? "NA" : this;
  String get allInCaps => this.toUpperCase();
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  String get capitalizeFirstOfEach => this.split(" ").map((str) => str.capitalize).join(" ");
  String capitalizeString() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
  String? toTitleCase() {
    return _convertToTitleCase(this);
  }

  String? _convertToTitleCase(String text) {
    if (text == null) {
      return null;
    }

    if (text.length <= 1) {
      return text.toUpperCase();
    }

    // Split string into multiple words
    final List<String> words = text.split(' ');

    // Capitalize first letter of each words
    final capitalizedWords = words.map((word) {
      if (word.trim().isNotEmpty) {
        final String firstLetter = word.trim().substring(0, 1).toUpperCase();
        final String remainingLetters = word.trim().substring(1);

        return '$firstLetter$remainingLetters';
      }
      return '';
    });

    // Join/Merge all words back to one String
    return capitalizedWords.join(' ');
  }

  /**
   * Formats string type yyyy-mm-dd hh:mm
   * to date object
   */
  DateTime formatStringDateType1(){
    final dateFormat = new DateFormat('yyyy-MM-dd hh:mm');
    var inputDate = dateFormat.parse(this); // <-- Incoming date
    return inputDate;
  }
  /**
   * Formats string type yyyy/mm/dd
   * to date object
   */
  DateTime formatStringDateType2(){
    final dateFormat = new DateFormat('yyyy/MM/dd');
    var inputDate = dateFormat.parse(this); // <-- Incoming date
    return inputDate;
  }
}