import 'package:get/get.dart';
import 'package:mobile_rhm/data/model/common/opttion_model.dart';

import '../languages/keys.dart';

abstract class FinanceTask {
  static const QUANLY = 1; //Đang thực hiện
  static const KHONG_QUANLY = 0; //Đã hoàn thành

  static List<OptionModel> TASK_FILTER = [
    OptionModel(value: AppStrings.finance_manage.tr, key: '$QUANLY'),
    OptionModel(value: AppStrings.finance_not_manage.tr, key: '$KHONG_QUANLY'),
  ];
}
