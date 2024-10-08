import 'package:mobile_rhm/data/model/response/task/lanh_dao.dart';
import 'package:mobile_rhm/data/model/response/task/phong_ban.dart';

import 'dead_line.dart';
import 'file_dinh_kem.dart';
import 'kho_khan_vuong_mac.dart';
import 'nguoi_nhan_viec.dart';
import 'tien_do_cong_viec.dart';

class TaskResponse {
  List<DataProvider>? dataProvider;
  num? count;
  num? itemPerPage;
  String? currentPage;
  num? pages;

  TaskResponse({this.dataProvider, this.count, this.itemPerPage, this.currentPage, this.pages});

  TaskResponse.fromJson(Map<String, dynamic> json) {
    if (json['dataProvider'] != null) {
      dataProvider = <DataProvider>[];
      json['dataProvider'].forEach((v) {
        dataProvider!.add(new DataProvider.fromJson(v));
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

class DataProvider {
  num? id;
  String? ten;
  String? mota;
  num? nguoiphutrachId;
  String? nguoiphutrachname;
  List<LanhDao>? lanhdaophutrachList;
  List<PhongBan>? phongbanphutrachList;
  num? loaiduanId;
  String? loaiduanName;
  Deadline? deadline;
  String? ngaybatdau;
  num? status;
  List<Nguoinhanviec>? nguoinhanviec;
  Tiendocongviec? tiendocongviec;
  List<FileDinhKem>? fileDinhKem;
  List<Khokhanvuongmac>? khokhanvuongmac;
  bool? hasNewNotice;
  num? newNoticeCount;

  DataProvider(
      {this.id,
      this.ten,
      this.mota,
      this.nguoiphutrachId,
      this.nguoiphutrachname,
      this.lanhdaophutrachList,
      this.phongbanphutrachList,
      this.loaiduanId,
      this.loaiduanName,
      this.deadline,
      this.ngaybatdau,
      this.status,
      this.nguoinhanviec,
      this.tiendocongviec,
      this.fileDinhKem,
      this.khokhanvuongmac,
      this.hasNewNotice,
      this.newNoticeCount});

  DataProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ten = json['ten'];
    mota = json['mota'];
    nguoiphutrachId = json['nguoiphutrach_id'];
    nguoiphutrachname = json['nguoiphutrachname'];
    if (json['lanhdaophutrach_list'] != null) {
      lanhdaophutrachList = <LanhDao>[];
      json['lanhdaophutrach_list'].forEach((v) {
        lanhdaophutrachList!.add(LanhDao.fromJson(v));
      });
    }
    if (json['phongbanphutrach_list'] != null) {
      phongbanphutrachList = <PhongBan>[];
      json['phongbanphutrach_list'].forEach((v) {
        phongbanphutrachList!.add(PhongBan.fromJson(v));
      });
    }
    loaiduanId = json['loaiduan_id'];
    loaiduanName = json['loaiduan_name'];
    deadline = json['deadline'] != null ? Deadline.fromJson(json['deadline']) : null;
    ngaybatdau = json['ngaybatdau'];
    status = json['status'];
    if (json['nguoinhanviec'] != null) {
      nguoinhanviec = <Nguoinhanviec>[];
      json['nguoinhanviec'].forEach((v) {
        nguoinhanviec!.add(Nguoinhanviec.fromJson(v));
      });
    }
    tiendocongviec = json['tiendocongviec'] != null ? Tiendocongviec.fromJson(json['tiendocongviec']) : null;
    if (json['fileDinhKem'] != null) {
      fileDinhKem = <FileDinhKem>[];
      json['fileDinhKem'].forEach((v) {
        fileDinhKem!.add(FileDinhKem.fromJson(v));
      });
    }
    if (json['khokhanvuongmac'] != null) {
      khokhanvuongmac = <Khokhanvuongmac>[];
      json['khokhanvuongmac'].forEach((v) {
        khokhanvuongmac!.add(Khokhanvuongmac.fromJson(v));
      });
    }
    hasNewNotice = json['hasNewNotice'];
    newNoticeCount = json['newNoticeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['ten'] = this.ten;
    data['mota'] = this.mota;
    data['nguoiphutrach_id'] = this.nguoiphutrachId;
    data['nguoiphutrachname'] = this.nguoiphutrachname;
    if (this.lanhdaophutrachList != null) {
      data['lanhdaophutrach_list'] = this.lanhdaophutrachList!.map((v) => v.toJson()).toList();
    }
    if (this.phongbanphutrachList != null) {
      data['phongbanphutrach_list'] = this.phongbanphutrachList!.map((v) => v.toJson()).toList();
    }
    data['loaiduan_id'] = this.loaiduanId;
    data['loaiduan_name'] = this.loaiduanName;
    if (this.deadline != null) {
      data['deadline'] = this.deadline!.toJson();
    }
    data['ngaybatdau'] = this.ngaybatdau;
    data['status'] = this.status;
    if (this.nguoinhanviec != null) {
      data['nguoinhanviec'] = this.nguoinhanviec!.map((v) => v.toJson()).toList();
    }
    if (this.tiendocongviec != null) {
      data['tiendocongviec'] = this.tiendocongviec!.toJson();
    }
    if (this.fileDinhKem != null) {
      data['fileDinhKem'] = this.fileDinhKem!.map((v) => v.toJson()).toList();
    }
    if (this.khokhanvuongmac != null) {
      data['khokhanvuongmac'] = this.khokhanvuongmac!.map((v) => v.toJson()).toList();
    }
    data['hasNewNotice'] = this.hasNewNotice;
    data['newNoticeCount'] = this.newNoticeCount;
    return data;
  }
}
