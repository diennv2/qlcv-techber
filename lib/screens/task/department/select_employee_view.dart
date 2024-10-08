import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/button/app_solid_button.dart';
import 'package:mobile_rhm/app_widgets/container/base_container.dart';
import 'package:mobile_rhm/app_widgets/skeleton_loading.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/utils/device_utils.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:mobile_rhm/data/model/response/task/employee.dart';

import 'select_employee_logic.dart';

class SelectEmployeePage extends StatelessWidget {
  SelectEmployeePage({Key? key}) : super(key: key);

  final logic = Get.find<SelectEmployeeLogic>();
  final state = Get.find<SelectEmployeeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.Primary,
        body: BaseContainer(
          fillColor: AppColors.White,
          backIcon: Assets.ic_close,
          onBackPress: () {
            Get.back();
          },
          margin: EdgeInsets.only(top: DeviceUtils.statusBarHeight()),
          title: AppStrings.select_staff_for_task.tr,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: SingleChildScrollView(
              child: Obx(() {
                return state.phongBans.value.isEmpty || state.staffs.value.isEmpty
                    ? const SkeletonLoadingView(
                        count: 10,
                      )
                    : Column(
                        children: [
                          ...state.phongBans.map((dep) {
                            return ExpansionTileItem(
                              border: Border.all(color: Colors.transparent),
                              title: Text(
                                dep.ten ?? '',
                                style: AppTextStyle.medium_14,
                              ),
                              children: [
                                Table(
                                  border: TableBorder.all(color: AppColors.GrayLight, width: 1),
                                  columnWidths: const {
                                    0: FlexColumnWidth(4),
                                    1: FlexColumnWidth(2),
                                    2: FlexColumnWidth(2),
                                  },
                                  children: [
                                    TableRow(
                                      decoration: BoxDecoration(color: AppColors.GrayLight.withOpacity(0.5)),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                                          child: Text(
                                            AppStrings.staff_label.tr,
                                            textAlign: TextAlign.center,
                                            style: AppTextStyle.medium_12,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                                          child: Text(
                                            AppStrings.staff_primary.tr,
                                            textAlign: TextAlign.center,
                                            style: AppTextStyle.medium_12,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                                          child: Text(
                                            AppStrings.staff_associate.tr,
                                            textAlign: TextAlign.center,
                                            style: AppTextStyle.medium_12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    for (Employee employee in (state.staffs["${dep.id}"] ?? []))
                                      TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(employee.ten ?? '', style: AppTextStyle.regular_12),
                                                Text(employee.chucvuTen ?? '',
                                                    style: AppTextStyle.regular_12.copyWith(color: AppColors.SecondaryText)),
                                              ],
                                            ),
                                          ),
                                          Radio<int>(
                                            value: 0,
                                            activeColor: AppColors.Primary,
                                            groupValue: employee.taskRole.value,
                                            onChanged: (int? value) {
                                              employee.taskRole.value = value ?? -1;
                                            },
                                          ),
                                          Radio<int>(
                                            value: 1,
                                            activeColor: AppColors.Primary,
                                            groupValue: employee.taskRole.value,
                                            onChanged: (int? value) {
                                              employee.taskRole.value = value ?? -1;
                                            },
                                          ),
                                        ],
                                      ),
                                  ],
                                )
                              ],
                            );
                          })
                        ],
                      );
              }),
            ),
          ),
        ),
        bottomNavigationBar: Obx(() {
          return Container(
            color: AppColors.White,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child:
                AppSolidButton(text: AppStrings.btn_new.tr, isDisable: state.phongBans.value.isEmpty || state.staffs.value.isEmpty, onPress: () {}),
          );
        }));
  }
}
