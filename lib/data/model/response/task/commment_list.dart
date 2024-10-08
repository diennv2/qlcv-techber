class CommentListResponse {
  bool? status;
  List<TaskComment>? messages;

  CommentListResponse({this.status, this.messages});

  CommentListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['messages'] != null) {
      messages = <TaskComment>[];
      json['messages'].forEach((v) {
        messages!.add(new TaskComment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskComment {
  num? id;
  String? comment;
  num? nguoicommentId;
  String? nguoicommentName;
  String? ngaycomment;
  num? congviecId;
  num? replyToId;

  TaskComment(
      {this.id,
        this.comment,
        this.nguoicommentId,
        this.nguoicommentName,
        this.ngaycomment,
        this.congviecId,
        this.replyToId});

  TaskComment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    nguoicommentId = json['nguoicomment_id'];
    nguoicommentName = json['nguoicomment_name'];
    ngaycomment = json['ngaycomment'];
    congviecId = json['congviec_id'];
    replyToId = json['reply_to_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['nguoicomment_id'] = this.nguoicommentId;
    data['nguoicomment_name'] = this.nguoicommentName;
    data['ngaycomment'] = this.ngaycomment;
    data['congviec_id'] = this.congviecId;
    data['reply_to_id'] = this.replyToId;
    return data;
  }
}
