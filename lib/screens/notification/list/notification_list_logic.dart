import 'package:get/get.dart';
import 'package:mobile_rhm/data/model/response/notification/notification.dart';
import 'package:mobile_rhm/data/repository_manager.dart';
import 'package:mobile_rhm/di/components/service_locator.dart';

import 'notification_list_state.dart';

class NotificationListLogic extends GetxController {
  final NotificationListState state = NotificationListState();
  final RepositoryManager _repositoryManager = getIt<RepositoryManager>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _loadData();
  }

  _loadData() async {
    state.isLoading.value = true;
    var res =  await _repositoryManager.notificationList();
    state.isLoading.value = false;
    if(res != null){
      state.notifications.value = res;
    }

  }

  void onDetail(NotificationResponse item) {}
}
