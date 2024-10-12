class CoQuan {
  dynamic id;
  String? ten;

  CoQuan({
    this.id,
    this.ten,
  });

  factory CoQuan.fromJson(Map<String, dynamic> json) {
    return CoQuan(
      id: json['id'],
      ten: json['ten'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten': ten,
    };
  }
}
