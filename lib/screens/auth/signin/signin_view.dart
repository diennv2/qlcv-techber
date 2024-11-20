import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/button/app_solid_button.dart';
import 'package:mobile_rhm/app_widgets/checkbox/checkbox_view.dart';
import 'package:mobile_rhm/app_widgets/dropdown/dropdown.dart';
import 'package:mobile_rhm/app_widgets/edit_text.dart';
import 'package:mobile_rhm/app_widgets/hide_keyboard.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/app_widgets/text_button_view.dart';
import 'package:mobile_rhm/app_widgets/toast/toast_view.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/core/utils/validator/email_formater.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:mobile_rhm/core/values/dimens.dart';

import 'signin_logic.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SigninLogic>();
    final state = Get.find<SigninLogic>().state;
    return HideKeyBoard(
      child: Scaffold(
        backgroundColor: AppColors.White,
        body: ListView(padding: EdgeInsets.zero, children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              height: 250.h,
              alignment: Alignment.center,
              color: AppColors.Primary,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageDisplay(
                    Assets.bg_login,
                    height: 120.h,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  AutoSizeText(
                    AppStrings.welcome_app.tr,
                    style: AppTextStyle.semi_bold_20.copyWith(color: AppColors.White),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: AppColors.White,
            margin: EdgeInsets.all(Dimens.horizontal_padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (state.isChangePasswordSuccess)
                  Container(
                    margin: EdgeInsets.only(top: 16.h),
                    child: ToastView(
                      message: AppStrings.change_password_success_info.tr,
                      isSuccess: true,
                    ),
                  ),
                SizedBox(
                  height: 20.h,
                ),
                Obx(() {
                  return DropDownView(
                      label: AppStrings.domain_name.tr,
                      hint: AppStrings.domain_name_hint.tr,
                      required: true,
                      value: state.selectDomain.value.displayText,
                      onPress: () async {
                        await logic.onSelectDomain();
                      });
                }),
                SizedBox(
                  height: 20.h,
                ),
                EditTextView(
                  inputFormatter: EmailTextInputFormatter(),
                  isDisable: false,
                  required: true,
                  hintText: AppStrings.username_hint.tr,
                  label: AppStrings.username_label.tr,
                  isShowLabel: true,
                  controller: logic.phoneEditController,
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 16.h,
                ),
                Obx(() {
                  return EditTextView(
                    required: true,
                    hintText: AppStrings.password_hint.tr,
                    label: AppStrings.password_label.tr,
                    isShowLabel: true,
                    controller: logic.passwordEditController,
                    isPassword: true,
                    isHidePassword: state.isHidPass.value,
                    onChangeHidePass: () {
                      logic.onChangeHidePass();
                    },
                  );
                }),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CheckBoxView(
                        label: AppStrings.remember.tr,
                        onCheckChange: (key, isCheck) {
                          logic.saveRemember(isCheck);
                        },
                        initState: false,
                      ),
                    ),
                    // TextButtonView(
                    //   text: AppStrings.forgot_password.tr,
                    //   onClick: () {
                    //     logic.forgotPassword();
                    //   },
                    // )
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Obx(() {
                  LogUtils.logE(message: 'isDisable = ${!state.isFormValid.value}');
                  return AppSolidButton(
                      text: AppStrings.signin.tr,
                      isDisable: !state.isFormValid.value,
                      onPress: () {
                        logic.onSignIn();
                      });
                }),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
