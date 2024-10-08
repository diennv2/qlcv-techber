import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/data/model/common/opttion_model.dart';

class GroupValueView extends StatelessWidget {
  final List<OptionModel> options;
  final Function onSelectOption;
  final bool isRadio;
  final String title;
  final GroupButtonController? controller;

  const GroupValueView(
      {super.key, required this.title, required this.options, required this.onSelectOption, required this.isRadio, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: AppTextStyle.medium_14,
        ),
        SizedBox(
          height: 8.h,
        ),
        GroupButton<OptionModel>(
          controller: controller,
          onSelected: (value, index, isSelected) {
            onSelectOption.call(value);
          },
          options: const GroupButtonOptions(
              direction: Axis.horizontal,
              mainGroupAlignment: MainGroupAlignment.start,
              crossGroupAlignment: CrossGroupAlignment.start,
              groupRunAlignment: GroupRunAlignment.start,
              spacing: 16),
          buttons: options,
          isRadio: isRadio,
          buttonBuilder: (selected, option, index) {
            String icon = selected ? Assets.ic_checkbox_on : Assets.ic_checkbox_off;
            if (isRadio) {
              icon = selected ? Assets.ic_radio_on : Assets.ic_radio_off;
            }
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              // width: 1.0.sw - 40.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ImageDisplay(
                        icon,
                        width: 20.w,
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Expanded(
                        child: Text(
                          option.value ?? '',
                          style: AppTextStyle.regular_14,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
