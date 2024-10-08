import 'package:get/get.dart';
import 'package:mobile_rhm/app_services/meta/metadata_service.dart';
import 'package:mobile_rhm/app_services/story/user/user_service_helper.dart';
import 'package:mobile_rhm/data/model/response/user/me/UserProfile.dart';
import 'package:mobile_rhm/data/repository_manager.dart';
import 'package:mobile_rhm/di/components/service_locator.dart';

class UserService extends GetxService implements UserServiceHelper {
  final RepositoryManager _repositoryManager = getIt<RepositoryManager>();

  @override
  void logout() {
    final MetadataService metadataService = Get.find();
    _repositoryManager.saveAuthToken('');
    _repositoryManager.saveUserProfile(profile: UserProfile());
    metadataService.logout();
  }

  @override
  UserProfile? getUserProfile() {
    return _repositoryManager.getUserProfile();
  }
}
