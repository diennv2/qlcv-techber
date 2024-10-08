class LanhDao {
  num? id;
  String? ten;
  String? group;

  LanhDao({
    this.id,
    this.ten,
    this.group,
  });

  factory LanhDao.fromJson(Map<String, dynamic> json) {
    return LanhDao(
      id: json['id'],
      ten: json['ten'],
      group: json['group'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ten': ten,
      'group': group,
    };
  }
}