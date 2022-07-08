import '../../../../../constants/exports.dart';
import '../../../../core/helper_functions.dart';
import '../../../../data/models/message.dart';
import '../../controllers/single_chat_controller.dart';

class BuildMessage extends GetView<SingleChatController> {
  const BuildMessage({
    Key? key,
    required this.isMe,
    required this.message,
  }) : super(key: key);

  final bool isMe;
  final Message message;

  @override
  Widget build(BuildContext context) {
    AnimationController animationController =
        AnimationController(vsync: controller);
    Widget backgroundChild = Center(
      child: PrimaryText(
        formatTimeOfDay(message.createdAt),
        color: ColorManager.primary,
        fontSize: 20,
      ),
    );
    return Wrap(
      direction: Axis.horizontal,
      alignment: (Get.locale!.languageCode != "ar")
          ? (isMe)
              ? WrapAlignment.end
              : WrapAlignment.start
          : (isMe)
              ? WrapAlignment.start
              : WrapAlignment.end,
      children: [
        GestureDetector(
          onHorizontalDragStart: (DragStartDetails details) {
            controller.onDragStart(animationController, message);
          },
          onHorizontalDragUpdate: (DragUpdateDetails details) {
            controller.onDragUpdate(details, animationController, message);
          },
          onHorizontalDragEnd: (DragEndDetails details) {
            controller.onDragEnd(animationController, message);
          },
          child: Stack(
            children: [
              Positioned(
                right: (isMe) ? -100.w : null,
                left: (isMe) ? null : -100.w,
                top: 0,
                bottom: 0,
                child: GetBuilder<SingleChatController>(
                  builder: (SingleChatController controller) {
                    return SizedBox(
                      width: message.size.width,
                      height: message.size.height,
                      child: backgroundChild,
                    );
                  },
                ),
              ),
              AnimatedBuilder(
                animation: animationController,
                builder: (BuildContext context, Widget? child) {
                  return GetBuilder<SingleChatController>(
                    builder: (SingleChatController controller) {
                      return SlideTransition(
                        position: AlwaysStoppedAnimation(
                          Offset(
                              (isMe)
                                  ? -animationController.value
                                  : animationController.value,
                              0),
                        ),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: Get.width * 0.75),
                          margin: (isMe)
                              ? const EdgeInsets.only(
                                  top: 8, bottom: 8, left: 80)
                              : const EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          decoration: BoxDecoration(
                            color: (isMe)
                                ? ColorManager.grey2
                                : ColorManager.primary,
                            borderRadius: (isMe)
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(20),
                                  )
                                : const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(5),
                                  ),
                          ),
                          child: PrimaryText(
                            message.text,
                            color: (isMe)
                                ? ColorManager.black
                                : ColorManager.white,
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 100,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
