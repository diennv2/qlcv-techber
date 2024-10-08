import 'package:mobile_rhm/data/model/response/task/danh_gia_bao_cao.dart';

class Baocaochitietbosung {
  num? id;
  String? ngaybaocao;
  num? nguoibaocao;
  String? nguoibaocaoName;
  num? chitietcongviecId;
  String? noidungbaocao;
  String? ketquadatduoc;
  bool? isDadanhgia;
  List<Danhgiabaocao>? danhgiabaocao;
  String? thoigiandanhgia;
  String? filedinhkem;

  Baocaochitietbosung(
      {this.id,
        this.ngaybaocao,
        this.nguoibaocao,
        this.nguoibaocaoName,
        this.chitietcongviecId,
        this.noidungbaocao,
        this.ketquadatduoc,
        this.isDadanhgia,
        this.danhgiabaocao,
        this.thoigiandanhgia,
        this.filedinhkem});

  Baocaochitietbosung.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ngaybaocao = json['ngaybaocao'];
    nguoibaocao = json['nguoibaocao'];
    nguoibaocaoName = json['nguoibaocao_name'];
    chitietcongviecId = json['chitietcongviec_id'];
    noidungbaocao = json['noidungbaocao'];
    ketquadatduoc = json['ketquadatduoc'];
    isDadanhgia = json['isDadanhgia'];
    if (json['danhgiabaocao'] != null) {
      danhgiabaocao = [];
      json['danhgiabaocao'].forEach((v) {
        danhgiabaocao!.add(new Danhgiabaocao.fromJson(v));
      });
    }
    thoigiandanhgia = json['thoigiandanhgia'];
    filedinhkem = json['filedinhkem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ngaybaocao'] = this.ngaybaocao;
    data['nguoibaocao'] = this.nguoibaocao;
    data['nguoibaocao_name'] = this.nguoibaocaoName;
    data['chitietcongviec_id'] = this.chitietcongviecId;
    data['noidungbaocao'] = this.noidungbaocao;
    data['ketquadatduoc'] = this.ketquadatduoc;
    data['isDadanhgia'] = this.isDadanhgia;
    if (this.danhgiabaocao != null) {
      data['danhgiabaocao'] =
          this.danhgiabaocao!.map((v) => v.toJson()).toList();
    }
    data['thoigiandanhgia'] = this.thoigiandanhgia;
    data['filedinhkem'] = this.filedinhkem;
    return data;
  }
}