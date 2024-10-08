class NotificationResponse {
  num? id;
  String? time;
  num? sender;
  num? reciever;
  String? content;
  String? type;
  String? sendername;
  bool? issent;
  String? url;
  bool? isseen;

  NotificationResponse(
      {this.id, this.time, this.sender, this.reciever, this.content, this.type, this.sendername, this.issent, this.url, this.isseen});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    sender = json['sender'];
    reciever = json['reciever'];
    content = json['content'];
    type = json['type'];
    sendername = json['sendername'];
    issent = json['issent'];
    url = json['url'];
    isseen = json['isseen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time'] = this.time;
    data['sender'] = this.sender;
    data['reciever'] = this.reciever;
    data['content'] = this.content;
    data['type'] = this.type;
    data['sendername'] = this.sendername;
    data['issent'] = this.issent;
    data['url'] = this.url;
    data['isseen'] = this.isseen;
    return data;
  }
}
