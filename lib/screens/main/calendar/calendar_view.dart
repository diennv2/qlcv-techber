import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:mobile_rhm/app_widgets/empty_view.dart';
import 'package:mobile_rhm/app_widgets/hide_keyboard.dart';
import 'package:mobile_rhm/app_widgets/home_search_view.dart';
import 'package:mobile_rhm/app_widgets/skeleton_loading.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../app_widgets/dropdown/filter_dropdown.dart';
import '../../../core/languages/keys.dart';
import 'calendar_logic.dart';
import 'calendar_state.dart';

class CalendarPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalKey;
  final CalendarLogic calendarLogic = Get.find<CalendarLogic>();
  final CalendarState state = Get.find<CalendarLogic>().state;

  CalendarPage({super.key, required this.globalKey});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.GrayLight,
      body: HideKeyBoard(
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return HomeSearchView(
                      onOpenDrawer: () {
                        widget.globalKey.currentState!.openDrawer();
                      },
                      hasTextSearch: widget.state.searchEventName.value.isNotEmpty,
                      textEditingController: widget.calendarLogic.searchEventNameController,
                    );
                  }),
                  SizedBox(
                    height: 16.h,
                  ),
                  SizedBox(
                    height: 40.h,
                    width: 1.0.sw,
                    child: Obx(() {
                      return ListView(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          Obx(() {
                            return TouchableOpacity(
                              child: Container(
                                margin: EdgeInsets.only(right: 8.w),
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.Border),
                                    color: widget.calendarLogic.isShowAllEvents.value ? AppColors.Primary.withOpacity(0.5) : AppColors.White),
                                alignment: Alignment.center,
                                child: Text(
                                  AppStrings.btn_delete_filter.tr,
                                  style: AppTextStyle.regular_12,
                                ),
                              ),
                              onTap: () {
                                widget.calendarLogic.deleteFilter();
                              },
                            );
                          }),
                          ...widget.state.eventFilters.map((filter) {
                            return FilterDropDownView(
                                countSelected: filter.selected.value.key.isNotEmpty,
                                onPress: () {
                                  widget.calendarLogic.showFilter(filter: filter);
                                },
                                label: filter.label ?? '');
                          })
                        ],
                      );
                    }),
                  ),
                  Expanded(child: Obx(() {
                    return widget.state.events.isEmpty
                        ? RefreshIndicator(
                      onRefresh: () async {
                        await widget.calendarLogic.reloadEvents();
                      },
                      child: ListView(
                        children: const [
                          SkeletonLoadingView(
                            count: 10,
                          ),
                        ],
                      ),
                    )
                        : RefreshIndicator(
                      onRefresh: () async {
                        await widget.calendarLogic.reloadEvents();
                      },
                      child: MonthView(
                        controller: widget.calendarLogic.eventController,
                        onEventTap: (events, date) {

                        },
                        onCellTap: (events, date) => widget.calendarLogic.showAddEventDialog(context, date),
                      ),
                    );
                  })),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => widget.calendarLogic.showAddEventDialog(context, DateTime.now()),
      ),
    );
  }
}