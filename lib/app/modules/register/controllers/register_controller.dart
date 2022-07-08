import 'package:ussage_app/app/data/models/user.dart';
import 'package:ussage_app/app/firebase_helpers/firebase_auth_helper.dart';
import 'package:ussage_app/app/firebase_helpers/firebase_firestore_helper.dart';

import '../../../../constants/exports.dart';

class RegisterController extends GetxController {
  late TextEditingController emailTextController;
  late TextEditingController fullNameTextController;
  late TextEditingController passwordTextController;

  int index = 0;

  List<String> imagesUrls = [
    "https://www.allprodad.com/wp-content/uploads/2021/03/05-12-21-happy-people.jpg",
    "https://miro.medium.com/max/1200/1*HEoLBLidT2u4mhJ0oiDgig.png",
    "https://hips.hearstapps.com/ame-prod-menshealth-assets.s3.amazonaws.com/main/embedded/30587/Smilingman.jpg?resize=480:*",
    "https://static.onecms.io/wp-content/uploads/sites/13/2015/04/05/featured.jpg",
    "https://img.freepik.com/free-photo/happy-dark-skinned-girl-enjoys-every-moment-life-dances-moves-raises-arms-clenches-fists-closes-eyes-has-good-mood-wears-denim-sarafan-turtleneck-isolated-pink-wall_273609-42165.jpg?w=2000",
    "https://h.top4top.io/p_23791tpm91.jpg",
    "https://personalexcellence.co/files/girl-smiling2.jpg"
  ];

  @override
  void onInit() {
    emailTextController = TextEditingController();
    fullNameTextController = TextEditingController();
    passwordTextController = TextEditingController();
    super.onInit();
  }

  Future<void> performRegister() async {
    if (checkData()) {
      String? userUid = await register();
      await FireStoreHelper().createUser(
          user: User(
        idUser: userUid!,
        lastMessages: {},
        noOfUnreadMessages: 1,
        isSaved: false,
        name: fullNameTextController.text,
        email: emailTextController.text,
        imageUrl: imagesUrls[index++],
        connectionStatus: false,
      ));
      emailTextController.clear();
      fullNameTextController.clear();
      passwordTextController.clear();
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

  Future<String?> register() async {
    String? userUid = await FirebaseAuthHelper().createAccount(
        email: emailTextController.text, password: passwordTextController.text);
    if (userUid != null) {
      Get.back();
      return userUid;
    }
    return null;
  }

  @override
  void onClose() {
    emailTextController.dispose();
    fullNameTextController.dispose();
    passwordTextController.dispose();
  }
}
