
import 'package:ussage_app/app/core/helper_functions.dart';
import 'package:ussage_app/app/modules/home/controllers/home_controller.dart';
import '../../../../../constants/dummy.dart' as dummy;
import '../../../../../constants/exports.dart';
import '../../../../data/models/chat.dart';
import '../../../../routes/app_pages.dart';

class SingleChat extends GetView<HomeController> {
  const SingleChat({
    Key? key,
    required this.chat,
    required this.index,
  }) : super(key: key);

  final Chat chat;
  final int index;

  @override
  Widget build(BuildContext context) {
    AnimationController animationController =
        AnimationController(vsync: controller);
    Widget backgroundChild = Container(
      decoration: BoxDecoration(
        color: ColorManager.primary,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: GetBuilder<HomeController>(builder: (HomeController controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                (!controller.chats[index].isSaved)
                    ? Icons.bookmark_border_rounded
                    : Icons.bookmark_rounded,
                color: ColorManager.white,
                size: 25,
              ),
              onPressed: () {
                controller.saveChat(index);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.done_all_rounded,
                color: ColorManager.white,
                size: 25,
              ),
              onPressed: () {
                controller.makeChatRead(index);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: ColorManager.white,
                size: 25,
              ),
              onPressed: () {
                controller.deleteChat(index);
              },
            ),
          ],
        );
      }),
    );
    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails details) {
        controller.onDragStart(details, animationController, index);
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        controller.onDragUpdate(details, animationController);
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        controller.onDragEnd(details, animationController, index);
      },
      onTap: () => Get.offNamed(Routes.SINGLE_CHAT, arguments: [chat, index]),
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return GetBuilder<HomeController>(
                  builder: (HomeController controller) {
                return SlideTransition(
                  position: AlwaysStoppedAnimation(
                    Offset(-animationController.value, 0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 82.w,
                              height: 92.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage(chat.user.imageUrl),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Visibility(
                              visible: chat.user.connectionStatus,
                              child: Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  width: 23.w,
                                  height: 23.h,
                                  decoration: BoxDecoration(
                                    color: ColorManager.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: ColorManager.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  PrimaryText(
                                    chat.user.name,
                                    color: ColorManager.black,
                                    fontSize: 22,
                                  ),
                                  SizedBox(width: 5.w),
                                  Image.asset(
                                    ImagesManager.notificationIcon,
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                                  // Icon(
                                  //   Icons.notifications_rounded,
                                  //   size: 24,
                                  //   color: ColorManager.primary,
                                  // ),
                                  const Spacer(),
                                  PrimaryText(
                                    formatTimeOfDay(chat
                                        .messages[chat.messages.length - 1]
                                        .sendingTime),
                                    color: ColorManager.grey3,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.5,
                                    child: PrimaryText(
                                      (chat.messages.last.sender.id ==
                                              dummy.currentUser.id)
                                          ? ("Me: ${chat.messages.last.text}")
                                          : chat.messages.last.text,
                                      color: (!chat.isRead)
                                          ? ColorManager.primary
                                          : ColorManager.grey5,
                                      fontSize: 20,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Visibility(
                                    visible: !chat.isRead,
                                    child: Row(
                                      children: [
                                        SizedBox(width: 5.w),
                                        Container(
                                          width: 26.w,
                                          height: 26.h,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ColorManager.primary,
                                          ),
                                          child: Center(
                                            child: PrimaryText(
                                              "1",
                                              color: ColorManager.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
          Positioned(
            right: 0,
            child: GetBuilder<HomeController>(
                builder: (HomeController controller) {
              return SizedBox(
                width: controller.chats[index].size.width,
                height: controller.chats[index].size.height,
                child: backgroundChild,
              );
            }),
          ),
        ],
      ),
    );
  }
}
