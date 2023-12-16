import 'package:boasting_board/app/modules/home/views/home_view.dart';
import 'package:boasting_board/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app/common/app_styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 767),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Bored Board',
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          theme: appStyle,
          locale: const Locale('ko', 'KR'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // initialBinding: BindingsBuilder(() {
          //   Get.put(ApiRepository());
          //   Get.lazyPut<UserService>(() => UserService());
          //   Get.lazyPut<FirebaseService>(() => FirebaseService());
          //   Get.lazyPut<FCMService>(() => FCMService());
          //   Get.lazyPut<LocationService>(() => LocationService());
          //   Get.put(LifeCycleService());
          //   Get.put(TermsService());
          //   Get.put(HomePopupService());
          // }),
          supportedLocales: const [
            Locale('ko', 'KR'),
            Locale('en', 'US'),
          ],
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: child!,
            );
          },
        );
      },
    );
  }
}
