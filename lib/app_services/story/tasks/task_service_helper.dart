import 'package:dio/dio.dart';
import 'package:mobile_rhm/data/model/response/task/chat_info.dart';

import '../../../data/model/response/task/sub_task_progress_response.dart';
import '../../../data/model/response/task/subtask_list_response.dart';
import '../../../data/model/response/task/task.dart';

abstract class TaskServiceHelper {
  Future<TasksResponse?> getTasksByFilter(
      {int? page, String? phongbanid, String? statusFilter, String? tenFilter, String? loaiduanFilter, String? nguoinhanviecFilter});

  Future<TasksResponse?> getPlansByFilter(
      {int? page, String? phongbanid, String? statusFilter, String? tenFilter, String? loaiduanFilter, String? nguoinhanviecFilter});

  Future<SubTaskListResponse?> getSubTaskList({required String congviec_id, String? statusFilter, String? tenFilter, int? page});

  Future<List<SubTaskProgressResponse>?> getSubTasksProgress({required List<num> ids});

  Future<void> downloadAndopenFile({required String url});

  Future createOrUpdateTask({required FormData data, required bool isCreateNew});

  Future createOrUpdateSubTask({required FormData data, required bool isCreateNew});

  Future deleteFileOfSubTask({required dynamic request});

  Future<ChatInfo?> getCommentData({required num taskId});

  Future addComment({required num congviec_id, required num replyto, required String comment});

  Future unsentComment({required int congviec_id});

  Future<SubTaskProgressResponse?> getSingleSubTaskProgress({required num id});

  Future addNewReview({required FormData data});

  Future createOrUpdateReport({required FormData data, required bool isCreateNew});

  Future deleteReport({required FormData data});

  Future updateTaskStatus({required FormData formData});
}
