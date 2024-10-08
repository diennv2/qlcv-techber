import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/button/app_solid_button.dart';
import 'package:mobile_rhm/app_widgets/task/report_item_view.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/data/model/response/task/bao_cao_cong_viec.dart';

class ReportInformationPage extends StatelessWidget {
  final Baocaocongviec report;
  final Function onOpenAttach;
  final Function onUpdateReport;
  final bool allowUpdateReport;

  const ReportInformationPage(
      {super.key, required this.report, required this.onOpenAttach, required this.allowUpdateReport, required this.onUpdateReport});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ReportItemView(
              backgroundColor: Colors.white,
              isShowFullReport: true,
              report: report,
              onAttachOpen: (link) {
                onOpenAttach(link);
              }),
        ],
      ),
      bottomNavigationBar: allowUpdateReport
          ? Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: AppSolidButton(
                  text: AppStrings.btn_update.tr,
                  isDisable: false,
                  onPress: () {
                    onUpdateReport.call();
                  }),
            )
          : const SizedBox.shrink(),
    );
  }
}
