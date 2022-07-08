import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ussage_app/app/data/cache_helper.dart';
import 'package:ussage_app/app/data/models/user.dart';
import 'package:ussage_app/app/firebase_helpers/firebase_firestore_helper.dart';
import 'package:ussage_app/generated/locales.g.dart';
import '../../../../constants/exports.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  int selectedIndex = 0;
  double dragExtent = 0;
  double turns = 0.0;
  late AnimationController menuAnimationController;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isMenuButtonClicked = false;
  final double actionThreshold = 0.6;
  Size size = const Size(0, 0);

  List<String> categories = [
    LocaleKeys.all.tr,
    LocaleKeys.important.tr,
    LocaleKeys.unread.tr,
    LocaleKeys.read.tr
  ];

  void changeTurns() {
    if (isMenuButtonClicked) {
      turns -= 1 / 4;
      menuAnimationController.reverse();
    } else {
      turns += 1 / 4;
      menuAnimationController.forward();
    }
    isMenuButtonClicked = !isMenuButtonClicked;
    update();
  }

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  void onDragStart(DragStartDetails details,
      AnimationController animationController, User user) {
    if (animationController.value >= 0) {
      size = const Size(0, 0);
      user.size = size;
    }
    dragExtent = 0;
    animationController.reset();
    update();
  }

  void onDragUpdate(
      DragUpdateDetails details, AnimationController animationController) {
    dragExtent += details.primaryDelta!;
    if (dragExtent >= 0) {
      return;
    }
    animationController.value = dragExtent.abs() / 360;
    update();
  }

  void onDragEnd(DragEndDetails details,
      AnimationController animationController, User user) {
    if (animationController.value > actionThreshold) {
      animationController.value = 0.62;
      _onSlided(user);
    } else {
      animationController.fling(velocity: -1);
    }
  }

  void _onSlided(User user) {
    size = const Size(360 * 0.6, 92);
    user.size = size;
    update();
  }

  Future<void> makeUserSaved(User user) async {
    user.isSaved = !user.isSaved;
    await FireStoreHelper().updateUser(user: user);
    String savingStatus = (user.isSaved == true)
        ? "User has been added to the saved users list!"
        : "User has been deleted from the saved users list!";
    Get.showSnackbar(GetSnackBar(
      message: savingStatus,
      duration: const Duration(seconds: 2),
    ));
  }

  Future<void> makeUserRead(User user) async {
    final refUsers = FirebaseFirestore.instance.collection('Users');
    user.lastMessages[CacheController.instance.getUserId()]!.isRead = true;
    await refUsers.doc(user.idUser).update({
      UserField.lastMessages: user.lastMessagesToJSON()
    });
  }

  Future<void> deleteUser(User user) async {
    bool status = await FireStoreHelper().deleteUser(user: user);
    if (status) {
      Get.showSnackbar(const GetSnackBar(
        message: "User has been deleted Succesfully!",
        duration: Duration(seconds: 2),
      ));
    }
    update();
  }

  @override
  void onInit() {
    menuAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    super.onInit();
  }

  void selectCategory(int index) {
    selectedIndex = index;
    update();
  }

  @override
  void onClose() {
    menuAnimationController.dispose();
  }
}
