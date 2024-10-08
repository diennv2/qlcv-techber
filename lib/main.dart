import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_services/localization_service.dart';
import 'package:mobile_rhm/bindings/app_binding.dart';
import 'package:mobile_rhm/core/constants/locale.dart';
import 'package:mobile_rhm/core/theme/app_theme.dart';
import 'package:mobile_rhm/core/utils/toast_utils.dart';
import 'package:mobile_rhm/di/components/service_locator.dart';
import 'package:mobile_rhm/routers/app_pages.dart';

import 'app_services/app_http_override.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

Future<void> main() async {
  Get.lazyPut(() => ToastService());
  return runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark));
    await setPreferredOrientations();
    await setupLocator();
    //Start app
    HttpOverrides.global = AppHttpOverrides();
    await AppImpl.create();
  }, (error, stack) {});
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var screenStandH = 812.0;
    var screenStandW = 375.0;

    return ScreenUtilInit(
      designSize: Size(screenStandW, screenStandH), //Base on IphoneX screen resolution 375x812
      splitScreenMode: true,
      builder: (context, widget) => GetMaterialApp(
        builder: (context, widget) {
          final TransitionBuilder fToastBuilder = FToastBuilder();
          var customWidget = fToastBuilder(context, widget);
          return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: customWidget,
          );
        },
        title: 'Quản Lý Công Việc',
        supportedLocales: SupportLocale.locales,
        getPages: AppPages.pages,
        initialRoute: Routers.SPLASH_SCREEN,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        locale: LocalizationService.locale,
        translations: LocalizationService(),
        initialBinding: AppBinding(),
        defaultTransition: Platform.isIOS ? Transition.cupertino : Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 550),
        debugShowCheckedModeBanner: false,
        theme: themeData,
        navigatorKey: navigatorKey,
      ),
    );
  }
}

class AppImpl {
  AppImpl._create() {
    runApp(
      const MyApp(),
    );
  }

  static Future<AppImpl> create() async {
    var app = AppImpl._create();
    return app;
  }
}
