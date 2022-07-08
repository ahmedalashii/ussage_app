import 'package:ussage_app/app/core/helper_functions.dart';
import 'package:ussage_app/app/data/cache_helper.dart';
import 'package:ussage_app/app/modules/home/controllers/home_controller.dart';
import '../../../../../constants/exports.dart';
import '../../../../data/models/user.dart';
import '../../../../routes/app_pages.dart';

class SingleUser extends GetView<HomeController> {
  const SingleUser({
    Key? key,
    required this.user,
    required this.index,
  }) : super(key: key);

  final User user;
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
                (!user.isSaved)
                    ? Icons.bookmark_border_rounded
                    : Icons.bookmark_rounded,
                color: ColorManager.white,
                size: 25,
              ),
              onPressed: () async {
                await controller.makeUserSaved(user);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.done_all_rounded,
                color: ColorManager.white,
                size: 25,
              ),
              onPressed: () async {
                if (user.lastMessages
                    .containsKey(CacheController.instance.getUserId())) {
                  if (user.lastMessages[CacheController.instance.getUserId()]!
                          .senderIdUser !=
                      CacheController.instance.getUserId()) {
                    await controller.makeUserRead(user);
                  }
                }
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: ColorManager.white,
                size: 25,
              ),
              onPressed: () async {
                await controller.deleteUser(user);
              },
            ),
          ],
        );
      }),
    );
    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails details) {
        controller.onDragStart(details, animationController, user);
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        controller.onDragUpdate(details, animationController);
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        controller.onDragEnd(details, animationController, user);
      },
      onTap: () => Get.offNamed(Routes.SINGLE_CHAT, arguments: [user, index]),
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
                                    image: NetworkImage(user.imageUrl),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Visibility(
                              visible: user.connectionStatus,
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
                                    user.name,
                                    color: ColorManager.black,
                                    fontSize: 22,
                                  ),
                                  SizedBox(width: 5.w),
                                  Image.asset(
                                    ImagesManager.notificationIcon,
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                                  const Spacer(),
                                  if (CacheController.instance
                                      .getCachedLoggedInUser()!
                                      .lastMessages
                                      .containsKey(user.idUser))
                                    PrimaryText(
                                      formatTimeOfDay(CacheController.instance
                                          .getCachedLoggedInUser()!
                                          .lastMessages[user.idUser]!
                                          .createdAt),
                                      color: ColorManager.grey3,
                                    ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                children: [
                                  if (user.lastMessages.containsKey(
                                      CacheController.instance.getUserId()))
                                    Visibility(
                                      visible: user
                                          .lastMessages[CacheController.instance
                                              .getUserId()]!
                                          .text
                                          .isNotEmpty,
                                      child: SizedBox(
                                        width: Get.width * 0.5,
                                        child: PrimaryText(
                                          (user
                                                      .lastMessages[
                                                          CacheController
                                                              .instance
                                                              .getUserId()]!
                                                      .senderIdUser ==
                                                  CacheController.instance
                                                      .getUserId())
                                              ? ("Me: ${user.lastMessages[CacheController.instance.getUserId()]!.text}")
                                              : user
                                                  .lastMessages[CacheController
                                                      .instance
                                                      .getUserId()]!
                                                  .text,
                                          color: (user
                                                      .lastMessages[
                                                          CacheController
                                                              .instance
                                                              .getUserId()]!
                                                      .senderIdUser !=
                                                  CacheController.instance
                                                      .getUserId())
                                              ? (!user
                                                      .lastMessages[
                                                          CacheController
                                                              .instance
                                                              .getUserId()]!
                                                      .isRead)
                                                  ? ColorManager.primary
                                                  : ColorManager.grey5
                                              : ColorManager.grey5,
                                          fontSize: 20,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  const Spacer(),
                                  if (user.lastMessages.containsKey(
                                      CacheController.instance.getUserId()))
                                    Visibility(
                                      visible: user
                                                  .lastMessages[CacheController
                                                      .instance
                                                      .getUserId()]!
                                                  .senderIdUser !=
                                              CacheController.instance
                                                  .getUserId() &&
                                          !user
                                              .lastMessages[CacheController
                                                  .instance
                                                  .getUserId()]!
                                              .isRead,
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
                width: user.size.width,
                height: user.size.height,
                child: backgroundChild,
              );
            }),
          ),
        ],
      ),
    );
  }
}
