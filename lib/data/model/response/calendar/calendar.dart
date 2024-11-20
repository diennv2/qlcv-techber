import 'dart:ui';

class CalendarTask {
  num? id;
  String? title;
  DateTime? start;
  DateTime? end;
  Color? backgroundColor;
  Color? textColor;
  bool? isMine;

  CalendarTask({this.id, this.title});

  CalendarTask.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    start = json['start'] != null ? DateTime.parse(json['start']) : null;
    end = json['end'] != null ? DateTime.parse(json['end']) : null;
    backgroundColor = _parseColor(json['backgroundColor']);
    textColor = _parseColor(json['textColor']);
    isMine = json['ismine'];
  }

  static Color? _parseColor(String? colorString) {
    if (colorString == null) return null;
    colorString = colorString.replaceAll("#", "");
    try {
      if (colorString.length == 6) {
        return Color(int.parse("FF$colorString", radix: 16));
      } else if (colorString.length == 8) {
        return Color(int.parse(colorString, radix: 16));
      }
    } catch (e) {
      print('Error parsing color: $colorString');
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['start'] = this.start?.toIso8601String();
    data['end'] = this.end?.toIso8601String();
    data['backgroundColor'] = this.backgroundColor?.value.toRadixString(16).padLeft(8, '0');
    data['textColor'] = this.textColor?.value.toRadixString(16).padLeft(8, '0');
    data['isMine'] = this.isMine;
    return data;
  }
}