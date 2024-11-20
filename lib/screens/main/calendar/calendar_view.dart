import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:mobile_rhm/app_widgets/empty_view.dart';
import 'package:mobile_rhm/app_widgets/hide_keyboard.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:intl/intl.dart';

import '../../../data/model/response/calendar/calendar.dart';
import '../xet_duyet_lich/review_calendar_view.dart';
import 'calendar_logic.dart';
import 'calendar_state.dart';

class CalendarPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalKey;
  final CalendarLogic calendarLogic = Get.find<CalendarLogic>();
  final CalendarState state = Get.find<CalendarLogic>().state;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CalendarPage({Key? key, required this.globalKey}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
    widget.calendarLogic.fetchEvents();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? widget.state.beginDate.value : widget.state.endDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      if (isStartDate) {
        widget.calendarLogic.setStartDate(picked);
      } else {
        widget.calendarLogic.setEndDate(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.GrayLight,
      appBar: AppBar(
        title: Text('Lịch', style: AppTextStyle.bold_18),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              Get.to(() => ReviewCalendarPage(
                scrollController: widget.calendarLogic.scrollController,
                globalKey: widget.globalKey,
              ));
            },
          ),
        ],
      ),
      body: HideKeyBoard(
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  _buildDateRangePicker(),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: Obx(() {
                      print('Số lượng sự kiện: ${widget.state.events.length}');
                      return widget.state.events.isEmpty
                          ? _buildEmptyView()
                          : RefreshIndicator(
                        onRefresh: () async {
                          await widget.calendarLogic.reloadEvents();
                        },
                        child: MonthView(
                          controller: widget.calendarLogic.eventController,
                          onEventTap: (events, date) {
                            if (events is CalendarEventData<CalendarTask>) {
                              widget.calendarLogic.onDetailCalendarTask(events.event!);
                            } else {
                              print('Event is not of type CalendarEventData<CalendarTask>');
                            }
                          },
                          onCellTap: (events, date) => widget.calendarLogic.showAddEventDialog(context, date),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRangePicker() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => TouchableOpacity(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                decoration: BoxDecoration(
                  color: AppColors.White,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.Border),
                ),
                child: Text(
                  'Từ: ${DateFormat('dd/MM/yyyy').format(widget.state.beginDate.value)}',
                  style: AppTextStyle.regular_14,
                ),
              ),
              onTap: () => _selectDate(context, true),
            )),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Obx(() => TouchableOpacity(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                decoration: BoxDecoration(
                  color: AppColors.White,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.Border),
                ),
                child: Text(
                  'Đến: ${DateFormat('dd/MM/yyyy').format(widget.state.endDate.value)}',
                  style: AppTextStyle.regular_14,
                ),
              ),
              onTap: () => _selectDate(context, false),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView() {
    return RefreshIndicator(
      onRefresh: () async {
        await widget.calendarLogic.reloadEvents();
      },
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Center(
              child: Text(
                'Vui lòng chọn thời gian để xem công việc',
                style: AppTextStyle.regular_16.copyWith(color: AppColors.TextGray),
              ),
            ),
          ),
        ],
      ),
    );
  }
}