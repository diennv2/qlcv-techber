import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/button/app_solid_button.dart';
import 'package:mobile_rhm/app_widgets/button/media_select_button.dart';
import 'package:mobile_rhm/app_widgets/edit_text.dart';
import 'package:mobile_rhm/app_widgets/hide_keyboard.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';

import 'review_new_logic.dart';

class ReviewNewPage extends StatelessWidget {
  ReviewNewPage({super.key});

  final logic = Get.find<ReviewNewLogic>();
  final state = Get.find<ReviewNewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return HideKeyBoard(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            state.taskDetail.tencongviec ?? '',
            style: AppTextStyle.body_text,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          children: [
            Obx(() {
              return EditTextView(
                textAlignVertical: TextAlignVertical.top,
                isDisable: false,
                hintText: AppStrings.review_label.tr,
                label: AppStrings.review_hint_text.tr,
                isShowLabel: true,
                controller: logic.reviewTextController,
                inputType: TextInputType.text,
                required: true,
                isForceMaxlines: true,
                maxLines: null,
                height: 120.h,
                errorMessage: state.errorReviewContent.value,
              );
            }),
            SizedBox(
              height: 20.h,
            ),
            Obx(() {
              return Wrap(
                children: [
                  ...state.attachFiles.value.map((file) {
                    return MediaSelectButton(
                        file: file,
                        buttonText: file.name,
                        onSelectMedia: () {},
                        clearMedia: (file) {
                          logic.clearFile(file);
                        });
                  }),
                  if (state.attachFiles.value.isEmpty)
                    MediaSelectButton(
                        buttonText: AppStrings.add_media.tr,
                        onSelectMedia: () {
                          logic.addFile();
                        },
                        clearMedia: (file) {}),
                  SizedBox(
                    width: 12.w,
                  ),
                ],
              );
            }),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: AppSolidButton(
            text: AppStrings.add_review.tr,
            isDisable: false,
            onPress: () {
              logic.onAddNewReview();
            },
          ),
        ),
      ),
    );
  }
}
