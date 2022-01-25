import 'package:dhoro_mobile/utils/color.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message) {
  Fluttertoast.showToast(
  msg: message,
  backgroundColor: Pallet.colorBlue,
  // fontSize: 25
  // gravity: ToastGravity.TOP,
  // textColor: Colors.pink
  );
}