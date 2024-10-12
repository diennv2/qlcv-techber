abstract class PermissonList {
  static const String PHONG_BAN_INDEX = 'phongban/index'; //Xem danh sách phòng ban
  static const String LOAI_DUAN_INDEX = 'loaiduan/index'; //Xem danh sách loại công việc chính
  static const String ADMIN_INDEX = 'admin/index'; //Xem danh sách người dùng

  static const String DUAN_INDEX = 'duan/index'; //Xem danh sách công việc chính phụ trách / có liên quan / phối hợp
  static const String DUAN_CREATE = 'duan/create'; //Tạo công việc chính
  static const String DUAN_UPDATE = 'duan/update'; //Sửa công việc chính
  static const String DUAN_DELETE = 'duan/delete'; //Xóa công việc chính
  static const String DUAN_VIEW = 'duan/view'; //Xem chi tiết công việc chính
  static const String DUAN_XEM_TAT_CA = 'duan/xemtatca'; //Xem chi tiết công việc chính

  static const String KEHOACH_INDEX = 'duan/kehoach'; //Xem danh sách công việc chính phụ trách / có liên quan / phối hợp
  static const String KEHOACH_CREATE = 'duan/kehoachcreate'; //Tạo công việc chính

  static const String CONGVIEC_INDEX = 'congviec/index'; //Xem danh sách công việc chi tiết thuộc công việc chính
  static const String CONGVIEC_CREATE = 'congviec/create'; //Tạo công việc chi tiết
  static const String CONGVIEC_UPDATE = 'congviec/update'; //Sửa công việc chi tiết
  static const String CONGVIEC_DELETE = 'congviec/delete'; //Xóa công việc chi tiết
  static const String CONGVIEC_VIEW = 'congviec/view'; //Xem chi tiết công việc chi tiết
  static const String CONGVIEC_DELETE_FILE = 'congviec/deletefile'; //Xóa file đính kèm công việc chi tiết

  static const String BAOCAO_CONGVIEC_INDEX = 'baocaocongviec/index'; //Xem danh sách báo cáo công việc chi tiết
  static const String BAOCAO_CONGVIEC_CREATE = 'baocaocongviec/create'; //Tạo báo cáo công việc chi tiết
  static const String BAOCAO_CONGVIEC_UPDATE = 'baocaocongviec/update'; //Sửa báo cáo công việc chi tiết
  static const String BAOCAO_CONGVIEC_DELETE = 'baocaocongviec/delete'; //Xóa báo cáo công việc chi tiết

  static const String DANHGIA_BAOCAO_INDEX = 'danhgiabaocao/index'; //Xem danh sách đánh giá báo cáo công việc chi tiết
  static const String DANHGIA_BAOCAO_CREATE = 'danhgiabaocao/create'; //Đánh giá báo cáo công việc chi tiết

  static const String COQUAN_INDEX = 'coquan/index';
}
