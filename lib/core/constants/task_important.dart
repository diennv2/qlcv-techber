import 'package:get/get.dart';
import 'package:mobile_rhm/data/model/common/opttion_model.dart';

import '../languages/keys.dart';

abstract class ImportantTask {
  static const IMPORTANT = 1; //Đang thực hiện
  static const NOT_IMPORTANT = 0; //Đã hoàn thành

  static List<OptionModel> TASK_FILTER = [
    OptionModel(value: AppStrings.task_important_filter.tr, key: '$IMPORTANT'),
    OptionModel(value: AppStrings.task_not_important_filter.tr, key: '$NOT_IMPORTANT'),
  ];
}
