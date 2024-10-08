import 'package:get/get.dart';
import 'package:mobile_rhm/data/model/response/task/employee.dart';
import 'package:mobile_rhm/data/model/response/task/phong_ban.dart';

class SelectEmployeeState {
  RxMap<String, List<Employee>> staffs = <String, List<Employee>>{}.obs;
  RxList<PhongBan> phongBans = <PhongBan>[].obs;

  SelectEmployeeState() {
    ///Initialize variables
  }
}
