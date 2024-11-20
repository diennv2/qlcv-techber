import 'package:get/get.dart';
import 'package:mobile_rhm/app_services/story/permisson/permisson_list.dart';
import 'package:mobile_rhm/core/constants/task.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/data/model/common/opttion_model.dart';
import 'package:mobile_rhm/data/model/common/task_filter.dart';
import 'package:mobile_rhm/data/model/response/calendar/calendar.dart';
import 'package:mobile_rhm/data/model/response/meta/domain.dart';
import 'package:mobile_rhm/data/model/response/task/co_quan.dart';
import 'package:mobile_rhm/data/model/response/task/employee.dart';
import 'package:mobile_rhm/data/model/response/task/lanh_dao.dart';
import 'package:mobile_rhm/data/model/response/task/phong_ban.dart';
import 'package:mobile_rhm/data/model/response/task/type_of_work.dart';
import 'package:mobile_rhm/data/model/response/user/me/UserProfile.dart';
import 'package:mobile_rhm/data/repository_manager.dart';
import 'package:mobile_rhm/di/components/service_locator.dart';

import '../../core/languages/keys.dart';
import 'metadata_service_helper.dart';

class MetadataService extends GetxService implements MetadataHelper {
  final RepositoryManager _repositoryManager = getIt<RepositoryManager>();
  List<DomainModel> domains = [];
  List<PhongBan> phongBans = [];
  List<LanhDao> lanhDaos = [];
  List<CoQuan> coQuans = [];
  List<TypeOfWork> typeOfWorks = [];
  List<TypeOfWork> typeOfWorksPlan = [];
  List<Employee> allEmployee = [];
  Map<String, List<Employee>> employeeByDepartment = {};
  List<TaskFilter> taskFilters = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDomains();
  }

  Future<void> initData() async {
    await Future.wait([getPhongBan(), getLoaiCongViec(), getLanhDao(), getEmployee(), getLoaiCongViecKeHoach()]);
    getTaskFilters();
  }

  @override
  Future<List<DomainModel>> getDomains() async {
    // Return early if we already have domains loaded.
    if (domains.isNotEmpty) {
      return domains;
    }
    // Attempt to fetch domains from remote source.
    List<DomainModel>? remoteDomains = await _repositoryManager.getDomainList();
    if (remoteDomains != null && remoteDomains.isNotEmpty) {
      // Save fetched domains and update the local cache.
      _repositoryManager.saveDomains(domains: remoteDomains);
      domains = List<DomainModel>.from(remoteDomains);
      return domains;
    }

    // If no remote domains, try to load from local cache.
    List<DomainModel>? localDomains = _repositoryManager.getLocalDomains();
    if (localDomains != null && localDomains.isNotEmpty) {
      domains = List<DomainModel>.from(localDomains);
      return domains;
    }

    // Return the possibly empty list of domains.
    return domains;
  }

  Future<List<TaskFilter>?> createTaskFilter({required Permission per}) async {
    switch (per.permission) {
      case PermissonList.PHONG_BAN_INDEX:
        await getPhongBan();
        var temp = phongBans.map((ite) => OptionModel(key: "${ite.id}", value: "${ite.ten}")).toList();
        temp.insert(0, TaskStatus.DEFAULT_FILTER);

        return [TaskFilter(label: AppStrings.phongban_label.tr, permission: per.permission, options: temp, type: FilterType.PHONG_BAN)];
      case PermissonList.LOAI_DUAN_INDEX:
        await getLoaiCongViec();
        var temp = typeOfWorks.map((ite) => OptionModel(key: "${ite.id}", value: "${ite.tenloai}")).toList();
        temp.insert(0, TaskStatus.DEFAULT_FILTER);

        return [TaskFilter(label: AppStrings.task_type_label.tr, permission: per.permission, options: temp, type: FilterType.LOAI_DU_AN)];

      case PermissonList.ADMIN_INDEX:
        await getEmployee();
        var temp = allEmployee.map((ite) => OptionModel(key: "${ite.id}", value: "${ite.ten}")).toList();
        temp.insert(0, TaskStatus.DEFAULT_FILTER);

        return [TaskFilter(label: AppStrings.phutrach_label.tr, permission: per.permission, options: temp, type: FilterType.NGUOI_PHU_TRACH)];
    }
    return null;
  }

  @override
  Future<List<TaskFilter>> getTaskFilters() async {
    if (taskFilters.isEmpty) {
      taskFilters.clear();
      UserProfile? userProfile = _repositoryManager.getUserProfile();
      if (userProfile != null) {
        List<Permission> finalList = (userProfile.permission ?? []);
        finalList = finalList.toSet().toList();
        for (Permission per in finalList) {
          LogUtils.logE(message: 'Loop permission ${per.permission}');
          List<TaskFilter>? items = await createTaskFilter(per: per);
          if (items != null) {
            taskFilters.addAll(items);
          }
        }
      }
      //TODO: Add default filter status
      TaskFilter statusTaskFilter = TaskFilter(label: AppStrings.status_label.tr, options: TaskStatus.TASK_FILTER, type: FilterType.STATUS);
      taskFilters.insert(0, statusTaskFilter);
    }

    return taskFilters;
  }

  @override
  List<OptionModel> getTaskStatus() {
    return TaskStatus.TASK_FILTER;
  }

  @override
  Future<List<PhongBan>> getPhongBan() async {
    if (phongBans.isEmpty) {
      try {
        var res = await _repositoryManager.getPhongBan();
        if (res != null) {
          phongBans.clear();
          phongBans.addAll(res);
        }
      } catch (e) {
        LogUtils.logE(message: 'getPhongBan ${e.toString()}');
      }
    }
    return phongBans;
  }

  @override
  Future<List<Employee>?> getEmployee() async {
    if (allEmployee.isEmpty) {
      try {
        var res = await _repositoryManager.getEmployee();
        if (res != null) {
          allEmployee.clear();
          allEmployee.addAll(res);
        }
      } catch (e) {
        LogUtils.logE(message: 'getEmployee ${e.toString()}');
      }
    }
    return allEmployee;
  }

  @override
  Future<List<Employee>> getEmployeeByDepartment({required String phongban_id}) async {
    bool hasData = employeeByDepartment.containsKey(phongban_id);
    LogUtils.logE(message: 'Has data = $hasData');
    if (!hasData) {
      try {
        var res = await _repositoryManager.getEmployeeByDepartment(phongban_id: phongban_id);
        if (res != null) {
          employeeByDepartment[phongban_id] = res;
        }
      } catch (e) {
        LogUtils.logE(message: 'getEmployeeByDepartment ${e.toString()}');
      }
    }
    return employeeByDepartment[phongban_id] ?? [];
  }

  @override
  Future<List<LanhDao>?> getLanhDao() async {
    if (lanhDaos.isEmpty) {
      try {
        var res = await _repositoryManager.getLanhDao();
        if (res != null) {
          lanhDaos.clear();
          lanhDaos.addAll(res);
        }
      } catch (e) {
        LogUtils.logE(message: 'getLanhDao ${e.toString()}');
      }
    }
    return lanhDaos;
  }

  @override
  Future<List<TypeOfWork>?> getLoaiCongViec() async {
    if (typeOfWorks.isEmpty) {
      try {
        var res = await _repositoryManager.getLoaiCongViec();
        if (res != null) {
          typeOfWorks.clear();
          typeOfWorks.addAll(res);
        }
      } catch (e) {
        LogUtils.logE(message: 'getLanhDao ${e.toString()}');
      }
    }
    return typeOfWorks;
  }

  @override
  Future<List<TypeOfWork>?> getLoaiCongViecKeHoach() async {
    if (typeOfWorksPlan.isEmpty) {
      try {
        var res = await _repositoryManager.getLoaiCongViecKeHoach();
        if (res != null) {
          typeOfWorksPlan.clear();
          typeOfWorksPlan.addAll(res);
        }
      } catch (e) {
        LogUtils.logE(message: 'getLanhDao ${e.toString()}');
      }
    }
    return typeOfWorksPlan;
  }

  @override
  void logout() {
    phongBans.clear();
    lanhDaos.clear();
    typeOfWorks.clear();
    allEmployee.clear();
    employeeByDepartment.clear();
    taskFilters.clear();
  }

  @override
  Future<Map<String, List<Employee>>?> getEmployeeAndDep({required List<String> phongban_ids}) async {
    try {
      Map<String, List<Employee>> res = <String, List<Employee>>{};
      List<Future> tasks = [];
      for (var id in phongban_ids) {
        tasks.add(getEmployeeByDepartment(phongban_id: id));
      }
      LogUtils.logE(message: 'Step#');
      var allEmployees = await Future.wait(tasks);
      LogUtils.logE(message: 'Step allEmployees length = ${allEmployees.length}');
      for (List<Employee> emp in allEmployees) {
        for (Employee item in emp) {
          item.taskRole.value = -1;
          item.isSelect = false;
        }
      }
      if (allEmployees.length == phongban_ids.length) {
        for (int i = 0; i < allEmployees.length; i++) {
          res[phongban_ids[i]] = allEmployees[i];
        }
        LogUtils.logE(message: 'Return data');
        return res;
      }
    } catch (e) {
      LogUtils.logE(message: 'getEmployeeAndDep error cause ${e.toString()} ');
    }
    return null;
  }

  @override
  Future<List<CoQuan>?> getCoQuan() async {
    if (coQuans.isEmpty) {
      try {
        var res = await _repositoryManager.getCoQuan();
        if (res != null) {
          coQuans.clear();
          coQuans.addAll(res);
        }
      } catch (e) {
        LogUtils.logE(message: 'getCoQuan ${e.toString()}');
      }
    }
    return coQuans;
  }

  @override
  bool hasPermission({required List<Permission> permission, required String checkPermisson}) {
    for (Permission per in permission) {
      if (per.permission?.toLowerCase() == checkPermisson.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

}
