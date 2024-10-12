import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/button/app_solid_button.dart';
import 'package:mobile_rhm/app_widgets/button/media_select_button.dart';
import 'package:mobile_rhm/app_widgets/dropdown/dropdown.dart';
import 'package:mobile_rhm/app_widgets/edit_text.dart';
import 'package:mobile_rhm/app_widgets/task/group_value_view.dart';
import 'package:mobile_rhm/app_widgets/task/select_staff_view.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';

import 'create_new_plan_logic.dart';

class CreateNewPlanPage extends StatelessWidget {
  CreateNewPlanPage({super.key});

  final logic = Get.find<CreateNewPlanLogic>();
  final state = Get.find<CreateNewPlanLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.White,
        appBar: AppBar(
          backgroundColor: AppColors.White,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(
            state.task != null ? AppStrings.task_update_title.tr : AppStrings.task_new_title.tr,
            style: AppTextStyle.medium_18,
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          children: [
            Obx(() {
              return EditTextView(
                errorMessage: state.errorTaskName.value,
                isDisable: false,
                hintText: AppStrings.task_name.tr,
                label: AppStrings.task_name.tr,
                isShowLabel: true,
                controller: logic.taskNameController,
                inputType: TextInputType.text,
                required: true,
              );
            }),
            SizedBox(
              height: 20.h,
            ),
            EditTextView(
              textAlignVertical: TextAlignVertical.top,
              isDisable: false,
              hintText: AppStrings.task_descriptions.tr,
              label: AppStrings.task_content.tr,
              isShowLabel: true,
              controller: logic.taskInfoController,
              inputType: TextInputType.text,
              required: false,
              isForceMaxlines: true,
              maxLines: null,
              height: 120.h,
            ),
            SizedBox(
              height: 20.h,
            ),
            Obx(() {
              return GroupValueView(
                title: AppStrings.task_manage_incharge.tr,
                options: state.lanhDaos.value,
                onSelectOption: (selected) {
                  logic.selectLanhDao(selected);
                },
                isRadio: false,
                controller: logic.groupLanhDaoController,
              );
            }),
            SizedBox(
              height: 20.h,
            ),
            Obx(() {
              return GroupValueView(
                title: AppStrings.task_type_label.tr,
                options: state.typeOfWorksPlan.value,
                onSelectOption: (selected) {
                  logic.selectTypeOfWork(selected);
                },
                isRadio: true,
                controller: logic.groupTypeWorkController,
              );
            }),
            SizedBox(
              height: 20.h,
            ),
            Obx(() {
              return DropDownView(
                  label: AppStrings.task_start_time.tr,
                  hint: AppStrings.task_start_time_hint.tr,
                  required: true,
                  errorText: state.errorStartTime.value,
                  value: state.dateTimeStartValue.value,
                  onPress: () async {
                    logic.selectTaskStartTime();
                  });
            }),
            SizedBox(
              height: 20.h,
            ),
            Obx(() {
              return DropDownView(
                  label: AppStrings.task_end_time.tr,
                  hint: AppStrings.task_end_time_hint.tr,
                  required: false,
                  value: state.dateTimeEndValue.value,
                  onPress: () async {
                    logic.selectTaskEndTime();
                  });
            }),
            SizedBox(
              height: 20.h,
            ),
            Obx(() {
              return GroupValueView(
                title: AppStrings.task_is_important.tr,
                options: state.typeOfImportants.value,
                onSelectOption: (selected) {
                  logic.selectImportant(selected);
                },
                isRadio: true,
                controller: logic.groupImportantController,
              );
            }),
            // SizedBox(
            //   height: 20.h,
            // ),
            // Obx(() {
            //   return GroupValueView(
            //     title: AppStrings.task_manage_finance.tr,
            //     options: state.typeOfFinances.value,
            //     onSelectOption: (selected) {
            //       logic.selectFinance(selected);
            //     },
            //     isRadio: true,
            //     controller: logic.groupFinanceController,
            //   );
            // }),
            SizedBox(
              height: 20.h,
            ),
            Obx(() {
              return GroupValueView(
                title: AppStrings.task_status.tr,
                options: state.statusOfWorks.value,
                onSelectOption: (selected) {
                  logic.selectStatusOfWork(selected);
                },
                isRadio: true,
                controller: logic.groupTaskStatusController,
              );
            }),
            SizedBox(
              height: 20.h,
            ),
            Text(
              AppStrings.add_attach.tr,
              style: AppTextStyle.medium_14,
            ),
            SizedBox(
              height: 8.h,
            ),
            ...(state.task?.fileDinhKem ?? []).map((file) {
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: AppColors.GrayLight, borderRadius: BorderRadius.circular(6)),
                child: Text(
                  file.url ?? '',
                  style: AppTextStyle.regular_12.copyWith(color: AppColors.Light, decoration: TextDecoration.underline),
                ),
              );
            }),
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
            Text(
              AppStrings.select_staff_for_task.tr,
              style: AppTextStyle.medium_14,
            ),
            SizedBox(
              height: 8.h,
            ),
            Obx(() {
              return SelectStaffView(
                staffs: state.staffs.value,
                phongBans: state.phongBans.value,
                onStaffChange: (staff, dep) {
                  logic.onStaffChange(staff: staff, dep: dep);
                },
              );
            })
          ],
        ),
        bottomNavigationBar: Obx(() {
          bool isAllowCRUD = state.isAllowCRUD.value;
          return isAllowCRUD
              ? Container(
                  color: AppColors.White,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: AppSolidButton(
                      text: state.task != null ? AppStrings.btn_update.tr : AppStrings.btn_new.tr,
                      isDisable: false,
                      onPress: () {
                        logic.createNewOrUpdateTask();
                      }),
                )
              : const SizedBox.shrink();
        }));
  }
}
