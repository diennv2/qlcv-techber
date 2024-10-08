import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/button/app_solid_button.dart';
import 'package:mobile_rhm/app_widgets/empty_view.dart';
import 'package:mobile_rhm/app_widgets/task/report_item_view.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:mobile_rhm/data/model/response/task/bao_cao_chitiet_bosung.dart';
import 'package:mobile_rhm/data/model/response/task/bao_cao_cong_viec.dart';

class ReportAddtionalInfoPage extends StatelessWidget {
  final List<Baocaochitietbosung>? reports;
  final Function onOpenAttach;
  final Function? onAddNewAdditionalReport;

  const ReportAddtionalInfoPage({super.key, required this.reports, required this.onOpenAttach, this.onAddNewAdditionalReport});

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (reports == null || reports?.isEmpty == true) {
      body = const Center(child: EmptyView());
    } else {
      body = ListView(
        padding: EdgeInsets.zero,
        children: [
          ...reports!.map((report) {
            return Container(
              margin: EdgeInsets.only(bottom: 24.h),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.Gray, width: 8))),
              child: ReportItemView(
                  backgroundColor: Colors.white,
                  isShowFullReport: true,
                  report: Baocaocongviec(
                      id: report.id,
                      ngaybaocao: report.ngaybaocao,
                      nguoibaocaoName: report.nguoibaocaoName,
                      nguoibaocao: report.nguoibaocao,
                      chitietcongviecId: report.chitietcongviecId,
                      isDadanhgia: report.isDadanhgia,
                      thoigiandanhgia: report.thoigiandanhgia,
                      ketquadatduoc: report.ketquadatduoc,
                      noidungbaocao: report.noidungbaocao,
                      filedinhkem: report.filedinhkem),
                  onAttachOpen: (link) {
                    onOpenAttach(link);
                  }),
            );
          })
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: body,
      bottomNavigationBar: onAddNewAdditionalReport != null
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: AppSolidButton(
                text: AppStrings.add_report.tr,
                isDisable: false,
                onPress: () {
                  onAddNewAdditionalReport?.call();
                },
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
