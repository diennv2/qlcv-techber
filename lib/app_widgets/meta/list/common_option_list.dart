import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/app_widgets/meta/item_commong_option_view.dart';
import 'package:mobile_rhm/app_widgets/meta/item_domain_view.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/utils/device_utils.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:mobile_rhm/data/model/common/opttion_model.dart';
import 'package:mobile_rhm/data/model/response/meta/domain.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class CommonOptionListView extends StatelessWidget {
  final ScrollController scrollController = ScrollController();
  final List<OptionModel> optionItems;
  final OptionModel? selected;
  final Function onSelect;
  final String title;

  CommonOptionListView({super.key, required this.optionItems, required this.onSelect, required this.title, this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: DeviceUtils.statusBarHeight()),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(24.w), topRight: Radius.circular(24.w)), color: AppColors.White),
      child: Column(
        children: [
          Container(
            height: 56.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Row(
              children: [
                TouchableOpacity(
                    onTap: () {
                      Get.back();
                    },
                    child: ImageDisplay(
                      Assets.ic_close,
                      width: 40.w,
                    )),
                Expanded(
                    child: Text(
                  title,
                  style: AppTextStyle.title,
                  textAlign: TextAlign.center,
                )),
                Container(
                  width: 40.w,
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              controller: scrollController,
              children: [
                ...optionItems.map((option) {
                  return ItemCommonOptionView(data: option, onSelect: onSelect, isChecked: option.key == selected?.key);
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
