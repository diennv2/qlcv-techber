import 'package:get/get.dart';
import 'package:mobile_rhm/data/model/common/task_filter.dart';
import 'package:mobile_rhm/data/model/response/calendar/task_calendar.dart';


class ReviewCalendarState {
  Rx<AllLichHenResponse> taskResponse = AllLichHenResponse().obs;
  RxBool isLoadMore = false.obs;
  RxInt currentPage = 1.obs;
  RxInt totalPage = 0.obs;
  RxBool isLoading = true.obs;
  RxString searchTaskName = ''.obs;
}
