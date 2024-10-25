import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'calendar_state.dart';

class CalendarLogic extends GetxController {
  final CalendarState state = CalendarState();
  final EventController eventController = EventController();
  final TextEditingController searchEventNameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
    searchEventNameController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    searchEventNameController.removeListener(_onSearchChanged);
    searchEventNameController.dispose();
    super.onClose();
  }

  void _onSearchChanged() {
    state.setSearchEventName(searchEventNameController.text);
    // You might want to add logic here to filter events based on the search text
  }

  Future<void> fetchEvents() async {
    state.setLoading(true);
    try {
      // TODO: Implement actual API call to fetch events
      await Future.delayed(Duration(seconds: 1)); // Simulating API call
      final fetchedEvents = [
        CalendarEventData(
          date: DateTime.now(),
          title: "Sample Event",
          description: "This is a sample event",
          startTime: DateTime.now(),
          endTime: DateTime.now().add(Duration(hours: 2)),
        ),
      ];
      state.setEvents(fetchedEvents);
      _updateEventController();
      state.setError('');
    } catch (e) {
      state.setError('Error fetching events: $e');
    } finally {
      state.setLoading(false);
    }
  }

  Future<void> addEvent(CalendarEventData event) async {
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

  Future<void> updateEvent(CalendarEventData event) async {
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

  Future<void> deleteEvent(CalendarEventData event) async {
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
    eventController.removeWhere((element) => true);
    eventController.addAll(state.events);
  }

  Future<void> reloadEvents() async {
    await fetchEvents();
  }

  void showEventDetails(BuildContext context, CalendarEventData event) {
    // TODO: Implement event details dialog
  }

  void showAddEventDialog(BuildContext context, DateTime date) {
    // TODO: Implement add event dialog
  }

  void showFilter({required dynamic filter}) {
    // TODO: Implement filter logic
  }

  void deleteFilter() {
    // TODO: Implement delete filter logic
  }

  final RxBool isShowAllEvents = false.obs;
}