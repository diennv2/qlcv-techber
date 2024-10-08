class Khokhanvuongmac {
  String? noidung;
  dynamic nguoiviet;
  String? thoigian;
  // int? uid;

  Khokhanvuongmac({
    this.noidung,
    this.nguoiviet,
    this.thoigian,
    // this.uid,
  });

  factory Khokhanvuongmac.fromJson(Map<String, dynamic> json) {
    return Khokhanvuongmac(
      noidung: json['noidung'],
      nguoiviet: json['nguoiviet'],
      thoigian: json['thoigian'],
      // uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'noidung': noidung,
      'nguoiviet': nguoiviet,
      'thoigian': thoigian,
      // 'uid': uid,
    };
  }
}