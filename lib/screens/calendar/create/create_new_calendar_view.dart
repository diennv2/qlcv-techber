import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/button/app_solid_button.dart';
import 'package:mobile_rhm/app_widgets/dropdown/dropdown.dart';
import 'package:mobile_rhm/app_widgets/edit_text.dart';
import 'package:mobile_rhm/app_widgets/task/group_value_view.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';

import 'create_new_calendar_logic.dart';

class CreateNewCalendarPage extends StatelessWidget {
  CreateNewCalendarPage({super.key});

  final logic = Get.find<CreateNewCalendarLogic>();
  final state = Get.find<CreateNewCalendarLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.White,
        appBar: AppBar(
          backgroundColor: AppColors.White,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(
            state.task != null ? AppStrings.calendar_update_title.tr : AppStrings.calendar_new_title.tr,
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
                hintText: AppStrings.calendar_name.tr,
                label: AppStrings.calendar_name.tr,
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
              hintText: AppStrings.calendar_descriptions.tr,
              label: AppStrings.calendar_content.tr,
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
                title: AppStrings.calendar_manage_incharge.tr,
                options: state.lanhDaos.value,
                onSelectOption: (selected) {
                  logic.selectLanhDao(selected); // Select only one leader
                },
                isRadio: true, // Ensure it's a radio button style selection
                controller: logic.groupLanhDaoController,
              );
            }),
            SizedBox(
              height: 20.h,
            ),
            Obx(() {
              return DropDownView(
                  label: AppStrings.calendar_start_time.tr,
                  hint: AppStrings.calendar_start_time_hint.tr,
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
                  label: AppStrings.calendar_end_time.tr,
                  hint: AppStrings.calendar_end_time_hint.tr,
                  required: false,
                  value: state.dateTimeEndValue.value,
                  onPress: () async {
                    logic.selectTaskEndTime();
                  });
            }),
            SizedBox(
              height: 20.h,
            ),
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
