import 'dart:convert';

import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/data/local/database_helper.dart';
import 'package:mobile_rhm/data/local/database_keys.dart';
import 'package:mobile_rhm/data/model/response/meta/domain.dart';
import 'package:mobile_rhm/data/model/response/user/me/UserProfile.dart';
import 'package:mobile_rhm/di/module/local_module.dart';

class AppDatabaseHelper extends DatabaseHelper {
  final AppHiveBox _box;

  AppDatabaseHelper(this._box);

  @override
  void saveUserProfile({required UserProfile profile}) {
    _box.userProfile.put(DatabaseKeys.USER_PROFILE, jsonEncode(profile));
  }

  @override
  UserProfile? getUserProfile() {
    String? userProfile = _box.userProfile.get(DatabaseKeys.USER_PROFILE, defaultValue: null);
    if (userProfile.isNotNullOrBlank) {
      LogUtils.logE(message: 'Local User Pro: $userProfile');
      return UserProfile.fromJson(jsonDecode(userProfile!));
    }
    return null;
  }

  @override
  List<DomainModel>? getLocalDomains() {
    String? domainStr = _box.metaData.get(DatabaseKeys.DOMAIN, defaultValue: null);
    if (domainStr.isNotNullOrBlank) {
      List<dynamic> jsonList = jsonDecode(domainStr!);
      List<DomainModel> domains = jsonList.map((json) => DomainModel.fromJson(json)).toList();
      return domains;
    }
    return null;
  }

  @override
  void saveDomains({required List<DomainModel> domains}) {
    if (domains.isNotEmpty) {
      String jsonDomains = jsonEncode(domains.map((domain) => domain.toJson()).toList());
      LogUtils.logE(message: 'Save Domain $jsonDomains');
      _box.metaData.put(DatabaseKeys.DOMAIN, jsonDomains);
    }
  }
}
