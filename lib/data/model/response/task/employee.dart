import 'package:get/get.dart';

class Employee {
  num? id;
  String? username;
  String? ten;
  String? email;
  String? status;
  num? phongbanId;
  String? phongbanTen;
  num? chucvuId;
  String? chucvuTen;
  num? nguoiquanlyId;
  String? nguoiquanlyTen;
  RxInt taskRole = (-1).obs;
  bool isSelect = false;

  Employee(
      {this.id,
      this.username,
      this.ten,
      this.email,
      this.status,
      this.phongbanId,
      this.phongbanTen,
      this.chucvuId,
      this.chucvuTen,
      this.nguoiquanlyId,
      this.nguoiquanlyTen});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    ten = json['ten'];
    email = json['email'];
    status = json['status'];
    phongbanId = json['phongban_id'];
    phongbanTen = json['phongban_ten'];
    chucvuId = json['chucvu_id'];
    chucvuTen = json['chucvu_ten'];
    nguoiquanlyId = json['nguoiquanly_id'];
    nguoiquanlyTen = json['nguoiquanly_ten'];
    isSelect = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['ten'] = this.ten;
    data['email'] = this.email;
    data['status'] = this.status;
    data['phongban_id'] = this.phongbanId;
    data['phongban_ten'] = this.phongbanTen;
    data['chucvu_id'] = this.chucvuId;
    data['chucvu_ten'] = this.chucvuTen;
    data['nguoiquanly_id'] = this.nguoiquanlyId;
    data['nguoiquanly_ten'] = this.nguoiquanlyTen;
    return data;
  }
}
