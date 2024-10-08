import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/model/common/bottom_tab_model.dart';
import 'item_bottom_bar_view.dart';

class BottomTabView extends StatelessWidget {
  final RxInt selectedIndex = 0.obs;
  final Function onTabChange;
  final List<BottomTabModel> tabItems;
  final int currentTabIndex;

  BottomTabView({super.key, required this.onTabChange, required this.tabItems, required this.currentTabIndex}) {
    selectedIndex.value = currentTabIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 1.0.sw,
      height: 72.h,
      child: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 8.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...tabItems.map((tabItem) {
                      return ItemBottomTabView(
                          value: tabItem.value,
                          isSelected: selectedIndex.value == tabItem.value,
                          onItemChange: (value) {
                            selectedIndex.value = value;
                            onTabChange(value);
                          },
                          icon: tabItem.icon,
                          tabName: tabItem.name);
                    })
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
