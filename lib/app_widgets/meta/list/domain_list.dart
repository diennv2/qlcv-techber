import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/app_widgets/meta/item_domain_view.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/utils/device_utils.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:mobile_rhm/data/model/response/meta/domain.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class DomainListView extends StatelessWidget {
  final ScrollController scrollController = ScrollController();
  final List<DomainModel> optionItems;
  final DomainModel? selectedEthnic;
  final Function onSelect;

  DomainListView({Key? key, required this.optionItems, required this.onSelect, this.selectedEthnic}) : super(key: key);

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
                  AppStrings.domain_name.tr,
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
                  return ItemDomainView(domainModel: option, onSelect: onSelect, isChecked: option.url == selectedEthnic?.url);
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
