import 'package:ussage_app/constants/exports.dart';

AppBar globalAppBar({Widget? title, List<Widget>? actions, Widget? leading}) {
  return AppBar(
    backgroundColor: ColorManager.white,
    centerTitle: true,
    elevation: 0,
    toolbarHeight: 90.h,
    title: title ?? const SizedBox(),
    leading: leading ??
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: ColorManager.primary,
            size: 25,
          ),
        ),
    actions: actions ?? [],
  );
}
