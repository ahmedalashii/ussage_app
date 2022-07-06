import 'package:firebase_core/firebase_core.dart';
import 'package:ussage_app/generated/locales.g.dart';

import 'app/data/cache_helper.dart';
import 'app/routes/app_pages.dart';
import 'constants/exports.dart';
import 'global_presentation/global_features/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheController.instance.initSharedPreferences();
  runApp(
    ScreenUtilInit(
      designSize: const Size(415, 896),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Ussage App",
          initialRoute: (CacheController.instance.getUserEmail() == "")
              ? AppPages.INITIAL
              : Routes.HOME,
          theme: getApplicationTheme(),
          getPages: AppPages.routes,
          translationsKeys: AppTranslation.translations,
          locale: const Locale("en"),
        );
      },
    ),
  );
}
