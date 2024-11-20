import 'package:get/get.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:mobile_rhm/data/model/common/calendar_filter.dart';
import 'package:mobile_rhm/data/model/response/calendar/calendar.dart';
import 'package:mobile_rhm/data/model/response/calendar/events.dart';

class CalendarState {
  final RxList<CalendarEventData<CalendarTask>> events = <CalendarEventData<CalendarTask>>[].obs;
  Rx<CalendarTask> taskCalendarResponse = CalendarTask().obs;
  final Rx<DateTime> beginDate = DateTime.now().obs;
  final Rx<DateTime> endDate = DateTime.now().obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxString searchEventName = ''.obs;
  final RxList<EventFilters> eventFilters = <EventFilters>[].obs;
  RxList<CalendarFilter> calendarFilters = <CalendarFilter>[].obs;
  RxBool isScrollingDown = false.obs;
  RxBool isFabExpanded = true.obs;

  void setEventFilters(List<EventFilters> filters) {
    eventFilters.assignAll(filters);
  }

  void addEventFilter(EventFilters filter) {
    eventFilters.add(filter);
  }

  void removeEventFilter(EventFilter filter) {
    eventFilters.remove(filter);
  }

  void setEvents(List<CalendarEventData<CalendarTask>> newEvents) {
    events.assignAll(newEvents);
  }

  void setSearchEventName(String name) {
    searchEventName.value = name;
  }

  void addEvent(CalendarEventData<CalendarTask> event) {
    events.add(event);
  }

  void updateEvent(CalendarEventData<CalendarTask> updatedEvent) {
    final index = events.indexWhere((event) => event.event?.id == updatedEvent.event?.id);
    if (index != -1) {
      events[index] = updatedEvent;
    }
  }

  void removeEvent(CalendarEventData<CalendarTask> eventToRemove) {
    events.removeWhere((event) => event.event?.id == eventToRemove.event?.id);
  }

  void setBeginDate(DateTime date) {
    beginDate.value = date;
  }

  void setEndDate(DateTime date) {
    endDate.value = date;
  }

  void setLoading(bool loading) {
    isLoading.value = loading;
  }

  void setError(String errorMessage) {
    error.value = errorMessage;
  }
}