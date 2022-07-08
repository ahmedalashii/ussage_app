import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ussage_app/app/core/helper_functions.dart';
import 'package:ussage_app/app/data/cache_helper.dart';
import 'package:ussage_app/constants/exports.dart';
import '../../../../generated/locales.g.dart';
import '../../../data/models/message.dart';
import '../../../data/models/user.dart';
import '../../../firebase_helpers/firebase_firestore_helper.dart';
import '../controllers/single_chat_controller.dart';
import 'widgets/build_message.dart';
import 'widgets/custom_single_chat_app_bar.dart';

class SingleChatView extends GetView<SingleChatController> {
  const SingleChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    User user = (Get.arguments[0] as User);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              color: ColorManager.white,
              child: CustomSingleChatAppBar(user: user),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: RefreshIndicator(
                  onRefresh: () async => controller.onRefresh(),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FireStoreHelper().readMessages(
                          receiverIdUser: user.idUser,
                          senderIdUser: CacheController.instance.getUserId()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasData &&
                            snapshot.data!.docs.isNotEmpty) {
                          List<QueryDocumentSnapshot<Object?>> usersMessages =
                              snapshot.data!.docs;
                          return ListView.builder(
                            controller: controller.scrollController,
                            itemCount: usersMessages.length,
                            reverse: true,
                            itemBuilder: (BuildContext context, int index) {
                              final Message message = Message(
                                createdAt: (usersMessages[index]
                                            .get("createdAt")
                                            .runtimeType ==
                                        String)
                                    ? DateTime.parse(usersMessages[index]
                                        .get("createdAt") as String)
                                    : toDateTime(
                                        usersMessages[index].get("createdAt"))!,
                                senderIdUser:
                                    usersMessages[index].get("senderIdUser"),
                                receiverIdUser:
                                    usersMessages[index].get("receiverIdUser"),
                                text: usersMessages[index].get("text"),
                              );
                              final bool isMe = message.senderIdUser ==
                                  CacheController.instance.getUserId();
                              log(message.createdAt.toString());
                              return BuildMessage(isMe: isMe, message: message);
                            },
                          );
                        } else {
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.warning, size: 80),
                                PrimaryText(
                                  "No Messages Yet,\nStart the conversation!",
                                  fontSize: 20,
                                  color: ColorManager.grey,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        }
                      }),
                ),
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
                                    .isNotEmpty &&
                                !controller.submittingMessageTextController.text
                                    .startsWith(" ")) {
                              controller.sendMessage(
                                  msg: controller
                                      .submittingMessageTextController.text,
                                  idUser: user.idUser);
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
          ],
        ),
      ),
    );
  }
}