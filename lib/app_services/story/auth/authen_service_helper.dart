abstract class AuthenServiceHelper {
  void saveCurrentDomain({required String domain});

  Future signIn(
      {required String email, required String password, required bool isRememberLogin, required Function onSuccess, required Function onError});

  Future forgotPass({required String email});

  String? authToken();

  Future<void> changePassword({required String oldPassword, required String newPassword, required Function onSuccess, required Function onError});

  Future<void> forgetPassword(
      {required int step, String? code, String? newPassword, String? email, required Function onSuccess, required Function onError});
}
