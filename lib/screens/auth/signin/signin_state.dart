import 'package:get/get.dart';
import 'package:mobile_rhm/core/constants/keys.dart';
import 'package:mobile_rhm/data/model/response/meta/domain.dart';

class SigninState {
  RxBool isValidPhone = true.obs;
  RxBool isValidPass = true.obs;
  RxBool isHidPass = true.obs;
  RxBool isFormValid = false.obs;
  RxString errorFormSignin = ''.obs;
  RxBool isSubmitForm = false.obs;
  RxString phoneValue = ''.obs;
  RxString passValue = ''.obs;
  Rx<DomainModel> selectDomain = DomainModel().obs;
  RxBool isRememberUser = false.obs;

  bool isChangePasswordSuccess = false;

  SigninState() {
    if (Get.arguments != null) {
      isChangePasswordSuccess = Get.arguments[AppExtraData.STATUS_CHANGE_PASSWORD] ?? false;
    }
  }
}
