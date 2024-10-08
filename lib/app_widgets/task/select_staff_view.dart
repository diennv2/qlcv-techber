import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/data/model/response/task/employee.dart';
import 'package:mobile_rhm/data/model/response/task/phong_ban.dart';

import '../../core/languages/keys.dart';
import '../../core/values/colors.dart';
import '../skeleton_loading.dart';

class SelectStaffView extends StatelessWidget {
  final Map<String, List<Employee>> staffs;
  final List<PhongBan> phongBans;
  final Function onStaffChange;

  const SelectStaffView({super.key, required this.staffs, required this.phongBans, required this.onStaffChange});

  @override
  Widget build(BuildContext context) {
    return phongBans.isEmpty || staffs.isEmpty
        ? const SkeletonLoadingView(
            count: 3,
          )
        : Column(
            children: [
              ...phongBans.map((dep) {
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
                        for (Employee employee in (staffs["${dep.id}"] ?? []))
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
                                    Text(employee.chucvuTen ?? '', style: AppTextStyle.regular_12.copyWith(color: AppColors.SecondaryText)),
                                  ],
                                ),
                              ),
                              Radio<int>(
                                value: 0,
                                activeColor: AppColors.Primary,
                                groupValue: employee.taskRole.value,
                                onChanged: (int? value) {
                                  employee.taskRole.value = value ?? -1;
                                  onStaffChange.call(employee, dep);
                                },
                              ),
                              Radio<int>(
                                value: 1,
                                activeColor: AppColors.Primary,
                                groupValue: employee.taskRole.value,
                                onChanged: (int? value) {
                                  employee.taskRole.value = value ?? -1;
                                  onStaffChange.call(employee, dep);
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
  }
}
