import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/repository/user_repository.dart';
import 'package:dhoro_mobile/main.dart';
import 'base/base_view_model.dart';

class SignUpViewModel extends BaseViewModel {
  final userRepository = locator<UserRepository>();

  ViewState _state = ViewState.Idle;
  ViewState get viewState => _state;
  String? errorMessage;
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  bool isValidSignUp = false;

  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  void validateSignUp() {
    isValidSignUp = isValidFirstName() && isValidLastName() && isValidEmail() && isValidPassword();
    notifyListeners();
  }

  bool isValidEmail() {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    return regex.hasMatch(email);
  }

  bool isValidFirstName() {
    return firstName.isNotEmpty && firstName.length > 1;
  }

  bool isValidLastName() {
    return lastName.isNotEmpty && lastName.length > 1;
  }

  bool isValidPassword() {
    return password.isNotEmpty && password.length >= 7;
  }

  /**
   * signup user
   */

  Future<bool?> register(
      String firstname, String lastname, String email, String password,
      ) async {
    try {
      setViewState(ViewState.Loading);
      var signUpResponse =
          await userRepository.register(firstname, lastname, email, password);
      setViewState(ViewState.Success);
    } catch (error) {
      setViewState(ViewState.Error);
      setError(error.toString());
    }
  }
}
