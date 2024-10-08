import 'package:get/get.dart';
import 'package:mobile_rhm/data/model/common/task_filter.dart';

import '../../../data/model/response/task/task.dart';

class HomeState {
  Rx<TasksResponse> taskResponse = TasksResponse().obs;
  RxBool isLoadMore = false.obs;
  RxInt currentPage = 1.obs;
  RxInt totalPage = 0.obs;
  RxBool isLoading = true.obs;
  RxList<TaskFilter> taskFilters = <TaskFilter>[].obs;
  RxString searchTaskName = ''.obs;
}
