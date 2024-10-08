import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class CheckBoxView extends StatelessWidget {
  final String label;
  final Function onCheckChange;
  final bool initState;
  RxBool isChecked = false.obs;

  CheckBoxView({Key? key, required this.label, required this.onCheckChange, required this.initState}) : super(key: key) {
    isChecked.value = initState;
  }

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        isChecked.value = !isChecked.value;
        onCheckChange(label, isChecked.value);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        child: Row(
          children: [
            Obx(() {
              return Image.asset(
                isChecked.value ? Assets.ic_checkbox_check : Assets.ic_checkbox_uncheck,
                width: 20.w,
              );
            }),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
                child: Text(
              label,
              style: AppTextStyle.primaryText,
            ))
          ],
        ),
      ),
    );
  }
}
