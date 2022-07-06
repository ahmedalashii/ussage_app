import '../../../../constants/exports.dart';

class ForgetPasswordController extends GetxController {
  late TextEditingController emailTextController;

  @override
  void onInit() {
    emailTextController = TextEditingController();
    super.onInit();
  }

  Future<void> performForgetPassword() async {
    if (checkData()) {
      await forgetPassword();
    }
  }

  bool checkData() {
    // Single Responsibility method
    if (emailTextController.text.isNotEmpty) {
      return true;
    }
    Get.showSnackbar(const GetSnackBar(
      message: "Enter Required Data",
      duration: Duration(seconds: 2),
    ));
    return false;
  }

  Future<void> forgetPassword() async {
    // bool status = await StudentApiController()
    //     .forgetPassword(context: context, email: _emailTextController.text);
    // if (status) {
    //   // Navigator.pushReplacementNamed(context, "/reset_password_screen");
    //   Navigator.pushReplacement(
    //     // we use this because we want to pass data to the other screen (reset password screen).
    //     context,
    //     MaterialPageRoute(
    //       builder: (BuildContext context) => ResetPasswordScreen(email: _emailTextController.text),
    //     ),
    //   );
    // }
  }

  @override
  void onClose() {
    emailTextController.dispose();
  }
}
