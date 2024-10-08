import 'package:get/get.dart';
import 'package:mobile_rhm/app_services/story/rhm_service.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';

import 'select_employee_state.dart';

class SelectEmployeeLogic extends GetxController {
  final SelectEmployeeState state = SelectEmployeeState();
  final RHMService _rhmService = Get.find<RHMService>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadData();
  }

  void loadData() async {
    _rhmService.metadataService.getPhongBan().then((value) {
      state.phongBans.value = value;
      LogUtils.logE(message: 'Get phong ban OK size = ${state.phongBans.length} ${state.phongBans.first.ten}');
      _rhmService.metadataService.getEmployeeAndDep(phongban_ids: state.phongBans.map((element) => "${element.id}").toList()).then((staff) {
        if (staff != null) {
          state.staffs.value = staff;
          LogUtils.logE(message: 'Get staffs  OK');
        }
      });
    });
  }
}
