import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/routers/app_pages.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../core/languages/keys.dart';
import '../core/values/colors.dart';

class HomeSearchView extends StatelessWidget {
  final Function onOpenDrawer;
  final bool hasTextSearch;
  final TextEditingController textEditingController;

  const HomeSearchView({super.key, required this.onOpenDrawer, required this.hasTextSearch, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(0.0, 1.0), //(x,y)
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            TouchableOpacity(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                child: Icon(
                  Icons.menu,
                  color: AppColors.CoolDark,
                ),
              ),
              onTap: () => onOpenDrawer.call(),
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
                child: TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 2, left: 4.w, right: 16.w),
                hintStyle: AppTextStyle.secondary12_2Regular,
                hintText: AppStrings.search_task_hint.tr,
                suffixIcon: hasTextSearch
                    ? TouchableOpacity(
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(Icons.clear),
                        ),
                        onTap: () {
                          textEditingController.clear();
                        },
                      )
                    : const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(Icons.search),
                      ),
                suffixIconConstraints: const BoxConstraints(
                  maxWidth: 24 + 16,
                  maxHeight: 24,
                ),
              ),
            )),
            TouchableOpacity(
              onTap: () {
                Get.toNamed(Routers.NOTIFICATION_LIST);
              },
              child: Container(
                child: Icon(Icons.notifications),
                padding: EdgeInsets.symmetric(horizontal: 8.w),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
