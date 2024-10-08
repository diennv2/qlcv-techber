import 'package:chatview/chatview.dart';

import 'commment_list.dart';

class ChatInfo {
  List<TaskComment>? comments;
  List<Message>? messages;
  ChatUser? currentUser;
  List<ChatUser>? otherUsers;

  ChatInfo({this.comments, this.messages, this.currentUser, this.otherUsers});
}
