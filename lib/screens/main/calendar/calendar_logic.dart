import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:mobile_rhm/app_services/story/rhm_service.dart';
import 'package:mobile_rhm/data/model/common/calendar_filter.dart';
import '../../../core/constants/keys.dart';
import '../../../data/model/response/calendar/calendar.dart';
import '../../../data/model/response/calendar/calendar_task_response.dart';
import '../../../routers/app_pages.dart';
import 'calendar_state.dart';

class CalendarLogic extends GetxController {
  final CalendarState state = CalendarState();
  final EventController<CalendarTask> eventController = EventController<CalendarTask>();
  final TextEditingController searchEventNameController = TextEditingController();
  final RHMService _rhmService = Get.find<RHMService>();
  final ScrollController scrollController = ScrollController();
  final RxBool isStartDateSelected = false.obs;
  final RxBool isEndDateSelected = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeCurrentYear();
    fetchEvents();
    searchEventNameController.addListener(_onSearchChanged);
    addScrollListener();
  }

  void setStartDate(DateTime date) {
    state.beginDate.value = date;
  }

  void setEndDate(DateTime date) {
    state.endDate.value = date;
  }

  void checkAndFetchEvents() {
    print('Kiểm tra và lấy sự kiện: Start - ${isStartDateSelected.value}, End - ${isEndDateSelected.value}');
    if (isStartDateSelected.value && isEndDateSelected.value) {
      fetchEvents();
      // Reset trạng thái sau khi fetch
      isStartDateSelected.value = false;
      isEndDateSelected.value = false;
    }
  }
  void addScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!state.isScrollingDown.value) {
          state.isScrollingDown.value = true;
          state.isFabExpanded.value = false;
        }
      } else if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
        if (state.isScrollingDown.value) {
          state.isScrollingDown.value = false;
          state.isFabExpanded.value = true;
        }
      }
    });
  }
  @override
  void onClose() {
    searchEventNameController.removeListener(_onSearchChanged);
    searchEventNameController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void _onSearchChanged() {
    state.setSearchEventName(searchEventNameController.text);
  }

  Future<void> onDetailCalendarTask(CalendarTask event) async {
    await Get.toNamed(
      Routers.CALENDAR_DETAIL,
      arguments: {
        'id': event.id.toString(),
        'onDeleted': () async => await reloadEvents(),
      },
    );
  }

  Future<void> fetchEvents() async {
    state.setLoading(true);
    try {
      final String begin = state.beginDate.value.toIso8601String();
      final String end = state.endDate.value.toIso8601String();

      final List<CalendarTask>? fetchedTasks = await _rhmService.calendarService.getAllTaskCalendar(
        begin: begin,
        end: end,
      );

      if (fetchedTasks != null) {
        final List<CalendarEventData<CalendarTask>> fetchedEvents = fetchedTasks.map((task) =>
            CalendarEventData<CalendarTask>(
              date: task.start ?? DateTime.now(),
              event: task,
              title: task.title ?? "Công việc chưa đặt tên",
              description: task.title ?? "Không có mô tả",
              startTime: task.start ?? DateTime.now(),
              endTime: task.end ?? DateTime.now().add(Duration(hours: 1)),
            )
        ).toList();
        state.setEvents(fetchedEvents);
        _updateEventController();
        state.setError('');
      } else {
        state.setError('Không tìm thấy sự kiện nào');
      }
    } catch (e) {
      state.setError('Lỗi khi lấy sự kiện: $e');
    } finally {
      state.setLoading(false);
    }
  }

  void initializeCurrentYear() {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);
    final endOfYear = DateTime(now.year, 12, 31);
    state.setBeginDate(startOfYear);
    state.setEndDate(endOfYear);
    state.setSelectedYear(now.year);
    state.setSelectedMonth(now);
  }

  void setSelectedMonth(DateTime month) {
    state.setSelectedMonth(month);
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 0);
    state.setBeginDate(startOfMonth);
    state.setEndDate(endOfMonth);
  }

  void onDateRangeChanged(DateTime begin, DateTime end) {
    state.setBeginDate(begin);
    state.setEndDate(end);
    fetchEvents();
  }

  Future<void> addEvent(CalendarEventData<CalendarTask> event) async {
    state.setLoading(true);
    try {
      // TODO: Implement actual API call to add event
      await Future.delayed(Duration(seconds: 1)); // Simulating API call
      state.addEvent(event);
      _updateEventController();
      state.setError('');
    } catch (e) {
      state.setError('Error adding event: $e');
    } finally {
      state.setLoading(false);
    }
  }

  Future<void> updateEvent(CalendarEventData<CalendarTask> event) async {
    state.setLoading(true);
    try {
      // TODO: Implement actual API call to update event
      await Future.delayed(Duration(seconds: 1)); // Simulating API call
      state.updateEvent(event);
      _updateEventController();
      state.setError('');
    } catch (e) {
      state.setError('Error updating event: $e');
    } finally {
      state.setLoading(false);
    }
  }

  Future<void> deleteEvent(CalendarEventData<CalendarTask> event) async {
    state.setLoading(true);
    try {
      // TODO: Implement actual API call to delete event
      await Future.delayed(Duration(seconds: 1)); // Simulating API call
      state.removeEvent(event);
      _updateEventController();
      state.setError('');
    } catch (e) {
      state.setError('Error deleting event: $e');
    } finally {
      state.setLoading(false);
    }
  }

  void _updateEventController() {
    print('Cập nhật EventController với ${state.events.length} sự kiện');
    eventController.removeWhere((element) => true);
    eventController.addAll(state.events);
    print('Sau khi cập nhật, EventController có ${eventController.events.length} sự kiện');
  }

  Future<void> reloadEvents() async {
    await fetchEvents();
  }

  void showEventDetails(BuildContext context, CalendarEventData<CalendarTask> event) {
    // TODO: Implement event details dialog
  }

  void showAddEventDialog(BuildContext context, DateTime date) {
    // TODO: Implement add event dialog
  }

  void showEventDetailDialog(BuildContext context, CalendarTask event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(event.title ?? 'Chi tiết sự kiện'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Bắt đầu: ${event.start}'),
              Text('Kết thúc: ${event.end}'),
              Text('Mô tả: ${event.title ?? 'Không có mô tả'}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  void showFilter({required dynamic filter}) {
    // TODO: Implement filter logic
  }
  /// Lọc các sự kiện trong khoảng thời gian được chọn
  void fetchEventsInRange() {
    final DateTime startDate = state.beginDate.value;
    final DateTime endDate = state.endDate.value;

    // Lọc sự kiện trong khoảng thời gian
    final filteredEvents = state.events.where((event) {
      return event.date.isAfter(startDate.subtract(const Duration(days: 1))) &&
          event.date.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();

    // Cập nhật danh sách sự kiện đã lọc
    eventController.removeWhere((element) => true); // Xóa các sự kiện hiện tại
    eventController.addAll(filteredEvents); // Thêm các sự kiện đã lọc
    print('Đã lọc ${filteredEvents.length} sự kiện trong khoảng thời gian');
  }

  void deleteFilter() {
    // TODO: Implement delete filter logic
  }

  final RxBool isShowAllEvents = false.obs;
}