import 'package:get/get.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:mobile_rhm/data/model/response/calendar/events.dart';

class CalendarState {
  final RxList<CalendarEventData> events = <CalendarEventData>[].obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxString searchEventName = ''.obs;
  final RxList<EventFilters> eventFilters = <EventFilters>[].obs;

  void setEventFilters(List<EventFilters> filters) {
    eventFilters.assignAll(filters);
  }

  void addEventFilter(EventFilters filter) {
    eventFilters.add(filter);
  }

  void removeEventFilter(EventFilter filter) {
    eventFilters.remove(filter);
  }
  void setEvents(List<CalendarEventData> newEvents) {
    events.assignAll(newEvents);
  }

  void setSearchEventName(String name) {
    searchEventName.value = name;
  }
  void addEvent(CalendarEventData event) {
    events.add(event);
  }

  void updateEvent(CalendarEventData updatedEvent) {
    final index = events.indexWhere((event) =>
    event.startTime == updatedEvent.startTime &&
        event.endTime == updatedEvent.endTime &&
        event.title == updatedEvent.title
    );
    if (index != -1) {
      events[index] = updatedEvent;
    }
  }

  void removeEvent(CalendarEventData eventToRemove) {
    events.removeWhere((event) =>
    event.startTime == eventToRemove.startTime &&
        event.endTime == eventToRemove.endTime &&
        event.title == eventToRemove.title
    );
  }

  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  void setLoading(bool loading) {
    isLoading.value = loading;
  }

  void setError(String errorMessage) {
    error.value = errorMessage;
  }
}