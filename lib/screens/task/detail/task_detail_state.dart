import 'package:get/get.dart';
import 'package:mobile_rhm/app_services/story/permisson/permisson_list.dart';
import 'package:mobile_rhm/app_services/story/rhm_service.dart';
import 'package:mobile_rhm/core/constants/keys.dart';
import 'package:mobile_rhm/core/constants/roles.dart';
import 'package:mobile_rhm/core/constants/task.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/data/model/common/opttion_model.dart';
import 'package:mobile_rhm/data/model/response/task/chat_info.dart';
import 'package:mobile_rhm/data/model/response/user/me/UserProfile.dart';

import '../../../data/model/response/task/sub_task_progress_response.dart';
import '../../../data/model/response/task/subtask_list_response.dart';
import '../../../data/model/response/task/task.dart';

class TaskDetailState {
  TaskDetail task = Get.arguments[AppExtraData.DATA];
  Rx<SubTaskListResponse> subTasks = SubTaskListResponse().obs;
  RxMap<num, SubTaskProgressResponse> subTasksProgress = <int, SubTaskProgressResponse>{}.obs;
  RxBool isAllowCRUD = false.obs;
  RxBool isAllowUpdateSubTask = false.obs;
  RxBool isAllowAddSubTask = false.obs;
  Rx<ChatInfo> chatInfo = ChatInfo().obs;
  RxString statusText = ''.obs;
  bool isAllowAddReport = false;
  Rx<OptionModel> currentStatus = OptionModel().obs;
  RxBool isLoadMore = false.obs;
  int taskDetailCurrentPage = 1;
  int taskDetailTotalPage = 1;

  TaskDetailState() {
    currentStatus = OptionModel(key: '${task.status}', value: '${task.status}').obs;
    LogUtils.logE(message: 'Task name ${task.ten}');
    final RHMService _rhmService = Get.find<RHMService>();
    UserProfile? user = _rhmService.userService.getUserProfile();
    if (user?.displayName?.toLowerCase() == UserRole.SUPER_ADMIN.toLowerCase() || user?.userId == task.nguoiphutrachId) {
      isAllowCRUD.value = true;
      if (task.status == TaskStatus.COMPLETED || task.status == TaskStatus.CANCELED) {
        isAllowCRUD.value = false;
      }
    }

    if (_rhmService.metadataService.hasPermission(permission: user?.permission ?? [], checkPermisson: PermissonList.BAOCAO_CONGVIEC_CREATE)) {
      isAllowAddReport = true;
    }

    //Status text
    statusText = TaskStatus.statusText(status: task.status ?? -1, progress: task.tiendocongviec).obs;
  }
}
