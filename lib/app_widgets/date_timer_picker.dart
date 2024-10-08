import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/button/app_solid_button.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class DateTimePicker extends StatelessWidget {
  final Function onSelect;
  final DateTime? initDate;
  final String title;

  DateTimePicker({Key? key, required this.onSelect, this.initDate, required this.title}) : super(key: key);

  DateTime? selectDate;

  @override
  Widget build(BuildContext context) {
    DateTime date = initDate ?? DateTime.now();
    DateTime minDate = DateTime(DateTime.now().year - 1);
    DateTime maxDate = DateTime(DateTime.now().year + 5);
    selectDate = date;
    Widget datePick = CupertinoDatePicker(
      initialDateTime: date,
      minimumDate: minDate,
      maximumDate: maxDate,
      mode: CupertinoDatePickerMode.date,
      use24hFormat: true,
      // This shows day of week alongside day of month
      showDayOfWeek: false,
      // This is called when the user changes the date.
      onDateTimeChanged: (DateTime newDate) {
        // onSelect.call(newDate);
        LogUtils.logE(message: 'Date change');
        selectDate = newDate;
      },
      dateOrder: DatePickerDateOrder.dmy,
    );

    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(24.w), topRight: Radius.circular(24.w)), color: AppColors.White),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                ),
              ],
            ),
          ),
          SizedBox(height: 300.h, child: datePick),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: AppSolidButton(
                text: AppStrings.btn_ok.tr,
                isDisable: false,
                onPress: () {
                  Get.back();
                  if (selectDate != null) onSelect.call(selectDate);
                }),
          )
        ],
      ),
    );
  }
}
