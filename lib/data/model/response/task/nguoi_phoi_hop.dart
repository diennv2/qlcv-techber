class Nguoiphoihop {
  String? ten;
  num? id;

  Nguoiphoihop({this.ten, this.id});

  Nguoiphoihop.fromJson(Map<String, dynamic> json) {
    ten = json['ten'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ten'] = this.ten;
    data['id'] = this.id;
    return data;
  }
}