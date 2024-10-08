class Deadline {
  bool? isExpiredWarning;
  String? displayText;
  String? textColor;
  String? endDate;

  Deadline({
    this.isExpiredWarning,
    this.displayText,
    this.textColor,
    this.endDate,
  });

  factory Deadline.fromJson(Map<String, dynamic> json) {
    return Deadline(
      isExpiredWarning: json['isExpiredWarning'],
      displayText: json['displayText'],
      textColor: json['textColor'],
      endDate: json['endDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isExpiredWarning': isExpiredWarning,
      'displayText': displayText,
      'textColor': textColor,
      'endDate': endDate,
    };
  }
}