class PhongBan {
  dynamic id;
  String? ten;
  dynamic ord;

  PhongBan({
    this.id,
    this.ten,
    this.ord,
  });

  factory PhongBan.fromJson(Map<String, dynamic> json) {
    return PhongBan(
      id: json['id'],
      ten: json['ten'],
      ord: json['ord'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten': ten,
      'ord': ord,
    };
  }
}
