import 'package:ussage_app/app/data/cache_helper.dart';
import 'package:ussage_app/app/firebase_helpers/firebase_auth_helper.dart';
import 'package:ussage_app/app/modules/home/controllers/home_controller.dart';
import 'package:ussage_app/app/routes/app_pages.dart';

import '../../../../../constants/exports.dart';
import '../../../../../generated/locales.g.dart';

class HomeMenuDrawer extends GetView<HomeController> {
  const HomeMenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorManager.primary,
                        size: 25,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings_outlined,
                        color: ColorManager.primary,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Container(
                      width: 82.w,
                      height: 92.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 5),
                            color: ColorManager.grey.withOpacity(0.4),
                            blurRadius: 10,
                            spreadRadius: 5,
                          ),
                        ],
                        image: DecorationImage(
                            image:
                                NetworkImage(CacheController.instance.getCachedLoggedInUser()!.imageUrl),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    PrimaryText(
                      "${CacheController.instance.getCachedLoggedInUser()!.name.split(" ")[0]}\n${CacheController.instance.getCachedLoggedInUser()!.name.split(" ")[1]}",
                      color: ColorManager.primary,
                      fontSize: 25,
                    ),
                  ],
                ),
                SizedBox(height: 50.h),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_outlined,
                        color: ColorManager.primary,
                        size: 30,
                      ),
                      SizedBox(width: 20.w),
                      PrimaryText(
                        LocaleKeys.contacts.tr,
                        color: ColorManager.primary,
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.call_end_outlined,
                        color: ColorManager.primary,
                        size: 30,
                      ),
                      SizedBox(width: 20.w),
                      PrimaryText(
                        LocaleKeys.calls.tr,
                        color: ColorManager.primary,
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.bookmark_border_rounded,
                        color: ColorManager.primary,
                        size: 30,
                      ),
                      SizedBox(width: 20.w),
                      PrimaryText(
                        LocaleKeys.saved_messages.tr,
                        color: ColorManager.primary,
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_add_outlined,
                        color: ColorManager.primary,
                        size: 30,
                      ),
                      SizedBox(width: 20.w),
                      PrimaryText(
                        LocaleKeys.invite_friends.tr,
                        color: ColorManager.primary,
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.question_mark_rounded,
                        color: ColorManager.primary,
                        size: 30,
                      ),
                      SizedBox(width: 20.w),
                      PrimaryText(
                        LocaleKeys.ussage_faq.tr,
                        color: ColorManager.primary,
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () async {
                    await FirebaseAuthHelper().signOut();
                    Get.offNamed(Routes.LOGIN);
                    CacheController.instance.setAuthed(false);
                    CacheController.instance.removeCachedLoggedInUser();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        color: ColorManager.primary,
                        size: 30,
                      ),
                      SizedBox(width: 20.w),
                      PrimaryText(
                        LocaleKeys.logout.tr,
                        color: ColorManager.primary,
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
