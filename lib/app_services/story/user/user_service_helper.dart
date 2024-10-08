

import 'package:mobile_rhm/data/model/response/user/me/UserProfile.dart';

abstract class UserServiceHelper {
  void logout();

  UserProfile? getUserProfile();
}
