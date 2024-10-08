import 'nguoi_phoi_hop.dart';

class SubTaskListResponse {
  List<SubTaskDetail>? dataProvider;
  num? count;
  num? itemPerPage;
  String? currentPage;
  num? pages;

  SubTaskListResponse({this.dataProvider, this.count, this.itemPerPage, this.currentPage, this.pages});

  SubTaskListResponse.fromJson(Map<String, dynamic> json) {
    if (json['dataProvider'] != null) {
      dataProvider = <SubTaskDetail>[];
      json['dataProvider'].forEach((v) {
        dataProvider!.add(new SubTaskDetail.fromJson(v));
      });
    }
    count = json['count'];
    itemPerPage = json['itemPerPage'];
    currentPage = json['currentPage'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataProvider != null) {
      data['dataProvider'] = this.dataProvider!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    data['itemPerPage'] = this.itemPerPage;
    data['currentPage'] = this.currentPage;
    data['pages'] = this.pages;
    return data;
  }
}

class SubTaskDetail {
  num? id;
  String? tencongviec;
  String? motacongviec;
  num? nguoigiaoId;
  String? nguoigiaoName;
  num? soluongbaocao;
  num? status;
  String? statusText;
  String? ngaygiao;
  String? ngayhoanthanh;
  bool? isExpired;
  List<Nguoiphoihop>? nguoiphoihop;
  num? congviecchinhId;
  List<String>? filedinhkem;

  SubTaskDetail(
      {this.id,
      this.tencongviec,
      this.motacongviec,
      this.nguoigiaoId,
      this.nguoigiaoName,
      this.soluongbaocao,
      this.status,
      this.statusText,
      this.ngaygiao,
      this.ngayhoanthanh,
      this.isExpired,
      this.nguoiphoihop,
      this.congviecchinhId});

  SubTaskDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tencongviec = json['tencongviec'];
    motacongviec = json['motacongviec'];
    nguoigiaoId = json['nguoigiao_id'];
    nguoigiaoName = json['nguoigiao_name'];
    soluongbaocao = json['soluongbaocao'];
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
    data['soluongbaocao'] = this.soluongbaocao;
    data['status'] = this.status;
    data['statusText'] = this.statusText;
    data['ngaygiao'] = this.ngaygiao;
    data['ngayhoanthanh'] = this.ngayhoanthanh;
    data['isExpired'] = this.isExpired;
    if (this.nguoiphoihop != null) {
      data['nguoiphoihop'] = this.nguoiphoihop!.map((v) => v.toJson()).toList();
    }
    data['congviecchinh_id'] = this.congviecchinhId;
    data['filedinhkem'] = this.filedinhkem;
    return data;
  }
}
