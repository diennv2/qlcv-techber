import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/info_view.dart';
import 'package:mobile_rhm/app_widgets/loading_view.dart';
import 'package:mobile_rhm/app_widgets/modal_content_base.dart';
import 'package:mobile_rhm/app_widgets/warning_view.dart';
import 'package:mobile_rhm/core/values/colors.dart';

class DialogUtils {
  static void showSnackMessage({required String message, required String title}) {
    Get.snackbar(title, message, backgroundColor: AppColors.Primary, colorText: AppColors.White);
  }

  static void showInfoMessage({required String message, required String icon}) {
    Widget content = InfoView(message: message, icon: icon);
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            content: content,
            backgroundColor: Colors.transparent,
            elevation: 0,
          );
        },
        barrierDismissible: false,
        barrierColor: Colors.transparent);
    Future.delayed(const Duration(seconds: 3), () {
      Get.back();
    });
  }

  static Future<bool> showConfirmMessage({required String title, required String msg}) async {
    bool isConfirmed = false;
    await Get.bottomSheet(
        WarningView(
            title: title,
            descriptions: msg,
            onPositive: () {
              isConfirmed = true;
            }),
        barrierColor: Colors.transparent);
    return Future<bool>.value(isConfirmed);
  }

  static bool isLoading = false;

  static void showLoading({String? message}) {
    if (isLoading) {
      return;
    }
    isLoading = true;

    Widget content = LoadingView(message: message);
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              content: content,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          );
        },
        barrierDismissible: false,
        barrierColor: Colors.transparent);
  }

  static void hideLoading() {
    if (isLoading) {
      Get.back();
      isLoading = false;
    }
  }

  static void showCenterDialog({required Widget child, bool? barrierDismissible}) {
    Get.dialog(
        ModalContentBase(
          child: PopScope(
            canPop: barrierDismissible ?? false,
            child: child,
          ),
        ),
        barrierDismissible: barrierDismissible ?? false,
        barrierColor: AppColors.Black.withOpacity(0.4));
  }
}
