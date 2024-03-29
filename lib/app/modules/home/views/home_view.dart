import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ussage_app/app/data/cache_helper.dart';
import 'package:ussage_app/app/firebase_helpers/firebase_firestore_helper.dart';
import 'package:ussage_app/constants/exports.dart';

import '../../../data/models/user.dart';
import '../controllers/home_controller.dart';
import 'widgets/custom_home__app_bar.dart';
import 'widgets/home_menu_drawer.dart';
import 'widgets/single_user_widget.dart';

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
                child: StreamBuilder<QuerySnapshot>(
                  stream: FireStoreHelper().readAllUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData &&
                        snapshot.data!.docs.isNotEmpty) {
                      List<QueryDocumentSnapshot<Object?>> users =
                          snapshot.data!.docs;
                      users.removeWhere(
                          // we don't want the current user to be shown in the users list view (since it's not self-communication :)) ..
                          (QueryDocumentSnapshot userDocumentSnapshot) =>
                              userDocumentSnapshot.get("idUser") ==
                              CacheController.instance.getUserId());
                      return ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (BuildContext context, int index) {
                            User user = User(
                                email: users[index].get("email"),
                                idUser: users[index].get("idUser"),
                                imageUrl: users[index].get("imageUrl"),
                                lastMessages: User.lastMessagesfromJSON(
                                    users[index].get("lastMessages")),
                                name: users[index].get("name"),
                                connectionStatus:
                                    users[index].get("connectionStatus"),
                                isSaved: users[index].get("isSaved"));
                            return SingleUser(user: user, index: index);
                          });
                    } else {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.warning, size: 80),
                            PrimaryText(
                              "No Users You've talked to yet,\nStart a conversation with others!",
                              fontSize: 20,
                              color: ColorManager.grey,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
