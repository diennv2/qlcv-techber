class TypeOfWork {
  num? id;
  String? tenloai;

  TypeOfWork({this.id, this.tenloai});

  TypeOfWork.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenloai = json['tenloai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tenloai'] = this.tenloai;
    return data;
  }
}
