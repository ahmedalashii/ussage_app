import '../../../../constants/exports.dart';
import '../../../data/models/user.dart';
import '../../../firebase_controllers/firebase_auth_controller.dart';
import '../../../firebase_controllers/firebase_firestore_controller.dart';

class RegisterController extends GetxController {
  late TextEditingController emailTextController;
  late TextEditingController fullNameTextController;
  late TextEditingController passwordTextController;

  int noOfUsers = 0;

  @override
  void onInit() {
    emailTextController = TextEditingController();
    fullNameTextController = TextEditingController();
    passwordTextController = TextEditingController();
    super.onInit();
  }

  Future<void> performRegister() async {
    if (checkData()) {
      await register();
      await FireStoreController().createUser(
          user: User(
        id: noOfUsers++,
        name: emailTextController.text,
        imageUrl:
            "https://img.freepik.com/free-photo/happy-dark-skinned-girl-enjoys-every-moment-life-dances-moves-raises-arms-clenches-fists-closes-eyes-has-good-mood-wears-denim-sarafan-turtleneck-isolated-pink-wall_273609-42165.jpg?w=2000",
        connectionStatus: false,
      ));
    }
  }

  bool checkData() {
    // Single Responsibility method
    if (emailTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty &&
        fullNameTextController.text.isNotEmpty) {
      return true;
    }
    Get.showSnackbar(const GetSnackBar(
      message: "Enter Required Data",
      duration: Duration(seconds: 2),
    ));
    return false;
  }

  Future<void> register() async {
    await FirebaseAuthController()
        .createAccount(
            email: emailTextController.text,
            password: passwordTextController.text)
        .then((value) {
      if (value) {
        Get.back();
      }
    });
  }

  @override
  void onClose() {
    emailTextController.dispose();
    fullNameTextController.dispose();
    passwordTextController.dispose();
  }
}
