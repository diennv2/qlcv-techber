import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';

import '../../core/languages/keys.dart';

class MainBottomView extends StatelessWidget {
  final double height;
  final Function onTabChange;
  final int selectedPageIndex;

  const MainBottomView({super.key, required this.height, required this.onTabChange, required this.selectedPageIndex});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      transform: Matrix4.translationValues(0, height, 0),
      child: BottomNavigationBar(
        selectedLabelStyle: AppTextStyle.medium_12,
        unselectedLabelStyle: AppTextStyle.medium_12.copyWith(color: AppColors.SecondaryText),
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.Primary,
        elevation: 10,
        onTap: (index) {
          onTabChange.call(index);
        },
        currentIndex: selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.local_fire_department),
            label: AppStrings.tab_home.tr,
          ),
          // BottomNavigationBarItem(
          //   icon: const Icon(Icons.calendar_month),
          //   label: AppStrings.tab_calendar.tr,
          // ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.apps_sharp),
            label: AppStrings.tab_application.tr,
          ),
        ],
      ),
    );
  }
}
