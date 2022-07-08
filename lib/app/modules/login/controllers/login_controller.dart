import 'package:ussage_app/app/data/cache_helper.dart';
import 'package:ussage_app/app/firebase_helpers/firebase_auth_helper.dart';
import 'package:ussage_app/app/firebase_helpers/firebase_firestore_helper.dart';

import '../../../../constants/exports.dart';
import '../../../data/models/user.dart';
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
    await FirebaseAuthHelper()
        .signIn(
            email: emailTextController.text,
            password: passwordTextController.text)
        .then((String? userUid) async {
      if (userUid != null) {
        User? user = await FireStoreHelper().getUser(userUid);
        await CacheController.instance.cacheLoggedInUser(user!.toJSON());
        CacheController.instance.setAuthed(true);
        CacheController.instance.setUserId(userUid);
        Get.offNamed(Routes.HOME);
      }
    });
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
