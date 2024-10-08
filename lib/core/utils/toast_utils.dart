import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/toast/toast_view.dart';
import 'package:mobile_rhm/core/utils/device_utils.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';

class ToastService extends GetxService {
  BuildContext? buildContext;
  final FToast fToast = FToast();

  init({required BuildContext context}) {
    buildContext = context;
  }

  void showToast({required String message, required bool isSuccess, required BuildContext context}) {
    LogUtils.logE(message: 'Show toast message = $message');
    fToast.init(context);
    Widget toast = ToastView(message: message, isSuccess: isSuccess);
    fToast.showToast(
        child: toast,
        gravity: ToastGravity.TOP,
        positionedToastBuilder: (context, child) {
          return Positioned(
            top: DeviceUtils.statusBarHeight(),
            left: 16.0,
            child: child,
          );
        },
        toastDuration: const Duration(seconds: 3),
        isDismissable: true);
  }
}
