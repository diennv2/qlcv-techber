import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/core/constants/keys.dart';
import 'package:mobile_rhm/data/model/response/task/subtask_list_response.dart';

class ReviewNewState {
  SubTaskDetail taskDetail = Get.arguments[AppExtraData.DATA];
  int reportId = Get.arguments[AppExtraData.ID];

  RxList<PlatformFile> attachFiles = <PlatformFile>[].obs;
  RxString errorReviewContent = ''.obs;
  ReviewNewState() {
    ///Initialize variables
  }
}
