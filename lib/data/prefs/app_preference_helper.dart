import 'package:shared_preferences/shared_preferences.dart';

import 'preference_keys.dart';
import 'preference_helper.dart';

class AppPreferenceHelper implements PreferenceHelper {
  final SharedPreferences _sharedPreferences;

  AppPreferenceHelper(this._sharedPreferences);

//Define all method here
  @override
  String? authToken() {
    return _sharedPreferences.getString(PreferenceKeys.AUTH_TOKEN);
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPreferences.setString(PreferenceKeys.AUTH_TOKEN, authToken);
  }

  @override
  bool isRememberLogin() {
    return _sharedPreferences.getBool(PreferenceKeys.REMEMBER_LOGIN) ?? true;
  }

  @override
  void setRememberLogin({required bool isRemember}) {
    _sharedPreferences.setBool(PreferenceKeys.REMEMBER_LOGIN, isRemember);
  }

  @override
  String? refreshToken() {
    return _sharedPreferences.getString(PreferenceKeys.REFRESH_TOKEN);
  }

  @override
  Future<bool> saveRefreshToken(String refreshToken) {
    return _sharedPreferences.setString(PreferenceKeys.REFRESH_TOKEN, refreshToken);
  }

  @override
  String? currentDomainUrl() {
    return _sharedPreferences.getString(PreferenceKeys.CURRENT_DOMAIN_URL);
  }

  @override
  Future<bool> saveCurrentDomainUrl(String url) {
    return _sharedPreferences.setString(PreferenceKeys.CURRENT_DOMAIN_URL, url);
  }
}
