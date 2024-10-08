import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:mobile_rhm/data/model/response/meta/domain.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class ItemDomainView extends StatelessWidget {
  final DomainModel domainModel;
  final Function onSelect;
  final bool isChecked;

  const ItemDomainView({Key? key, required this.domainModel, required this.onSelect, required this.isChecked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        Get.back();
        onSelect(domainModel);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
        decoration: const BoxDecoration(color: AppColors.White, border: Border(bottom: BorderSide(color: AppColors.BorderPrimary, width: 1))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                domainModel.displayText ?? '',
                style: AppTextStyle.medium_16,
              ),
            ),
            if (isChecked)
              ImageDisplay(
                Assets.ic_check_circle,
                width: 20.w,
              )
          ],
        ),
      ),
    );
  }
}
