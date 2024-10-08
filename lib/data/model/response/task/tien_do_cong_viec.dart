class Tiendocongviec {
  String? displayText;
  num? tongcongviec;
  num? congviecdahoanthanh;
  num? tylehoanthanh;

  Tiendocongviec({
    this.displayText,
    this.tongcongviec,
    this.congviecdahoanthanh,
    this.tylehoanthanh,
  });

  factory Tiendocongviec.fromJson(Map<String, dynamic> json) {
    return Tiendocongviec(
      displayText: json['displayText'],
      tongcongviec: json['tongcongviec'],
      congviecdahoanthanh: json['congviecdahoanthanh'],
      tylehoanthanh: json['tylehoanthanh'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayText': displayText,
      'tongcongviec': tongcongviec,
      'congviecdahoanthanh': congviecdahoanthanh,
      'tylehoanthanh': tylehoanthanh,
    };
  }
}