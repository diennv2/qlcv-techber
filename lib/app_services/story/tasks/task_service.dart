import 'package:chatview/chatview.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_rhm/app_services/bus_service.dart';
import 'package:mobile_rhm/app_services/story/tasks/task_service_helper.dart';
import 'package:mobile_rhm/core/constants/task.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/data/model/response/task/chat_info.dart';
import 'package:mobile_rhm/data/model/response/task/commment_list.dart';
import 'package:mobile_rhm/data/model/response/task/sub_task_progress_response.dart';
import 'package:mobile_rhm/data/model/response/task/subtask_list_response.dart';
import 'package:mobile_rhm/data/model/response/task/task.dart';
import 'package:mobile_rhm/data/model/response/user/me/UserProfile.dart';

import '../../../data/repository_manager.dart';
import '../../../di/components/service_locator.dart';

class TaskService extends GetxService with TaskServiceHelper {
  final RepositoryManager _repositoryManager = getIt<RepositoryManager>();
  final EventBusService _eventBusService = Get.find<EventBusService>();

  @override
  Future<TasksResponse?> getTasksByFilter(
      {int? page, String? phongbanid, String? statusFilter, String? tenFilter, String? loaiduanFilter, String? nguoinhanviecFilter}) async {
    try {
      TasksResponse? res = await _repositoryManager.getTasksByFilter(
          page: page,
          phongbanid: phongbanid,
          statusFilter: statusFilter,
          tenFilter: tenFilter,
          loaiduanFilter: loaiduanFilter,
          nguoinhanviecFilter: nguoinhanviecFilter);
      return res;
    } catch (e) {
      LogUtils.logE(message: '#getTasksByFilter error cause ${e.toString()}');
    }
    return null;
  }

  @override
  Future<TasksResponse?> getPlansByFilter(
      {int? page, String? phongbanid, String? statusFilter, String? tenFilter, String? loaiduanFilter, String? nguoinhanviecFilter}) async {
    try {
      TasksResponse? res = await _repositoryManager.getPlansByFilter(
          page: page,
          phongbanid: phongbanid,
          statusFilter: statusFilter,
          tenFilter: tenFilter,
          loaiduanFilter: loaiduanFilter,
          nguoinhanviecFilter: nguoinhanviecFilter);
      return res;
    } catch (e) {
      LogUtils.logE(message: '#getPlansByFilter error cause ${e.toString()}');
    }
    return null;
  }

  @override
  Future<SubTaskListResponse?> getSubTaskList({required String congviec_id, String? statusFilter, String? tenFilter, int? page}) async {
    try {
      SubTaskListResponse? res =
          await _repositoryManager.getSubTaskList(congviec_id: congviec_id, statusFilter: statusFilter, tenFilter: tenFilter, page: page);
      return res;
    } catch (e) {
      LogUtils.logE(message: '#getSubTaskList error cause ${e.toString()}');
    }
    return null;
  }

  @override
  Future<List<SubTaskProgressResponse>?> getSubTasksProgress({required List<num> ids}) async {
    List<SubTaskProgressResponse> result = [];
    List<Future<SubTaskProgressResponse?>> tasks = [];
    for (num id in ids) {
      tasks.add(_repositoryManager.getSubTaskProgress(chitietcongviec_id: "$id"));
    }
    var res = await Future.wait(tasks);
    // Lọc bỏ các giá trị null và chuyển đổi danh sách
    result = res.whereType<SubTaskProgressResponse>().toList();
    return result;
  }

  @override
  Future<void> downloadAndopenFile({required String url}) {
    // TODO: implement downloadAndopenFile
    throw UnimplementedError();
  }

  @override
  Future createOrUpdateTask({required Dio.FormData data, required bool isCreateNew}) async {
    var res = await _repositoryManager.createOrUpdateTask(formData: data, isCreateNew: isCreateNew);
    if (res['status'] == true) {
      _eventBusService.fireEvent(event: EventNewTaskAdd());
    }
    return res;
  }

  @override
  Future createOrUpdateSubTask({required Dio.FormData data, required bool isCreateNew}) async {
    var res = await _repositoryManager.createOrUpdateSubTask(formData: data, isCreateNew: isCreateNew);
    if (res['status'] == true) {
      _eventBusService.fireEvent(event: EventUpdateTask());
    }
    return res;
  }

  @override
  Future deleteFileOfSubTask({required request}) async {
    var res = await _repositoryManager.deleteFileOfSubTask(request: request);
    if (res['status'] == true) {
      _eventBusService.fireEvent(event: EventUpdateTask());
    }
    return res;
  }

  ChatUser? _getCurrentUser() {
    UserProfile? userProfile = _repositoryManager.getUserProfile();
    if (userProfile != null) {
      LogUtils.logE(message: 'Current User finded ${userProfile.displayName}');
      return ChatUser(id: '${userProfile.userId}', name: "${userProfile.displayName}");
    }
    LogUtils.logE(message: 'get current user not found');
    return null;
  }

