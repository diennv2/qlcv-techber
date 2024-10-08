import 'package:get/get.dart';
import 'package:mobile_rhm/data/model/response/notification/notification.dart';

class NotificationListState {
  RxList<NotificationResponse> notifications = <NotificationResponse>[].obs;
  RxBool isLoading = true.obs;

  NotificationListState() {
    ///Initialize variables
  }
}
