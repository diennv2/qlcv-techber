class Danhgiabaocao {
  num? id;
  String? nguoidanhgia;
  String? noidungdanhgia;
  String? thoigiandanhgia;
  String? filedinhkem;

  Danhgiabaocao(
      {this.id,
        this.nguoidanhgia,
        this.noidungdanhgia,
        this.thoigiandanhgia,
        this.filedinhkem});

  Danhgiabaocao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nguoidanhgia = json['nguoidanhgia'];
    noidungdanhgia = json['noidungdanhgia'];
    thoigiandanhgia = json['thoigiandanhgia'];
    filedinhkem = json['filedinhkem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nguoidanhgia'] = this.nguoidanhgia;
    data['noidungdanhgia'] = this.noidungdanhgia;
    data['thoigiandanhgia'] = this.thoigiandanhgia;
    data['filedinhkem'] = this.filedinhkem;
    return data;
  }
}