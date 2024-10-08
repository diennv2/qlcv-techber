import 'dart:async';

import 'package:mobile_rhm/data/local/database_keys.dart';
import 'package:mobile_rhm/data/prefs/app_preference_helper.dart';
import 'package:mobile_rhm/data/prefs/preference_helper.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalModule {
  /// A singleton preference provider.

  static Future<SharedPreferences> provideSharedPreferences() {
    return SharedPreferences.getInstance();
  }

  static PreferenceHelper providePreferenceHelper(SharedPreferences sharedPreferences) {
    return AppPreferenceHelper(sharedPreferences);
  }

  static Future<AppHiveBox> provideBox() async {
    await Hive.initFlutter();
    // Register Hive here
    Box userProfile = await Hive.openBox(DatabaseKeys.USER_PROFILE);
    Box metaData = await Hive.openBox(DatabaseKeys.META_DATA);
    return AppHiveBox(userProfile: userProfile, metaData: metaData);
  }
}

class AppHiveBox {
  final Box userProfile;
  final Box metaData;

  AppHiveBox({required this.userProfile, required this.metaData});
}
