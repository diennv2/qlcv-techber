import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/button/app_solid_button.dart';
import 'package:mobile_rhm/app_widgets/button/media_select_button.dart';
import 'package:mobile_rhm/app_widgets/dropdown/dropdown.dart';
import 'package:mobile_rhm/app_widgets/edit_text.dart';
import 'package:mobile_rhm/app_widgets/hide_keyboard.dart';
import 'package:mobile_rhm/app_widgets/task/group_value_view.dart';
import 'package:mobile_rhm/app_widgets/task/select_associate_view.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import 'create_sub_task_logic.dart';

class CreateSubTaskPage extends StatelessWidget {
  CreateSubTaskPage({super.key});

  final logic = Get.find<CreateSubTaskLogic>();
  final state = Get.find<CreateSubTaskLogic>().state;

  @override
  Widget build(BuildContext context) {
    return HideKeyBoard(
      child: Scaffold(
          backgroundColor: AppColors.White,
          appBar: AppBar(
            backgroundColor: AppColors.White,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Text(
              state.task != null ? (state.rootTaskName ?? AppStrings.subtask_update_title.tr) : AppStrings.subtask_create_new_title.tr,
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
              Obx(() {
                return DropDownView(
                    label: AppStrings.subtask_head_office.tr,
                    hint: AppStrings.subtask_head_office_hint.tr,
                    value: state.coQuanSelect.value,
                    onPress: () async {
                      logic.selectCoQuan();
                    });
              }),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(() {
                return DropDownView(
                    label: AppStrings.subtask_assign_date.tr,
                    hint: AppStrings.subtask_assign_date_hint.tr,
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
              ...(state.task?.filedinhkem ?? []).map((file) {
                return Container(
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
                          file.split('/').last,
                          style: AppTextStyle.regular_12.copyWith(color: AppColors.Light, decoration: TextDecoration.underline),
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      TouchableOpacity(
                        behavior: HitTestBehavior.translucent,
                        child: const Icon(Icons.delete_forever_sharp),
                        onTap: () {
                          logic.onDeleteAttachment(file: file);
                        },
                      )
                    ],
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
                AppStrings.subtask_add_employee.tr,
                style: AppTextStyle.medium_14,
              ),
              SizedBox(
                height: 8.h,
              ),
              Obx(() {
                return SelectStaffAssociateView(
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
          })),
    );
  }
}
