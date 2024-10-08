abstract class PreferenceHelper {
  String? authToken();

  Future<bool> saveAuthToken(String authToken);

  String? refreshToken();

  Future<bool> saveRefreshToken(String refreshToken);

  Future<bool> saveCurrentDomainUrl(String url);

  String? currentDomainUrl();

  void setRememberLogin({required bool isRemember});

  bool isRememberLogin();

}
