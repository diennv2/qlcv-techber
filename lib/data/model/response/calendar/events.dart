import 'package:get/get_rx/src/rx_types/rx_types.dart';

class EventFilters {
  final String label;
  final Rx<MapEntry<String, String>> selected;

  EventFilters({required this.label, required String key, required String value})
      : selected = MapEntry(key, value).obs;
}