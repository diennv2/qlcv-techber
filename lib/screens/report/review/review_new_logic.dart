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

import 'review_new_state.dart';

class ReviewNewLogic extends GetxController {
  final ReviewNewState state = ReviewNewState();
  final TextEditingController reviewTextController = TextEditingController();
  final RHMService _rhmService = Get.find<RHMService>();

  @override
  void onReady() {
    reviewTextController.addListener(() {
      state.errorReviewContent.value = '';
    });
  }

  Future<List<Dio.MultipartFile>> _createFiles() async {
    List<Dio.MultipartFile> files = [];
    if (state.attachFiles.isNotEmpty) {
      for (var file in state.attachFiles.value) {
        var mul = await Dio.MultipartFile.fromFile(file.xFile.path, filename: file.name);
        files.add(mul);
      }
    }
    return files;
  }

  void _submitTask() async {
    try {
      DialogUtils.showLoading();

      List<Dio.MultipartFile> files = await _createFiles();
      var request = {
        'baocao_id': state.reportId,
        'Danhgiabaocao[noidungdanhgia]': reviewTextController.text,
        'fileupload': files.isNotEmpty ? files.first : null,
      };

      LogUtils.log(request);
      Dio.FormData formData = Dio.FormData.fromMap(request);
      var res = await _rhmService.taskService.addNewReview(data: formData);
      DialogUtils.hideLoading();
      if (res != null && res['status'] == true) {
        _rhmService.toastService.showToast(message: AppStrings.add_review_success.tr, isSuccess: true, context: Get.context!);
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
        title: AppStrings.add_review_confirm.tr,
        positiveText: AppStrings.btn_new.tr,
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
    String reviewContent = reviewTextController.text;
    if (reviewContent.isNullOrEmpty) {
      state.errorReviewContent.value = AppStrings.required_field.tr;
      return false;
    }

    return true;
  }
}
