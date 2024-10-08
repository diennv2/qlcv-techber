import 'package:dio/dio.dart' as Dio;
import 'package:file_picker/file_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_services/story/rhm_service.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/app_widgets/warning_view.dart';
import 'package:mobile_rhm/core/constants/file_type.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/utils/dialog_utils.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/core/values/assets.dart';

import 'report_new_state.dart';

class ReportNewLogic extends GetxController {
  final ReportNewState state = ReportNewState();
  final RHMService _rhmService = Get.find<RHMService>();
  final TextEditingController reportContentTextController = TextEditingController();
  final TextEditingController reportResultTextController = TextEditingController();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    reportContentTextController.addListener(() {
      state.errorReportContent.value = '';
    });
    _initData();
  }

  _initData() {
    //TODO: init cause Update
    if (state.report != null) {
      reportContentTextController.text = state.report?.noidungbaocao ?? '';
      reportResultTextController.text = state.report?.ketquadatduoc ?? '';
    }
  }

  Future<Dio.MultipartFile?> _createFile() async {
    if (state.attachFiles.isNotEmpty) {
      var mul = await Dio.MultipartFile.fromFile(state.attachFiles.first.xFile.path, filename: state.attachFiles.first.name);
      return mul;
    }
    return null;
  }

  void _submitTask() async {
    try {
      DialogUtils.showLoading();

      Dio.MultipartFile? file = await _createFile();
      var request;
      if (state.report != null) {
        //Case update report
        request = {
          'baocao_id': state.report?.id ?? 0,
          'Baocaocongviec[noidungbaocao]': reportContentTextController.text,
          'Baocaocongviec[ketquadatduoc]': reportResultTextController.text,
          'fileupload': file,
        };
      } else {
        if (state.reportRootId != null) {
          //Case create sub report
          request = {
            'congviec_id': state.taskDetail.id,
            'Baocaocongviec[noidungbaocao]': reportContentTextController.text,
            'Baocaocongviec[ketquadatduoc]': reportResultTextController.text,
            'fileupload': file,
            'parent': state.reportRootId
          };
        } else {
          //Case create new report
          request = {
            'congviec_id': state.taskDetail.id,
            'Baocaocongviec[noidungbaocao]': reportContentTextController.text,
            'Baocaocongviec[ketquadatduoc]': reportResultTextController.text,
            'fileupload': file,
          };
        }
      }

      LogUtils.log(request);
      Dio.FormData formData = Dio.FormData.fromMap(request);
      var res = await _rhmService.taskService.createOrUpdateReport(data: formData, isCreateNew: state.report == null);
      DialogUtils.hideLoading();
      if (res != null && res['status'] == true) {
        _rhmService.toastService.showToast(
            message: state.report != null ? AppStrings.update_success.tr : AppStrings.add_new_success.tr, isSuccess: true, context: Get.context!);
        Get.back();
      } else {
        _rhmService.toastService.showToast(message: res['message'] ?? AppStrings.error_common.tr, isSuccess: false, context: Get.context!);
      }
    } catch (e) {
      DialogUtils.hideLoading();
      _rhmService.toastService.showToast(message: AppStrings.error_common.tr, isSuccess: false, context: Get.context!);
    }
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
        title: state.report != null ? AppStrings.update_report_confirm.tr : AppStrings.add_report_confirm.tr,
        positiveText: state.report != null ? AppStrings.btn_update.tr : AppStrings.btn_new.tr,
        negativeText: AppStrings.btn_cancel.tr,
        onPositive: () {
          _submitTask();
        });
    DialogUtils.showCenterDialog(child: confirmSendView);
  }

  void onAddNewReview() {
    bool isValid = isFormValid();
    if (isValid) {
      confirmSubmitTask();
    } else {
      _rhmService.toastService.showToast(message: AppStrings.form_invalid_error.tr, isSuccess: false, context: Get.context!);
    }
  }

  void clearFile(PlatformFile file) {
    state.attachFiles.remove(file);
    state.attachFiles.refresh();
  }

  void addFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: FileExtension.EXTENSTION,
    );
    if (result != null) {
      state.attachFiles.addAll(result.files);
      state.attachFiles.toSet().toList();
      state.attachFiles.refresh();
    } else {
      // User canceled the picker
    }
  }

  bool isFormValid() {
    String content = reportContentTextController.text;
    if (content.isNullOrEmpty) {
      state.errorReportContent.value = AppStrings.required_field.tr;
      return false;
    }

    return true;
  }

  void onAddOrUpdateReport() {
    bool isValid = isFormValid();
    if (isValid) {
      confirmSubmitTask();
    } else {
      _rhmService.toastService.showToast(message: AppStrings.form_invalid_error.tr, isSuccess: false, context: Get.context!);
    }
  }
}
