import 'package:get/get.dart';
import 'package:mobile_rhm/app_services/story/permisson/permisson_list.dart';
import 'package:mobile_rhm/app_services/story/rhm_service.dart';
import 'package:mobile_rhm/core/constants/keys.dart';
import 'package:mobile_rhm/data/model/response/task/bao_cao_cong_viec.dart';
import 'package:mobile_rhm/data/model/response/task/subtask_list_response.dart';
import 'package:mobile_rhm/data/model/response/user/me/UserProfile.dart';

class ReportDetailState {
  Rx<Baocaocongviec> report = (Get.arguments[AppExtraData.DATA] as Baocaocongviec).obs;
  SubTaskDetail taskDetail = Get.arguments[AppExtraData.EXTRA_DATA];
  RxBool hasPermissonEdit = false.obs;
  bool hasPermissionAddReview = false;
  bool hasPermissionAddNewReport = false;
  bool hasPermissionDelete = false;

  ReportDetailState() {
    final RHMService rhmService = Get.find<RHMService>();
    UserProfile? user = rhmService.userService.getUserProfile();
    if (rhmService.metadataService.hasPermission(permission: user?.permission ?? [], checkPermisson: PermissonList.BAOCAO_CONGVIEC_UPDATE)) {
      hasPermissonEdit.value = true;
    }
    if (rhmService.metadataService.hasPermission(permission: user?.permission ?? [], checkPermisson: PermissonList.DANHGIA_BAOCAO_CREATE)) {
      hasPermissionAddReview = true;
    }
    if (rhmService.metadataService.hasPermission(permission: user?.permission ?? [], checkPermisson: PermissonList.BAOCAO_CONGVIEC_CREATE)) {
      hasPermissionAddNewReport = true;
    }
    if (rhmService.metadataService.hasPermission(permission: user?.permission ?? [], checkPermisson: PermissonList.BAOCAO_CONGVIEC_DELETE)) {
      hasPermissionDelete = true;
    }
  }
}
