import 'package:get/get.dart';
import 'package:mobile_rhm/app_services/story/rhm_service.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/utils/dialog_utils.dart';
import 'package:mobile_rhm/routers/app_pages.dart';

import 'splash_state.dart';

class SplashLogic extends GetxController {
  final SplashState state = SplashState();
  final RHMService _rhmService = Get.find<RHMService>();

  @override
  void onReady() {
    super.onReady();
    _loadData();
    Future.delayed(const Duration(seconds: 3), () {
      handleNextScreen();
    });
  }

  void _loadData() {
    String? authenToken = _rhmService.authenService.authToken();
    if (authenToken.isNotNullOrBlank) {
      _rhmService.metadataService.initData();
    }
  }

  void handleNextScreen() async {
    String? authenToken = _rhmService.authenService.authToken();
    if (authenToken.isNotNullOrBlank) {
      Get.offAllNamed(Routers.MAIN);
    } else {
      Get.offAllNamed(Routers.AUTH_LOGIN);
    }
  }
}
