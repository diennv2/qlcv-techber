import 'package:mobile_rhm/data/model/response/meta/domain.dart';
import 'package:mobile_rhm/data/model/response/user/me/UserProfile.dart';

abstract class DatabaseHelper {

  void saveUserProfile({required UserProfile profile});

  UserProfile? getUserProfile();

  void saveDomains({required List<DomainModel> domains});

  List<DomainModel>? getLocalDomains();
}
