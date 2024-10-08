class Nguoinhanviec {
  num? id;
  String? ten;
  String? textColor;
  String? type;
  String? enumType;

  Nguoinhanviec({this.id, this.ten, this.textColor, this.type});

  Nguoinhanviec.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ten = json['ten'];
    textColor = json['textColor'];
    type = json['type'];
    enumType = json['enumType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ten'] = this.ten;
    data['textColor'] = this.textColor;
    data['type'] = this.type;
    data['enumType'] = this.enumType;
    return data;
  }
}