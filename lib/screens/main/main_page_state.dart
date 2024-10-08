import 'package:get/get.dart';
import 'package:mobile_rhm/core/constants/tabs.dart';

class MainPageState {
  RxInt currentPage = TabConst.TAB_HOME.obs;
  RxBool isScrollingDown = false.obs;
  RxBool isFabExpanded = true.obs;
  final double bottomBarHeight = 56.0; //Case we dont have other action like calendar 56.0 will be use if have calendar (Bottombar)

  MainPageState() {
    ///Initialize variables
  }
}
