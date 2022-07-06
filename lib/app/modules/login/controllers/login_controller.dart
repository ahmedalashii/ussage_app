import 'package:ussage_app/app/data/cache_helper.dart';

import '../../../../constants/exports.dart';
import '../../../firebase_controllers/firebase_auth_controller.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;

  @override
  void onInit() {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    super.onInit();
  }

  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  Future<void> login() async {
    bool status = await FirebaseAuthController().signIn(
        email: emailTextController.text, password: passwordTextController.text);
    if (status) {
      Get.offNamed(Routes.HOME);
      CacheController.instance.setUserEmail(emailTextController.text);
    }
  }

  bool checkData() {
    // Single Responsibility method
    if (emailTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty) {
      return true;
    }
    Get.showSnackbar(const GetSnackBar(
      message: "Enter Required Data",
      duration: Duration(seconds: 2),
    ));
    return false;
  }

  @override
  void onClose() {
    emailTextController.dispose();
    passwordTextController.dispose();
  }
}
