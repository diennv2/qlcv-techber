import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/container/base_container.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/utils/device_utils.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/core/values/colors.dart';

import 'notification_detail_logic.dart';

class NotificationDetailPage extends StatelessWidget {
  NotificationDetailPage({Key? key}) : super(key: key);

  final logic = Get.find<NotificationDetailLogic>();
  final state = Get.find<NotificationDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    final String demoAns =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc volutpat pretium elit, quis sagittis sem condimentum eget. Vivamus ornare eget nisi eu sodales. Aenean sollicitudin lorem nisl, ac cursus erat pharetra nec. Nam id nunc urna. Cras nec nunc ut nibh auctor feugiat. Nulla semper at mi vel elementum.';
    return Scaffold(
      backgroundColor: AppColors.Primary,
      body: BaseContainer(
          backIcon: Assets.ic_close,
          onBackPress: () {
            Get.back();
          },
          margin: EdgeInsets.only(top: DeviceUtils.statusBarHeight()),
          title: AppStrings.notification_title.tr,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView(
              padding: EdgeInsets.only(bottom: 36.h),
              children: [
                Text(
                  'Thông báo về thay đổi lịch khám bệnh',
                  style: AppTextStyle.semi_bold_18,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  '1 ngày trước ',
                  style: AppTextStyle.regular_12.copyWith(color: AppColors.Teritary),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  demoAns + demoAns + demoAns + demoAns + demoAns,
                  style: AppTextStyle.regular_16,
                ),
              ],
            ),
          )),
    );
  }
}
