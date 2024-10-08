import 'package:mobile_rhm/data/model/common/task_filter.dart';
import 'package:mobile_rhm/data/model/response/meta/domain.dart';
import 'package:mobile_rhm/data/model/response/task/phong_ban.dart';
import 'package:mobile_rhm/data/model/response/user/me/UserProfile.dart';

import '../../data/model/common/opttion_model.dart';
import '../../data/model/response/task/employee.dart';
import '../../data/model/response/task/lanh_dao.dart';
import '../../data/model/response/task/type_of_work.dart';

abstract class MetadataHelper {
  Future<List<DomainModel>> getDomains();

  Future<List<TaskFilter>> getTaskFilters();

  List<OptionModel> getTaskStatus();

  Future<List<PhongBan>> getPhongBan();

  Future<List<LanhDao>?> getLanhDao();

  Future<List<TypeOfWork>?> getLoaiCongViec();

  Future<List<Employee>?> getEmployee();

  Future<List<Employee>> getEmployeeByDepartment({required String phongban_id});

  Future<Map<String,List<Employee>>?> getEmployeeAndDep({required List<String> phongban_ids});

  void logout();

  bool hasPermission({required List<Permission> permission, required String checkPermisson});

}
