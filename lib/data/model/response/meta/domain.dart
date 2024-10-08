/// sort : 1
/// url : "https://qlcv.haiduong.gov.vn"
/// displayText : "SỞ THÔNG TIN VÀ TRUYỀN THÔNG HẢI DƯƠNG"

class DomainModel {
  DomainModel({
    num? sort,
    String? url,
    String? displayText,
  }) {
    _sort = sort;
    _url = url;
    _displayText = displayText;
  }

  DomainModel.fromJson(dynamic json) {
    _sort = json['sort'];
    _url = json['url'];
    _displayText = json['displayText'];
  }

  num? _sort;
  String? _url;
  String? _displayText;

  DomainModel copyWith({
    num? sort,
    String? url,
    String? displayText,
  }) =>
      DomainModel(
        sort: sort ?? _sort,
        url: url ?? _url,
        displayText: displayText ?? _displayText,
      );

  num? get sort => _sort;

  String? get url => _url;

  String? get displayText => _displayText;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sort'] = _sort;
    map['url'] = _url;
    map['displayText'] = _displayText;
    return map;
  }
}
