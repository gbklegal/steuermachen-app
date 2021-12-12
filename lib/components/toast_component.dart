import 'package:fluttertoast/fluttertoast.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';

class ToastComponent {
  static void showToast(String message, {bool long = false}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: long ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorConstants.black.withOpacity(0.8),
        textColor: ColorConstants.white,
        fontSize: 16.0);
  }
}