  List<ChatUser> _getOtherUsers({required List<TaskComment> comments}) {
    UserProfile? userProfile = _repositoryManager.getUserProfile();
    List<ChatUser> others = [];
    for (TaskComment comment in comments) {
      if (comment.nguoicommentId != userProfile?.userId) {
        ChatUser user = ChatUser(id: '${comment.nguoicommentId}', name: '${comment.nguoicommentName}');
        others.add(user);
      }
    }
    return others;
  }

  ReplyMessage? _createReplayMessage({required int id, required List<TaskComment> comments}) {
    TaskComment? findedComment;
    for (TaskComment comment in comments) {
      if (comment.id == id) {
        LogUtils.logE(message: 'Finded root message ${comment.id} - ${comment.comment}');
        findedComment = comment;
        break;
      }
    }

    if (findedComment != null) {
      return ReplyMessage(
          message: '${findedComment.comment}',
          messageId: '${findedComment.id}',
          replyTo: '${findedComment.replyToId}',
          replyBy: '${findedComment.nguoicommentId}');
    }
    return null;
  }

  List<Message> _getChatMessages({required List<TaskComment> comments}) {
    List<Message> messages = [];
    for (TaskComment comment in comments) {
      String? dateString = comment.ngaycomment;
      DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
      DateTime createDate = format.tryParse(dateString ?? '') ?? DateTime.now();
      String content = comment.comment == TaskCommentConst.REVERT_COMMENT ? AppStrings.revert_comment.tr : (comment.comment ?? '');
      if (comment.replyToId == null) {
        Message message = Message(
          id: '${comment.id}',
          message: content,
          createdAt: createDate,
          sentBy: "${comment.nguoicommentId}",
          status: MessageStatus.read,
        );
        messages.add(message);
      } else {
        var replyMesseage = _createReplayMessage(id: (comment.replyToId ?? 0).toInt(), comments: comments);

        if (replyMesseage != null) {
          Message message = Message(
              message: content,
              createdAt: createDate,
              sentBy: "${comment.nguoicommentId}",
              status: MessageStatus.read,
              replyMessage: replyMesseage,
              id: '${comment.id}');
          messages.add(message);
        } else {
          Message message = Message(
            id: '${comment.id}',
            message: comment.comment ?? '',
            createdAt: createDate,
            sentBy: "${comment.nguoicommentId}",
            status: MessageStatus.read,
          );
          messages.add(message);
        }
      }
    }
    return messages;
  }

  @override
  Future<ChatInfo?> getCommentData({required num taskId}) async {
    try {
      ChatUser? currentUser = _getCurrentUser();
      CommentListResponse? res = await _repositoryManager.getCommentList(congviec_id: taskId);
      if (res != null && res.status == true && res.messages != null && res.messages!.isNotEmpty) {
        List<TaskComment> taskComments = (res?.messages ?? []);

        List<ChatUser> otherUsers = _getOtherUsers(comments: taskComments);
        List<Message> messages = _getChatMessages(comments: taskComments);
        return ChatInfo(comments: taskComments, messages: messages, currentUser: currentUser, otherUsers: otherUsers);
      } else {
        return ChatInfo(currentUser: currentUser, messages: [], otherUsers: [], comments: []);
      }
    } catch (e) {
      LogUtils.logE(message: 'Try to get comment data false cause ${e.toString()}');
    }
    return null;
  }

  @override
  Future addComment({required num congviec_id, required num replyto, required String comment}) async {
    try {
      var res = await _repositoryManager.addComment(congviec_id: congviec_id, replyto: replyto, comment: comment);
      return res;
    } catch (e) {
      return null;
    }
  }

  @override
  Future unsentComment({required int congviec_id}) async {
    try {
      var res = await _repositoryManager.unsentComment(congviec_id: congviec_id);
      return res;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<SubTaskProgressResponse?> getSingleSubTaskProgress({required num id}) async {
    var res = _repositoryManager.getSubTaskProgress(chitietcongviec_id: "$id");
    return res;
  }

  @override
  Future addNewReview({required Dio.FormData data}) async {
    try {
      var res = await _repositoryManager.addNewReview(formData: data);
      if (res['status'] == true) {
        _eventBusService.fireEvent(event: EventUpdateSingleReport());
      }
      return res;
    } catch (e) {
      return null;
    }
  }

  @override
  Future createOrUpdateReport({required Dio.FormData data, required bool isCreateNew}) async {
    var res = await _repositoryManager.createOrUpdateReport(formData: data, isCreateNew: isCreateNew);
    if (res['status'] == true) {
      _eventBusService.fireEvent(event: EventUpdateTask());
      if (isCreateNew) {
        _eventBusService.fireEvent(event: EventNewReportAdd());
      } else {
        _eventBusService.fireEvent(event: EventUpdateReport());
      }
    }
    return res;
  }

  @override
  Future deleteReport({required Dio.FormData data}) async {
    var res = await _repositoryManager.deleteReport(formData: data);
    if (res['status'] == true) {
      _eventBusService.fireEvent(event: EventUpdateTask());
    }
    return res;
  }

  @override
  Future updateTaskStatus({required Dio.FormData formData}) async {
    var res = await _repositoryManager.updateTaskStatus(formData: formData);
    if (res['status'] == true) {
      _eventBusService.fireEvent(event: EventNewTaskAdd());
    }
    return res;
  }
}
