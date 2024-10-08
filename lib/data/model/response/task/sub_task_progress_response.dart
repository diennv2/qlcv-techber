import 'bao_cao_cong_viec.dart';
import 'nguoi_phoi_hop.dart';

class SubTaskProgressResponse {
  num? id;
  String? tencongviec;
  String? motacongviec;
  num? nguoigiaoId;
  String? nguoigiaoName;
  num? status;
  String? statusText;
  String? ngaygiao;
  String? ngayhoanthanh;
  bool? isExpired;
  List<Nguoiphoihop>? nguoiphoihop;
  num? congviecchinhId;
  num? soluongbaocao;
  List<Baocaocongviec>? baocaocongviec;
  List<String>? filedinhkem;

  SubTaskProgressResponse(
      {this.id,
      this.tencongviec,
      this.motacongviec,
      this.nguoigiaoId,
      this.nguoigiaoName,
      this.status,
      this.statusText,
      this.ngaygiao,
      this.ngayhoanthanh,
      this.isExpired,
      this.nguoiphoihop,
      this.congviecchinhId,
      this.soluongbaocao,
      this.baocaocongviec});

  SubTaskProgressResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tencongviec = json['tencongviec'];
    motacongviec = json['motacongviec'];
    nguoigiaoId = json['nguoigiao_id'];
    nguoigiaoName = json['nguoigiao_name'];
    status = json['status'];
    statusText = json['statusText'];
    ngaygiao = json['ngaygiao'];
    ngayhoanthanh = json['ngayhoanthanh'];
    isExpired = json['isExpired'];
    if (json['nguoiphoihop'] != null) {
      nguoiphoihop = <Nguoiphoihop>[];
      json['nguoiphoihop'].forEach((v) {
        nguoiphoihop!.add(new Nguoiphoihop.fromJson(v));
      });
    }
    congviecchinhId = json['congviecchinh_id'];
    soluongbaocao = json['soluongbaocao'];
    if (json['baocaocongviec'] != null) {
      baocaocongviec = <Baocaocongviec>[];
      json['baocaocongviec'].forEach((v) {
        baocaocongviec!.add(new Baocaocongviec.fromJson(v));
      });
    }
    if (json['filedinhkem'] != null) {
      filedinhkem = json['filedinhkem'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tencongviec'] = this.tencongviec;
    data['motacongviec'] = this.motacongviec;
    data['nguoigiao_id'] = this.nguoigiaoId;
    data['nguoigiao_name'] = this.nguoigiaoName;
    data['status'] = this.status;
    data['statusText'] = this.statusText;
    data['ngaygiao'] = this.ngaygiao;
    data['ngayhoanthanh'] = this.ngayhoanthanh;
    data['isExpired'] = this.isExpired;
    if (this.nguoiphoihop != null) {
      data['nguoiphoihop'] = this.nguoiphoihop!.map((v) => v.toJson()).toList();
    }
    data['congviecchinh_id'] = this.congviecchinhId;
    data['soluongbaocao'] = this.soluongbaocao;
    if (this.baocaocongviec != null) {
      data['baocaocongviec'] = this.baocaocongviec!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
