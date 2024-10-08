import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:mobile_rhm/core/values/font_family.dart';

import 'bottom_tab_highlight.dart';

class ItemBottomTabView extends StatelessWidget {
  final int value;
  final bool isSelected;
  final Function onItemChange;
  final String icon;
  final String tabName;

  const ItemBottomTabView(
      {super.key, required this.value, required this.isSelected, required this.onItemChange, required this.icon, required this.tabName});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Column(
        children: [
          BottomTabHighlightView(
            isSelected: isSelected,
          ),
          SizedBox(
            height: 8.h,
          ),
          GestureDetector(
            onTap: () {
              if (!isSelected) {
                onItemChange(value);
              }
            },
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    icon,
                    width: 24.w,
                    color: isSelected ? AppColors.Primary : AppColors.TextGray,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    tabName,
                    style: TextStyle(
                        color: isSelected ? AppColors.Primary : AppColors.TextGray,
                        fontSize: 11.sp,
                        fontFamily: FontFamily.fontBold,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
