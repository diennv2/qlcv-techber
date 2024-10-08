import 'package:get/get.dart';
import 'package:mobile_rhm/app_services/story/auth/authen_service_helper.dart';
import 'package:mobile_rhm/app_services/story/user/user_service.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/data/model/response/user/me/UserProfile.dart';
import 'package:mobile_rhm/data/network/exceptions/auth_exceptions.dart';
import 'package:mobile_rhm/data/repository_manager.dart';
import 'package:mobile_rhm/di/components/service_locator.dart';

class AuthenService extends GetxService implements AuthenServiceHelper {
  final RepositoryManager _repositoryManager = getIt<RepositoryManager>();
  final UserService _userService = Get.find<UserService>();

  @override
  Future forgotPass({required String email}) {
    // TODO: implement forgotPass
    throw UnimplementedError();
  }

  @override
  Future signIn(
      {required String email,
      required String password,
      required bool isRememberLogin,
      required Function onSuccess,
      required Function onError}) async {
    try {
      UserProfile? userProfile = await _repositoryManager.login(userName: email, password: password);
      if (userProfile != null) {
        LogUtils.logE(message: 'Authe token = ${userProfile.token}');
        LogUtils.logE(message: 'REFRESH token = ${userProfile.refreshToken}');
        _repositoryManager.saveAuthToken(userProfile.token ?? '');
        _repositoryManager.saveRefreshToken(userProfile.refreshToken ?? '');
        _repositoryManager.saveUserProfile(profile: userProfile);
        _repositoryManager.setRememberLogin(isRemember: isRememberLogin);
        onSuccess.call();
        //TODO: Next step get me
      } else {
        onError.call(AppStrings.error_sign_fail_system.tr);
      }
    } catch (e) {
      if (e is AuthException) {
        onError.call(AppStrings.error_sign_fail_wrong_input.tr);
      } else {
        onError.call(AppStrings.error_sign_fail_system.tr);
      }
    }
  }

  @override
  String? authToken() {
    return _repositoryManager.authToken();
  }

  @override
  Future<void> changePassword({required String oldPassword, required String newPassword, required Function onSuccess, required Function onError}) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<void> forgetPassword(
      {required int step, String? code, String? newPassword, String? email, required Function onSuccess, required Function onError}) {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  void saveCurrentDomain({required String domain}) {
    _repositoryManager.saveCurrentDomainUrl(domain);
  }
}
