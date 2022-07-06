import 'package:ussage_app/generated/locales.g.dart';

import '../../../../constants/dummy.dart' as dummy;
import '../../../../constants/exports.dart';
import '../../../data/models/chat.dart';
import '../../../data/models/message.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  int selectedIndex = 0;
  double dragExtent = 0; // saving how much we've dragged to the left side ..
  double turns = 0.0;
  late AnimationController menuAnimationController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isMenuButtonClicked = false, isSaved = false;
  final double actionThreshold = 0.6;
  int noOfUsers = 1, noOfChats = 0;

  RxList<Chat> chats = <Chat>[].obs;

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
      AnimationController animationController, int index) {
    if (animationController.value >= 0) {
      chats[index].size = const Size(0, 0);
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
      AnimationController animationController, int index) {
    if (animationController.value > actionThreshold) {
      _onSlided(index);
      animationController.value = 0.62;
    } else {
      animationController.fling(velocity: -1);
    }
  }

  void _onSlided(int index) {
    chats[index].size = const Size(360 * 0.6, 92);
    update();
  }

  void saveChat(int index) {
    isSaved = !isSaved;
    chats[index].isSaved = isSaved;
    update();
  }

  void makeChatRead(int index) {
    chats[index].isRead = true;
    update();
  }

  void deleteChat(int index) {
    chats.removeAt(index);
    Get.showSnackbar(const GetSnackBar(
      message: "Chat has been deleted Succesfully!",
      duration: Duration(seconds: 2),
    ));
    update();
  }

  @override
  void onInit() {
    chats.value = [
      Chat(
        user: dummy.theresa,
        id: (noOfChats++).toString(),
        isRead: false,
        messages: <Message>[
          Message(
            sender: dummy.theresa,
            sendingTime: DateTime.now(),
            text: "Why did you do that?",
          ),
          Message(
            sender: dummy.currentUser,
            sendingTime: DateTime.now(),
            text: "I couldn't hold myself",
          ),
          Message(
            sender: dummy.currentUser,
            sendingTime: DateTime.now(),
            text: "I'm sorry ..",
          ),
          Message(
            sender: dummy.theresa,
            sendingTime: DateTime.now(),
            text: "Nevermind",
          ),
        ],
        noOfUnreadMessages: 1,
        size: const Size(0, 0),
      ),
      Chat(
        user: dummy.calvin,
        id: (noOfChats++).toString(),
        isRead: false,
        messages: <Message>[
          Message(
            id: "1",
            sender: dummy.calvin,
            sendingTime: DateTime.now(),
            text: "Hi, bro! Come to my house!",
          ),
        ],
        noOfUnreadMessages: 2,
        size: const Size(0, 0),
      ),
      Chat(
        user: dummy.gregory,
        id: (noOfChats++).toString(),
        messages: <Message>[
          Message(
            sender: dummy.gregory,
            sendingTime: DateTime.now(),
            text: "Will you stop ignoring me?",
          ),
          Message(
            sender: dummy.currentUser,
            sendingTime: DateTime.now(),
            text: "I'm not ignoring you ..",
          ),
          Message(
            sender: dummy.currentUser,
            sendingTime: DateTime.now(),
            text: "I'm not ignoring you ..",
          ),
          Message(
            sender: dummy.currentUser,
            sendingTime: DateTime.now(),
            text: "I'm not ignoring you ..",
          ),
          Message(
            sender: dummy.currentUser,
            sendingTime: DateTime.now(),
            text: "I'm not ignoring you ..",
          ),
          Message(
            sender: dummy.currentUser,
            sendingTime: DateTime.now(),
            text: "I'm not ignoring you ..",
          ),
          Message(
            sender: dummy.currentUser,
            sendingTime: DateTime.now(),
            text: "I'm not ignoring you ..",
          ),
          Message(
            sender: dummy.currentUser,
            sendingTime: DateTime.now(),
            text: "I'm not ignoring you ..",
          ),
          Message(
            sender: dummy.currentUser,
            sendingTime: DateTime.now(),
            text:
                "هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها. ولذلك يتم استخدام طريقة لوريم إيبسوم لأنها تعطي توزيعاَ طبيعياَ -إلى حد ما- للأحرف عوضاً عن استخدام فتجعلها تبدو (أي الأحرف) وكأنها نص مقروء. العديد من برامح النشر المكتبي وبرامح تحرير صفحات الويب تستخدم لوريم إيبسوم بشكل إفتراضي كنموذج عن النص، وإذا قمت بإدخال  في أي محرك بحث ستظهر العديد من المواقع الحديثة العهد في نتائج البحث. على مدى السنين ظهرت نسخ جديدة ومختلفة من نص لوريم إيبسوم، أحياناً عن طريق الصدفة، وأحياناً عن عمد كإدخال بعض العبارات الفكاهية إليها.",
          ),
          Message(
            sender: dummy.gregory,
            sendingTime: DateTime.now(),
            text:
                "هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها. ولذلك يتم استخدام طريقة لوريم إيبسوم لأنها تعطي توزيعاَ طبيعياَ -إلى حد ما- للأحرف عوضاً عن استخدام فتجعلها تبدو (أي الأحرف) وكأنها نص مقروء. العديد من برامح النشر المكتبي وبرامح تحرير صفحات الويب تستخدم لوريم إيبسوم بشكل إفتراضي كنموذج عن النص، وإذا قمت بإدخال  في أي محرك بحث ستظهر العديد من المواقع الحديثة العهد في نتائج البحث. على مدى السنين ظهرت نسخ جديدة ومختلفة من نص لوريم إيبسوم، أحياناً عن طريق الصدفة، وأحياناً عن عمد كإدخال بعض العبارات الفكاهية إليها هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها. ولذلك يتم استخدام طريقة لوريم إيبسوم لأنها تعطي توزيعاَ طبيعياَ -إلى حد ما- للأحرف عوضاً عن استخدام فتجعلها تبدو (أي الأحرف) وكأنها نص مقروء. العديد من برامح النشر المكتبي وبرامح تحرير صفحات الويب تستخدم لوريم إيبسوم بشكل إفتراضي كنموذج عن النص، وإذا قمت بإدخال  في أي محرك بحث ستظهر العديد من المواقع الحديثة العهد في نتائج البحث. على مدى السنين ظهرت نسخ جديدة ومختلفة من نص لوريم إيبسوم، أحياناً عن طريق الصدفة، وأحياناً عن عمد كإدخال بعض العبارات الفكاهية إليها",
          ),
        ],
        noOfUnreadMessages: 0,
        size: const Size(0, 0),
      ),
      Chat(
        user: dummy.soham,
        id: (noOfChats++).toString(),
        isRead: false,
        messages: <Message>[
          Message(
            sender: dummy.soham,
            sendingTime: DateTime.now(),
            text: "Bro, just fuck off",
          ),
        ],
        noOfUnreadMessages: 2,
        size: const Size(0, 0),
      ),
      Chat(
        user: dummy.mother,
        id: (noOfChats++).toString(),
        isRead: false,
        messages: <Message>[
          Message(
            sender: dummy.mother,
            sendingTime: DateTime.now(),
            text: "Yes, of course come, ... ",
          ),
        ],
        noOfUnreadMessages: 2,
        size: const Size(0, 0),
      ),
      Chat(
        user: dummy.brother,
        id: (noOfChats++).toString(),
        isRead: false,
        messages: <Message>[
          Message(
            sender: dummy.brother,
            sendingTime: DateTime.now(),
            text: "Ok, Good Buy .. ",
          ),
        ],
        noOfUnreadMessages: 2,
        size: const Size(0, 0),
      ),
    ];
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
