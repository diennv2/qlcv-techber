// models/calendar_event.dart
import 'dart:ui';

class CalendarEvent {
  final String id;
  final String title;
  final DateTime start;
  final DateTime end;
  final Color backgroundColor;
  final Color textColor;
  final bool isMine;

  CalendarEvent({
    required this.id,
    required this.title,
    required this.start,
    required this.end,
    required this.backgroundColor,
    required this.textColor,
    required this.isMine,
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      id: json['id'],
      title: json['title'],
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
      backgroundColor: Color(int.parse(json['backgroundColor'])),
      textColor: Color(int.parse(json['textColor'])),
      isMine: json['ismine'],
    );
  }
}
