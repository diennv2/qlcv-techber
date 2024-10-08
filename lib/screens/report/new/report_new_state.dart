import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/core/constants/keys.dart';
import 'package:mobile_rhm/data/model/response/task/bao_cao_cong_viec.dart';
import 'package:mobile_rhm/data/model/response/task/subtask_list_response.dart';

class ReportNewState {
  SubTaskDetail taskDetail = Get.arguments[AppExtraData.EXTRA_DATA];
  Baocaocongviec? report = Get.arguments[AppExtraData.DATA];
  int? reportRootId = Get.arguments[AppExtraData.ID];

  RxList<PlatformFile> attachFiles = <PlatformFile>[].obs;
  RxString errorReportContent = ''.obs;
  ReportNewState() {
    ///Initialize variables
  }
}
