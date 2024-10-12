import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'application_state.dart';

class ApplicationLogic extends GetxController {
  final ApplicationState state = ApplicationState();
  static const MethodChannel _channel = MethodChannel('com.techber.qlcv/channel');

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _loadApplications();
  }

  _loadApplications() async {
    String appStr = await rootBundle.loadString(Assets.app_json);
    var jsonApps = jsonDecode(appStr);
    for (var item in jsonApps) {
      state.applications.add(item);
    }
    state.applications.refresh();
  }

  void handleClickApp(app) async {
    if (Platform.isAndroid) {
      try {
        if (app['android']['schema'] != null && app['android']['schema'] != '') {
          LogUtils.logE(message: 'Open APP ${app['name']} with schema uis ${app['android']['schema']}');
          bool isSuccess = await launchUrl(Uri.parse(app['android']['schema']));
          if (!isSuccess) {
            launchUrl(Uri.parse(app['android']['storeLink']));
          }
        } else {
          var res = await _channel.invokeMethod('openApp', {'package': app['android']['applicationId'], 'class': app['android']['mainClass']});
          if (res != true) {
            launchUrl(Uri.parse(app['android']['storeLink']));
          }
        }
      } catch (e) {
        launchUrl(Uri.parse(app['android']['storeLink']));
      }
    } else {
      try {
        if (app['ios']['schema'] != null && app['ios']['schema'] != '') {
          bool isSuccess = await launchUrl(Uri.parse(app['ios']['schema']));
          if (isSuccess != true) {
            launchUrl(Uri.parse(app['ios']['storeLink']));
          }
        } else {
          launchUrl(Uri.parse(app['ios']['storeLink']));
        }
      } catch (e) {
        launchUrl(Uri.parse(app['ios']['storeLink']));
      }
    }
  }
}
