import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/task/task_appbar_view.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/utils/device_utils.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:mobile_rhm/screens/report/detail/page/report_addition_info_page.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import 'page/report_information_page.dart';
import 'page/report_review_page.dart';
import 'report_detail_logic.dart';

class ReportDetailPage extends StatefulWidget {
  ReportDetailPage({super.key});

  @override
  State<ReportDetailPage> createState() => _ReportDetailPageState();
}

class _ReportDetailPageState extends State<ReportDetailPage> with TickerProviderStateMixin {
  final logic = Get.find<ReportDetailLogic>();
  final state = Get.find<ReportDetailLogic>().state;
  final ScrollController sc = ScrollController();
  late double pinnedHeaderHeight;
  late final TabController primaryTC;

  @override
  void initState() {
    super.initState();
    primaryTC = TabController(length: 3, vsync: this);
    final double statusBarHeight = DeviceUtils.statusBarHeight();
    pinnedHeaderHeight = statusBarHeight + kToolbarHeight;
  }

  @override
  void dispose() {
    primaryTC.dispose();
    sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExtendedNestedScrollView(
      controller: sc,
      headerSliverBuilder: (BuildContext c, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.White,
            elevation: 0,
            actions: state.hasPermissionDelete
                ? [
                    TouchableOpacity(
                      behavior: HitTestBehavior.translucent,
                      child: Container(padding: EdgeInsets.symmetric(horizontal: 16.w), child: const Icon(Icons.delete)),
                      onTap: () {
                        logic.deleteReport();
                      },
                    )
                  ]
                : null,
            expandedHeight: 240.0,
            scrolledUnderElevation: 0,
            title: innerBoxIsScrolled
                ? Text(
                    state.taskDetail.tencongviec ?? '',
                    style: AppTextStyle.body_text,
                  )
                : const Text(''),
            flexibleSpace: FlexibleSpaceBar(
              //centerTitle: true,
              collapseMode: CollapseMode.pin,
              background: Container(
                width: 1.0.sw,
                margin: EdgeInsets.only(top: pinnedHeaderHeight, left: 16.w, right: 16.w),
                color: Colors.white,
                child: TaskAppBarView(
                  isImportant: false,
                  name: state.taskDetail.tencongviec ?? '',
                  status: state.taskDetail.status ?? 0,
                  statusLabel: state.taskDetail.statusText ?? '',
                ),
              ),
            ),
          )
        ];
      },
      //1.[pinned sliver header issue](https://github.com/flutter/flutter/issues/22393)
      pinnedHeaderSliverHeightBuilder: () {
        return 80.h;
      },
      body: Scaffold(
        backgroundColor: AppColors.White,
        body: Column(
          children: [
            Container(
              color: AppColors.White,
              child: TabBar(
                controller: primaryTC,
                labelColor: AppColors.PrimaryText,
                indicatorColor: AppColors.Primary,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 2.0,
                isScrollable: false,
                unselectedLabelColor: AppColors.SecondaryText,
                tabs: <Tab>[
                  Tab(text: AppStrings.general_label.tr),
                  Tab(text: AppStrings.addition_report.tr),
                  Tab(text: AppStrings.review_label.tr),
                ],
              ),
            ),
            Expanded(
                child: TabBarView(
              controller: primaryTC,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Obx(() {
                  return ReportInformationPage(
                    report: state.report.value,
                    onOpenAttach: (link) {
                      logic.openAttach(link);
                    },
                    allowUpdateReport: state.hasPermissonEdit.value,
                    onUpdateReport: logic.updateReport,
                  );
                }),
                Obx(() {
                  return ReportAddtionalInfoPage(
                    reports: state.report.value.baocaochitietbosung,
                    onOpenAttach: (link) {
                      logic.openAttach(link);
                    },
                    onAddNewAdditionalReport: state.hasPermissionAddNewReport
                        ? () {
                            logic.addNewAddtionalReport();
                          }
                        : null,
                  );
                }),
                Obx(() {
                  return ReviewReportPage(
                    reviews: state.report.value.danhgiabaocao,
                    onAddNewReview: () {
                      logic.addNewReview();
                    },
                    hasPermissonAddReview: state.hasPermissionAddReview,
                    onOpenAttach: (file) {
                      logic.openAttach(file);
                    },
                  );
                })
              ],
            ))
          ],
        ),
      ),
    );
  }
}
