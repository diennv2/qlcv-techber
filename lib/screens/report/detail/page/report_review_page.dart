import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/button/app_solid_button.dart';
import 'package:mobile_rhm/app_widgets/empty_view.dart';
import 'package:mobile_rhm/app_widgets/task/review_item_view.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:mobile_rhm/data/model/response/task/danh_gia_bao_cao.dart';

class ReviewReportPage extends StatelessWidget {
  final List<Danhgiabaocao>? reviews;
  final Function onAddNewReview;
  final bool hasPermissonAddReview;
  final Function onOpenAttach;

  const ReviewReportPage(
      {super.key, required this.reviews, required this.onAddNewReview, required this.hasPermissonAddReview, required this.onOpenAttach});

  @override
  Widget build(BuildContext context) {
    Widget body = (reviews == null || reviews?.isEmpty == true)
        ? const Center(child: EmptyView())
        : ListView(
            padding: EdgeInsets.zero,
            children: [
              ...reviews!.map((review) {
                return Container(
                    margin: EdgeInsets.only(bottom: 24.h),
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.Gray, width: 8))),
                    child: ReviewItemView(
                      review: review,
                      backgroundColor: Colors.white,
                      onOpenAttach: (file) {
                        onOpenAttach.call(file);
                      },
                    ));
              })
            ],
          );
    return Scaffold(
      body: body,
      backgroundColor: Colors.white,
      bottomNavigationBar: hasPermissonAddReview
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: AppSolidButton(
                text: AppStrings.add_review.tr,
                isDisable: false,
                onPress: () {
                  onAddNewReview.call();
                },
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
