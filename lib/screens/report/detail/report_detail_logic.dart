import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_services/story/permisson/permisson_list.dart';
import 'package:mobile_rhm/app_services/story/rhm_service.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/app_widgets/warning_view.dart';
import 'package:mobile_rhm/core/constants/keys.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/utils/dialog_utils.dart';
import 'package:mobile_rhm/core/utils/file_utils.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/data/model/response/task/bao_cao_cong_viec.dart';
import 'package:mobile_rhm/data/model/response/user/me/UserProfile.dart';
import 'package:mobile_rhm/routers/app_pages.dart';
import 'package:dio/dio.dart' as Dio;

import 'report_detail_state.dart';

class ReportDetailLogic extends GetxController {
  final ReportDetailState state = ReportDetailState();
  final RHMService _rhmService = Get.find<RHMService>();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _initData();
  }

  _initData() {
    UserProfile? user = _rhmService.userService.getUserProfile();
    if (_rhmService.metadataService.hasPermission(permission: user?.permission ?? [], checkPermisson: PermissonList.BAOCAO_CONGVIEC_UPDATE)) {
      state.hasPermissonEdit.value = true;
    }
  }

  _reloadData() async {
    LogUtils.logE(message: 'Reload getSingleSubTaskProgress');
    var res = await _rhmService.taskService.getSingleSubTaskProgress(id: state.taskDetail.id ?? 0);
    if (res != null) {
      for (Baocaocongviec report in res.baocaocongviec ?? []) {
        if (report.id == state.report.value.id) {
          state.report.value = report;
          state.report.refresh();
          break;
        }
      }
    }
  }

  void updateReport() async {
    await Get.toNamed(Routers.REPORT_NEW, arguments: {AppExtraData.EXTRA_DATA: state.taskDetail, AppExtraData.DATA: state.report.value});
    _reloadData();
  }

  void openAttach(String link) {
    FileUtils.openRemoteFile(file: link);
  }

  void addNewReview() async {
    await Get.toNamed(Routers.REVIEW_NEW, arguments: {AppExtraData.DATA: state.taskDetail, AppExtraData.ID: state.report.value.id});
    _reloadData();
  }

  void addNewAddtionalReport() async {
    await Get.toNamed(Routers.REPORT_NEW, arguments: {AppExtraData.EXTRA_DATA: state.taskDetail, AppExtraData.ID: state.report.value.id});
    _reloadData();
  }

  void confirmSubmitTask() {
    Widget confirmSendView = WarningView(
        icon: Container(
          margin: EdgeInsets.only(bottom: 20.h),
          child: ImageDisplay(
            Assets.ic_complete_test,
            width: 116.w,
          ),
        ),
        title: AppStrings.delete_report_confirm.tr,
        positiveText: AppStrings.btn_delete.tr,
        negativeText: AppStrings.btn_cancel.tr,
        onPositive: () {
          _submitDeleteReport();
        });
    DialogUtils.showCenterDialog(child: confirmSendView);
  }

  void deleteReport() {
    confirmSubmitTask();
  }

  _submitDeleteReport() async {
    try {
      DialogUtils.showLoading();

      var request = {
        'baocao_id': state.report.value.id,
      };

      LogUtils.log(request);
      Dio.FormData formData = Dio.FormData.fromMap(request);
      var res = await _rhmService.taskService.deleteReport(data: formData);
      DialogUtils.hideLoading();
      if (res != null && res['status'] == true) {
        _rhmService.toastService.showToast(message: AppStrings.common_success.tr, isSuccess: true, context: Get.context!);
        Get.back();
      } else {
        _rhmService.toastService.showToast(message: res['message'] ?? AppStrings.error_common.tr, isSuccess: false, context: Get.context!);
      }
    } catch (e) {
      DialogUtils.hideLoading();
      _rhmService.toastService.showToast(message: AppStrings.error_common.tr, isSuccess: false, context: Get.context!);
    }
  }
}
