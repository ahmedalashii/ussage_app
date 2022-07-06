import 'package:ussage_app/constants/exports.dart';

import '../controllers/home_controller.dart';
import 'widgets/custom_home__app_bar.dart';
import 'widgets/home_menu_drawer.dart';
import 'widgets/single_chat_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      onEndDrawerChanged: (bool isEndDrawerOpened) {
        if (isEndDrawerOpened == false) {
          controller.changeTurns();
        }
      },
      key: controller.scaffoldKey,
      endDrawer: const HomeMenuDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Column(
            children: [
              const CustomHomeAppBar(),
              SizedBox(height: 20.h),
              SizedBox(
                height: 50.h,
                child: ListView.builder(
                  itemCount: controller.categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GetBuilder<HomeController>(
                        builder: (HomeController controller) {
                      return GestureDetector(
                        onTap: () {
                          controller.selectCategory(index);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 0),
                          child: Container(
                            width: 133.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: (controller.selectedIndex == index)
                                  ? ColorManager.primary
                                  : ColorManager.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: PrimaryText(
                                controller.categories[index],
                                color: (controller.selectedIndex == index)
                                    ? ColorManager.white
                                    : ColorManager.black.withOpacity(0.8),
                                fontSize: 22,
                                fontWeight: FontWeightManager.regular,
                              ),
                            ),
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
              SizedBox(height: 44.h),
              Expanded(
                child: GetX<HomeController>(
                  builder: (HomeController controller) {
                    return ListView.builder(
                      itemCount: controller.chats.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SingleChat(
                            chat: controller.chats[index], index: index);
                      },
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
