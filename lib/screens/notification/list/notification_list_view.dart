import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/empty_view.dart';
import 'package:mobile_rhm/app_widgets/notification/item_notification_view.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/utils/datetime_utils.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/core/values/colors.dart';

import 'notification_list_logic.dart';

class NotificationListPage extends StatelessWidget {
  NotificationListPage({super.key});

  final logic = Get.find<NotificationListLogic>();
  final state = Get.find<NotificationListLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.White,
      appBar: AppBar(
        title: Text(
          AppStrings.notification_title.tr,
          style: AppTextStyle.body_text,
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        child: Obx(() {
          if (state.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.Primary,
              ),
            );
          }
          if (state.notifications.value.isEmpty) {
            return Center(
                child: EmptyView(
              icon: Assets.ic_empty_notification,
              text: AppStrings.empty_notification.tr,
            ));
          }
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              ...state.notifications.value.map((item) {
                return ItemNotificationView(
                    title: item.type ?? '',
                    content: item.content ?? '',
                    isRead: true,
                    timeAgo: DateTimeUtils.timeDifference(item.time ?? ''),
                    onDetail: () {
                      logic.onDetail(item);
                    });
              })
            ],
          );
        }),
      ),
    );
  }
}
