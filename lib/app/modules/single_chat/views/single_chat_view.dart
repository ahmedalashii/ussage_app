import 'package:ussage_app/constants/exports.dart';
import '../../../../constants/dummy.dart' as dummy;
import '../../../../generated/locales.g.dart';
import '../../../data/models/chat.dart';
import '../../../data/models/message.dart';
import '../controllers/single_chat_controller.dart';
import 'widgets/build_message.dart';
import 'widgets/custom_single_chat_app_bar.dart';

class SingleChatView extends GetView<SingleChatController> {
  const SingleChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Chat chat = (Get.arguments[0] as Chat);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              color: ColorManager.white,
              child: CustomSingleChatAppBar(chat: chat),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: GetX<SingleChatController>(
                    builder: (SingleChatController controller) {
                  return RefreshIndicator(
                    onRefresh: () async => controller.onRefresh(),
                    child: ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.tempMessages.length,
                      reverse: true,
                      itemBuilder: (BuildContext context, int index) {
                        final Message message = controller.tempMessages[index];
                        final bool isMe =
                            message.sender.id == dummy.currentUser.id;
                        return BuildMessage(isMe: isMe, message: message);
                      },
                    ),
                  );
                }),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 25.h, right: 40.w, left: 40.w),
              color: ColorManager.white,
              child: GetBuilder<SingleChatController>(
                  builder: (SingleChatController controller) {
                return PrimaryTextField(
                  onChanged: (String value) {
                    controller.makeSendIconVisible(value);
                  },
                  controller: controller.submittingMessageTextController,
                  hintText: LocaleKeys.type_your_message.tr,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: ColorManager.transparent, width: 0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: ColorManager.transparent, width: 0),
                  ),
                  filled: true,
                  fillColor: ColorManager.grey4,
                  suffixIcon: (!controller.isSendIconVisible)
                      ? Padding(
                          padding: EdgeInsets.only(right: 20.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.add_rounded,
                                  color: ColorManager.primary,
                                  size: 35,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.emoji_emotions_outlined,
                                  color: ColorManager.primary,
                                  size: 30,
                                ),
                              ),
                              SizedBox(width: 15.w),
                              InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.photo_camera,
                                  color: ColorManager.primary,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            if (controller.submittingMessageTextController.text
                                .isNotEmpty && !controller.submittingMessageTextController.text.startsWith(" ")) {
                              Message message = Message(
                                sender: dummy.currentUser,
                                sendingTime: DateTime.now(),
                                text: controller
                                    .submittingMessageTextController.text,
                              );
                              controller.sendMessage(message);
                            }
                          },
                          child: Icon(
                            Icons.send_rounded,
                            color: ColorManager.primary,
                            size: 35,
                          ),
                        ),
                );
              }),
            ),
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   right: 0,
            //   child: Container(
            //     padding: EdgeInsets.symmetric(vertical: 10.h),
            //     color: ColorManager.white,
            //     child: CustomSingleChatAppBar(chat: chat),
            //   ),
            // ),
            // Positioned(
            //   bottom: 0,
            //   left: 0,
            //   right: 0,
            //   child: Container(
            //     padding: EdgeInsets.only(bottom: 25.h, right: 40.w, left: 40.w),
            //     color: ColorManager.white,
            //     child: PrimaryTextField(
            //       controller: controller.submittingMessageTextController,
            //       hintText: LocaleKeys.type_your_message.tr,
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(20),
            //         borderSide:
            //             BorderSide(color: ColorManager.transparent, width: 0),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(20),
            //         borderSide:
            //             BorderSide(color: ColorManager.transparent, width: 0),
            //       ),
            //       filled: true,
            //       fillColor: ColorManager.grey4,
            //       suffixIcon: Padding(
            //         padding: EdgeInsets.only(right: 20.w),
            //         child: Row(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             InkWell(
            //               onTap: () {},
            //               child: Icon(
            //                 Icons.add_rounded,
            //                 color: ColorManager.primary,
            //                 size: 35,
            //               ),
            //             ),
            //             SizedBox(width: 8.w),
            //             InkWell(
            //               onTap: () {},
            //               child: Icon(
            //                 Icons.emoji_emotions_outlined,
            //                 color: ColorManager.primary,
            //                 size: 30,
            //               ),
            //             ),
            //             SizedBox(width: 15.w),
            //             InkWell(
            //               onTap: () {},
            //               child: Icon(
            //                 Icons.photo_camera,
            //                 color: ColorManager.primary,
            //                 size: 30,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
