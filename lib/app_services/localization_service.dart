import 'dart:collection';
import 'dart:ui';

import 'package:mobile_rhm/core/languages/en.dart';
import 'package:mobile_rhm/core/languages/vi.dart';
import 'package:get/get.dart';

class LocalizationService extends Translations {
  static final locale = _getLocaleFromLanguage();

  // language code support
  static final langCodes = [
    'en',
    'vi',
  ];

  //fallbackLocale that mean default locale
  static const fallbackLocale = const Locale('en', 'US');

  //Locale support
  static final localesSupport = [
    const Locale('en', 'US'),
    const Locale('vi', 'VN'),
  ];

  //Language map
  static final languageMap = LinkedHashMap.from({
    'en': 'English',
    'vi': 'Tiếng Việt',
  });

  static Locale _getLocaleFromLanguage({String? langCode}) {
    var lang = langCode ?? Get.deviceLocale?.languageCode;
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return localesSupport[i];
    }
    return localesSupport.first;
  }

  static void changeLocale(String? langCode) {
    final locale = _getLocaleFromLanguage(langCode: langCode);
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'vi_VN': vi,
      };
}
