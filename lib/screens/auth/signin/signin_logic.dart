import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_services/story/rhm_service.dart';
import 'package:mobile_rhm/app_widgets/meta/list/domain_list.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/utils/dialog_utils.dart';
import 'package:mobile_rhm/core/utils/helpers.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/core/utils/network_utils.dart';
import 'package:mobile_rhm/data/model/response/meta/domain.dart';
import 'package:mobile_rhm/routers/app_pages.dart';

import '../../../core/app/eviroment_config.dart';
import 'signin_state.dart';

class SigninLogic extends GetxController {
  final SigninState state = SigninState();
  final RHMService _rhmService = Get.find<RHMService>();

  TextEditingController phoneEditController = TextEditingController();
  TextEditingController passwordEditController = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    addTextListener();
    if (kDebugMode) {
      phoneEditController.text = EnvironmentConfigs.IS_SANDBOX ? 'adminqlcvtest' : 'userdemo';
      passwordEditController.text = EnvironmentConfigs.IS_SANDBOX ? 'adminqlcvtest@321' : '123456aA@';
    }
  }

  void onChangeHidePass() {
    state.isHidPass.value = !state.isHidPass.value;
  }

  void forgotPassword() {
    Get.toNamed(Routers.AUTH_FPASS_INPUT_EMAIL);
  }

  void onSignIn() async {
    bool isNetworkConnected = await NetworkUtils.isNetworkConnected();
    if (!isNetworkConnected) {
      DialogUtils.showSnackMessage(message: AppStrings.error_no_internet_connection.tr, title: AppStrings.error_title.tr);
      return;
    }
    if (state.selectDomain.value.url.isNullOrEmpty) {
      DialogUtils.showSnackMessage(message: AppStrings.error_common.tr, title: AppStrings.error_title.tr);
      return;
    }
    try {
      DialogUtils.showLoading();
      state.isSubmitForm.value = true;
      _rhmService.authenService.saveCurrentDomain(domain: state.selectDomain.value.url ?? '');
      await _rhmService.authenService.signIn(
          email: phoneEditController.text,
          password: passwordEditController.text,
          isRememberLogin: state.isRememberUser.value,
          onSuccess: () async {
            await _rhmService.metadataService.initData();
            DialogUtils.hideLoading();
            Get.offAllNamed(Routers.MAIN);
          },
          onError: (message) {
            DialogUtils.hideLoading();
            _rhmService.toastService.showToast(message: message, isSuccess: false, context: Get.context!);
          });
    } catch (e) {
      DialogUtils.hideLoading();
      LogUtils.log(e.toString());
      state.isSubmitForm.value = false;
    }
  }

  void addTextListener() {
    phoneEditController.addListener(() {
      state.phoneValue.value = phoneEditController.text;
      state.isFormValid.value = checkFormValid();
    });
    passwordEditController.addListener(() {
      state.passValue.value = passwordEditController.text;
      state.isFormValid.value = checkFormValid();
    });
  }

  bool checkFormValid() {
    LogUtils.logE(message: 'Call is FormValid');
    return CommonUtils.isValidString(param: state.passValue.value) &&
        CommonUtils.isValidString(param: state.phoneValue.value) &&
        state.selectDomain.value.url.isNotNullOrBlank;
  }

  Future<void> onSelectDomain() async {
    DialogUtils.showLoading();
    List<DomainModel> domains = await _rhmService.metadataService.getDomains();
    DialogUtils.hideLoading();
    if (domains.isEmpty) {
      return;
    }
    Widget bottomSheet = DomainListView(
      optionItems: domains,
      onSelect: (DomainModel domain) {
        LogUtils.logE(message: 'Selected domain');
        LogUtils.log(domain);
        if (domain.url != state.selectDomain.value.url) {
          state.selectDomain.value = domain;
          state.isFormValid.value = checkFormValid();
        }
      },
      selectedEthnic: state.selectDomain.value,
    );

    await Get.bottomSheet(bottomSheet, isScrollControlled: true);
  }

  void saveRemember(bool isCheck) {
    state.isRememberUser.value = isCheck;
  }
}
