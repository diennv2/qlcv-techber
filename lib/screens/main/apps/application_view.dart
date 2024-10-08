import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/item_app_view.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';

import 'application_logic.dart';

class ApplicationPage extends StatelessWidget {
  ApplicationPage({Key? key}) : super(key: key);

  final logic = Get.find<ApplicationLogic>();
  final state = Get.find<ApplicationLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      color: const Color.fromRGBO(244, 246, 250, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 72.h,
          ),
          Text(
            AppStrings.tab_application.tr,
            style: AppTextStyle.medium_32,
          ),
          Expanded(child: Obx(() {
            return state.applications.isEmpty
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : ListView(
                    padding: EdgeInsets.only(top: 24.h),
                    children: [
                      ...state.applications.map((app) {
                        return ItemAppView(
                            onClickItem: (app) {
                              logic.handleClickApp(app);
                            },
                            item: app);
                      })
                    ],
                  );
          })),
        ],
      ),
    );
  }
}
