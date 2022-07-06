import 'package:ussage_app/app/modules/home/controllers/home_controller.dart';

import '../../../../../constants/exports.dart';

class CustomHomeAppBar extends GetView<HomeController> {
  const CustomHomeAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row( 
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PrimaryText(
          "Ussage".toUpperCase(),
          color: ColorManager.primary,
          fontSize: 30,
          letterSpacing: 1.5,
          fontWeight: FontWeightManager.medium,
        ),
        Row(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {},
              child: SizedBox(
                width: 45.w,
                height: 50.h,
                child: Icon(
                  Icons.add_rounded,
                  size: 35,
                  color: ColorManager.primary,
                ),
              ),
            ),
            SizedBox(width: 5.w),
            InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {},
              child: SizedBox(
                width: 45.w,
                height: 50.h,
                child: Icon(
                  Icons.search_rounded,
                  size: 35,
                  color: ColorManager.primary,
                ),
              ),
            ),
            SizedBox(width: 5.w),
            GetBuilder<HomeController>(
              builder: (HomeController controller) {
                return AnimatedRotation(
                  curve: Curves.easeOutExpo,
                  turns: controller.turns,
                  duration: const Duration(seconds: 1),
                  child: InkWell(
                    onTap: () {
                      controller.changeTurns();
                      if (!controller.scaffoldKey.currentState!.isDrawerOpen) {
                        controller.openDrawer();
                      }
                    },
                    borderRadius: BorderRadius.circular(25),
                    child: SizedBox(
                      width: 45.w,
                      height: 22.h,
                      child: SvgPicture.asset(
                        ImagesManager.menuIcon,
                        color: ColorManager.primary,
                      ),
                      // child: Icon(
                      //   Icons.menu_rounded,
                      //   size: 35,
                      //   color: ColorManager.primary,
                      // ),
                    ),
                  ),
                );
              }
            ),
          ],
        ),
      ],
    );
  }
}
