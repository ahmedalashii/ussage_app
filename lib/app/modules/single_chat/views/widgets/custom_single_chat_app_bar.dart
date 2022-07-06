import 'package:ussage_app/app/modules/single_chat/controllers/single_chat_controller.dart';
import 'package:ussage_app/generated/locales.g.dart';

import '../../../../../constants/exports.dart';
import '../../../../data/models/chat.dart';
import '../../../../routes/app_pages.dart';

class CustomSingleChatAppBar extends GetView<SingleChatController> {
  const CustomSingleChatAppBar({
    Key? key,
    required this.chat,
  }) : super(key: key);

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Get.offNamed(Routes.HOME);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: ColorManager.primary,
            size: 25,
          ),
        ),
        SizedBox(width: 15.w),
        Row(
          children: [
            Container(
              width: 72.w,
              height: 72.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: AssetImage(
                      chat.user.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                  chat.user.name,
                  color: ColorManager.black,
                  fontSize: 20,
                ),
                PrimaryText(
                  (chat.user.connectionStatus) ? LocaleKeys.online.tr : LocaleKeys.not_online.tr,
                  color: ColorManager.primary,
                  fontSize: 18,
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        Container(
          margin: EdgeInsets.only(right: 20.w),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu_rounded,
              color: ColorManager.primary,
              size: 35,
            ),
          ),
        ),
      ],
    );
  }
}
