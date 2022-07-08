import 'package:ussage_app/app/data/cache_helper.dart';
import 'package:ussage_app/app/modules/home/controllers/home_controller.dart';
import 'package:ussage_app/constants/exports.dart';

import '../../../data/models/message.dart';
import '../../../data/models/user.dart';
import '../../../firebase_helpers/firebase_firestore_helper.dart';

class SingleChatController extends GetxController
    with GetTickerProviderStateMixin {
  // Chat chat = Get.arguments[0] as Chat;
  User user = Get.arguments[0] as User;

  final HomeController homeController = Get.find();
  late ScrollController scrollController;
  late TextEditingController submittingMessageTextController;
  double dragExtent = 0;
  final double actionThreshold = 0;
  Size size = const Size(0, 0);
  late int noOfChatMessages;
  bool isSendIconVisible = false;

  RxList<Message> tempMessages = <Message>[].obs;

  void onDragStart(AnimationController animationController, Message message) {
    size = const Size(0, 0);
    message.size = size;
    dragExtent = 0;
    animationController.reset();
    update();
  }

  void onDragUpdate(DragUpdateDetails details,
      AnimationController animationController, Message message) {
    dragExtent += details.primaryDelta!;
    if (dragExtent < 0 &&
        message.senderIdUser != CacheController.instance.getUserId()) {
      return;
    }
    if (dragExtent >= 0 &&
        message.senderIdUser == CacheController.instance.getUserId()) {
      return;
    }
    _onSlided(message);
    animationController.value = dragExtent.abs() / Get.width * 0.75;
    update();
  }

  void onDragEnd(AnimationController animationController, Message message) {
    animationController.value = 0.4;
    animationController.fling(velocity: -1).then((value) {
      message.size = const Size(0, 0);
      update();
    });
  }

  void _onSlided(Message message) {
    size = Size(Get.width * 0.75, 92);
    message.size = size;
    update();
  }

  void makeSendIconVisible(String value) {
    isSendIconVisible = value.isNotEmpty && !value.startsWith(RegExp("\\s"));
    update();
  }

  void sendMessage({required String idUser, required String msg}) {
    Message message = Message(
      senderIdUser: CacheController.instance.getUserId(),
      receiverIdUser: idUser,
      size: const Size(0, 0),
      createdAt: DateTime.now(),
      text: msg,
    );
    submittingMessageTextController.clear();
    makeSendIconVisible(submittingMessageTextController.text);
    FireStoreHelper().createMessage(receiverIdUser: idUser, message: message);
    update();
  }

  @override
  void onInit() {
    // noOfChatMessages = chat.messages.length; // 10
    // log(noOfChatMessages.toString());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (user.lastMessages.containsKey(CacheController.instance.getUserId())) {
        if (user.lastMessages[CacheController.instance.getUserId()]!
                .senderIdUser !=
            CacheController.instance.getUserId()) {
          await homeController.makeUserRead(user);
        }
      }
      // await fetchMessages();
    });
    scrollController = ScrollController();
    // scrollController.addListener(() async {
    //   if (scrollController.position.atEdge &&
    //       scrollController.position.pixels ==
    //           scrollController.position.maxScrollExtent) {
    //     // if we are the top of the single chat page
    //     if (noOfChatMessages > 0) {
    //       noOfChatMessages -= 5;
    //     }
    //     if (noOfChatMessages >= 0) {
    //       await fetchMessages();
    //     }
    //   }
    //   update();
    // });
    submittingMessageTextController = TextEditingController();
    super.onInit();
  }

  Future<void> onRefresh() async {
    Future.delayed(const Duration(seconds: 0), () {
      if (noOfChatMessages > 0) {
        noOfChatMessages -= 5;
      }
      if (noOfChatMessages >= 0) {
        fetchMessages();
      }
    });
    update();
  }

  Future<void> fetchMessages() async {
    if (noOfChatMessages >= 5) {
      for (int i = 0; i < 5; i++) {
        // tempMessages.insert(0, chat.messages[noOfChatMessages - i - 1]);
        // tempMessages.add(chat.messages[noOfChatMessages - i - 1]);
      }
    } else {
      for (int i = 0; i < noOfChatMessages; i++) {
        // tempMessages.insert(0, chat.messages[noOfChatMessages - i - 1]);
        // tempMessages.add(chat.messages[noOfChatMessages - i - 1]);
      }
    }
    update();
  }

  @override
  void onClose() {
    submittingMessageTextController.dispose();
    scrollController.dispose();
  }
}
