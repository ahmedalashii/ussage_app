import 'package:get/get.dart';

import '../controllers/single_chat_controller.dart';

class SingleChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SingleChatController>(
      SingleChatController(),
    );
  }
}
