import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
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
import 'package:url_launcher/url_launcher.dart';

import 'app_services/app_http_override.dart';
import 'firebase_options.dart';

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

    // Khởi tạo Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Cấu hình System UI Overlay
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    // Thiết lập hướng màn hình và các dịch vụ khác
    await setPreferredOrientations();
    await setupLocator();

    // Cấu hình Firebase Remote Config
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 60), // Thời gian chờ tối đa
      minimumFetchInterval: const Duration(hours: 1), // Giới hạn tần suất fetch
    ));
    await remoteConfig.setDefaults({
      'min_supported_version': '1.0.0', // Phiên bản tối thiểu hỗ trợ
      'android_store_url': 'https://play.google.com/store/apps/details?id=com.techber.qlcv', // URL Google Play
      'ios_store_url': 'https://apps.apple.com/app/id6692621410', // URL App Store
    });
    try {
      // Fetch và activate Remote Config
      await remoteConfig.fetchAndActivate();

      // Kiểm tra và hiển thị thông báo cập nhật nếu cần
      if (await _isVersionOutdated(remoteConfig)) {
        await _showUpdateDialog(remoteConfig);
      }
    } catch (e) {
      debugPrint('Firebase Remote Config error: $e');
    }

    // Kiểm tra và hiển thị thông báo cập nhật nếu cần
    if (await _isVersionOutdated(remoteConfig)) {
      await _showUpdateDialog(remoteConfig);
    }

    // Khởi động ứng dụng
    HttpOverrides.global = AppHttpOverrides();
    await AppImpl.create();
  }, (error, stack) {
    debugPrint('Error: $error\nStackTrace: $stack');
  });
}

Future<bool> _isVersionOutdated(FirebaseRemoteConfig remoteConfig) async {
  final currentVersion = '1.0.0'; // Phiên bản hiện tại của app (có thể dùng PackageInfo để lấy tự động)
  final minSupportedVersion = remoteConfig.getString('min_supported_version');
  return _compareVersion(currentVersion, minSupportedVersion) < 0;
}

Future<void> _showUpdateDialog(FirebaseRemoteConfig remoteConfig) async {
  final storeUrl = Platform.isAndroid
      ? remoteConfig.getString('android_store_url')
      : remoteConfig.getString('ios_store_url');

  await Get.dialog(
    AlertDialog(
      title: const Text('Cập nhật ứng dụng'),
      content: const Text('Phiên bản hiện tại đã cũ. Vui lòng cập nhật để sử dụng các tính năng mới nhất.'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Đóng dialog
            SystemNavigator.pop(); // Thoát app
          },
          child: const Text('Thoát'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            launchUrl(Uri.parse(storeUrl));
          },
          child: const Text('Cập nhật ngay'),
        ),
      ],
    ),
    barrierDismissible: false, // Không cho phép đóng bằng cách bấm ra ngoài
  );
}

// Hàm so sánh phiên bản
int _compareVersion(String current, String minimum) {
  final currentParts = current.split('.').map(int.parse).toList();
  final minimumParts = minimum.split('.').map(int.parse).toList();

  for (var i = 0; i < minimumParts.length; i++) {
    final currentPart = (i < currentParts.length) ? currentParts[i] : 0;
    final minimumPart = minimumParts[i];
    if (currentPart < minimumPart) return -1;
    if (currentPart > minimumPart) return 1;
  }
  return 0;
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
