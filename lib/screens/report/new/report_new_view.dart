import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/button/app_solid_button.dart';
import 'package:mobile_rhm/app_widgets/button/media_select_button.dart';
import 'package:mobile_rhm/app_widgets/edit_text.dart';
import 'package:mobile_rhm/app_widgets/hide_keyboard.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import 'report_new_logic.dart';

class ReportNewPage extends StatelessWidget {
  ReportNewPage({Key? key}) : super(key: key);

  final logic = Get.find<ReportNewLogic>();
  final state = Get.find<ReportNewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return HideKeyBoard(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            state.taskDetail.tencongviec ?? '',
            style: AppTextStyle.body_text,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          children: [
            Obx(() {
              return EditTextView(
                textAlignVertical: TextAlignVertical.top,
                isDisable: false,
                hintText: AppStrings.report_content_hint.tr,
                label: AppStrings.report_content.tr,
                isShowLabel: true,
                controller: logic.reportContentTextController,
                inputType: TextInputType.text,
                required: true,
                isForceMaxlines: true,
                maxLines: null,
                height: 120.h,
                errorMessage: state.errorReportContent.value,
              );
            }),
            SizedBox(
              height: 20.h,
            ),
            Obx(() {
              return EditTextView(
                textAlignVertical: TextAlignVertical.top,
                isDisable: false,
                hintText: AppStrings.report_result_hint.tr,
                label: AppStrings.report_result.tr,
                isShowLabel: true,
                controller: logic.reportResultTextController,
                inputType: TextInputType.text,
                required: false,
                isForceMaxlines: true,
                maxLines: null,
                height: 120.h,
                errorMessage: state.errorReportContent.value,
              );
            }),
            SizedBox(
              height: 20.h,
            ),
            if (state.report?.filedinhkem.isNotNullOrEmpty == true)
              Container(
                padding: const EdgeInsets.all(8),
                margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                decoration: BoxDecoration(color: AppColors.GrayLight, borderRadius: BorderRadius.circular(6)),
                child: Row(
                  children: [
                    const Icon(Icons.attach_file),
                    SizedBox(
                      width: 8.w,
                    ),
                    Expanded(
                      child: Text(
                        state.report!.filedinhkem!.split('/').last,
                        style: AppTextStyle.regular_12.copyWith(color: AppColors.Light, decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: 8.h,
            ),
            Obx(() {
              return Wrap(
                children: [
                  ...state.attachFiles.value.map((file) {
                    return MediaSelectButton(
                        file: file,
                        buttonText: file.name,
                        onSelectMedia: () {},
                        clearMedia: (file) {
                          logic.clearFile(file);
                        });
                  }),
                  if (state.attachFiles.isEmpty && state.report?.filedinhkem == null)
                    MediaSelectButton(
                        buttonText: AppStrings.add_media.tr,
                        onSelectMedia: () {
                          logic.addFile();
                        },
                        clearMedia: (file) {}),
                  SizedBox(
                    width: 12.w,
                  ),
                ],
              );
            }),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: AppSolidButton(
            text: state.report != null ? AppStrings.btn_update.tr : AppStrings.btn_new.tr,
            isDisable: false,
            onPress: () {
              logic.onAddOrUpdateReport();
            },
          ),
        ),
      ),
    );
  }
}
