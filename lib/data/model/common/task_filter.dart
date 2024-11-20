import 'package:get/get.dart';
import 'package:mobile_rhm/core/constants/task.dart';
import 'package:mobile_rhm/data/model/common/opttion_model.dart';

class TaskFilter {
  String? permission;
  String? label;
  int type;
  Rx<OptionModel> selected = TaskStatus.DEFAULT_FILTER.obs;
  List<OptionModel>? options;

  TaskFilter({this.permission, this.label, this.options, required this.type});

  void onSelectOption({required OptionModel item}) {
    if (selected.value.key != item.key) {
      selected.value = item;
    }
  }
}

abstract class FilterType {
  static const int PHONG_BAN = 0;
  static const int STATUS = 1;
  static const int TEN_DU_AN = 2;
  static const int LOAI_DU_AN = 3;
  static const int NGUOI_NHAN_VIEC = 4;
}
