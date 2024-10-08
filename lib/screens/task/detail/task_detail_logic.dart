import 'package:chatview/chatview.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_services/bus_service.dart';
import 'package:mobile_rhm/app_services/story/permisson/permisson_list.dart';
import 'package:mobile_rhm/app_services/story/rhm_service.dart';
import 'package:mobile_rhm/app_widgets/meta/list/common_option_list.dart';
import 'package:mobile_rhm/core/constants/keys.dart';
import 'package:mobile_rhm/core/constants/roles.dart';
import 'package:mobile_rhm/core/constants/task.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/utils/dialog_utils.dart';
import 'package:mobile_rhm/core/utils/file_utils.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/data/model/common/opttion_model.dart';
import 'package:mobile_rhm/data/model/response/task/bao_cao_cong_viec.dart';
import 'package:mobile_rhm/data/model/response/task/chat_info.dart';
import 'package:mobile_rhm/data/model/response/task/sub_task_progress_response.dart';
import 'package:mobile_rhm/data/model/response/user/me/UserProfile.dart';
import 'package:mobile_rhm/routers/app_pages.dart';
import 'package:dio/dio.dart' as Dio;

import '../../../data/model/response/task/subtask_list_response.dart';
import 'task_detail_state.dart';

class TaskDetailLogic extends GetxController {
  Rx<SubTaskListResponse> subTasks = SubTaskListResponse().obs;
  final TaskDetailState state = TaskDetailState();
  final RHMService _rhmService = Get.find<RHMService>();
  late ChatController chatController;
  final ScrollController _chatScrollController = ScrollController();

  @override
  void onReady() {
    super.onReady();
    LogUtils.logE(message: 'Goto Task onReady');
    _loadData();
    _initRole();
    _onListenTaskChange();
    _initChatController();
  }

  _onListenTaskChange() {
    _rhmService.eventBusService.listenEvent<EventUpdateTask>(onListen: (event) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    _rhmService.taskService.getSubTaskList(congviec_id: "${state.task.id}").then((task) {
      if (task != null) {
        state.subTasks.value = task;
        _loadSubTaskProgress(subTaskIds: (task.dataProvider ?? []).map((e) => (e.id ?? 0)).toList());
      }
    });
  }

  Future<void> _loadSubTaskProgress({required List<num> subTaskIds}) async {
    var res = await _rhmService.taskService.getSubTasksProgress(ids: subTaskIds);
    if (res != null) {
      for (var item in res) {
        state.subTasksProgress[item.id ?? 0] = item;
      }
      state.subTasksProgress.refresh();
    }
  }

  void updateTask() async {
    await Get.toNamed(Routers.TASK_NEW, arguments: {AppExtraData.DATA: state.task});
    //TODO: Reload task
  }

  void _initRole() {
    LogUtils.logE(message: 'Task stastus = ${state.task.status}');
    UserProfile? user = _rhmService.userService.getUserProfile();
    if (user?.displayName?.toLowerCase() == UserRole.SUPER_ADMIN.toLowerCase() || user?.userId == state.task.nguoiphutrachId) {
      state.isAllowCRUD.value = true;
      if (state.task.status == TaskStatus.COMPLETED || state.task.status == TaskStatus.CANCELED) {
        state.isAllowCRUD.value = false;
      }
    }

    state.isAllowAddSubTask.value =
        _rhmService.metadataService.hasPermission(permission: user?.permission ?? [], checkPermisson: PermissonList.CONGVIEC_CREATE);
    state.isAllowUpdateSubTask.value =
        _rhmService.metadataService.hasPermission(permission: user?.permission ?? [], checkPermisson: PermissonList.CONGVIEC_UPDATE);
  }

  void openFile({required String file}) {
    FileUtils.openRemoteFile(file: file);
  }

  void addAttachFile() {}

  void updateSubTask({SubTaskProgressResponse? subTask}) {
    Get.toNamed(Routers.SUB_TASK_NEW, arguments: {AppExtraData.DATA: subTask, AppExtraData.ID: state.task.id, AppExtraData.TEXT: state.task.ten});
  }

  void addComment({required String message, required ReplyMessage replyMessage}) async {
    LogUtils.logE(message: 'Reply message ${replyMessage.message}  - ID: ${replyMessage.messageId}');
    chatController.addMessage(
      Message(
        id: DateTime.now().toString(),
        createdAt: DateTime.now(),
        message: message,
        sentBy: chatController.currentUser.id,
        replyMessage: replyMessage,
        messageType: MessageType.text,
      ),
    );
    chatController.initialMessageList.last.setStatus = MessageStatus.undelivered;
    var res = await _rhmService.taskService.addComment(
        congviec_id: state.task.id ?? 0,
        replyto: replyMessage.message.isNullOrEmpty ? -1 : int.tryParse(replyMessage.messageId) ?? -1,
        comment: message);
    if (res != null) {
      if (res['status'] == false) {
        _rhmService.toastService.showToast(message: res['messages'] ?? AppStrings.error_common.tr, isSuccess: false, context: Get.context!);
      } else if (res['status'] == true) {
        ChatInfo? chatInfo = await _rhmService.taskService.getCommentData(taskId: state.task.id ?? 0);
        if (chatInfo != null) {
          state.chatInfo.value = chatInfo;
          state.chatInfo.refresh();
          LogUtils.logE(message: 'Refresh Chat list');
          chatController.initialMessageList = [];
          chatController.loadMoreData(state.chatInfo.value.messages ?? []);
        }
      }
    }
  }

  void unsentMessage({required Message message}) async {
    LogUtils.logE(message: 'Unsent Message ${message.message} ID: ${message.id}');
    var res = await _rhmService.taskService.unsentComment(congviec_id: int.tryParse(message.id) ?? -1);
    if (res != null) {
      if (res['status'] == false) {
        _rhmService.toastService.showToast(message: res['messages'] ?? AppStrings.error_common.tr, isSuccess: false, context: Get.context!);
      } else if (res['status'] == true) {
        ChatInfo? chatInfo = await _rhmService.taskService.getCommentData(taskId: state.task.id ?? 0);
        if (chatInfo != null) {
          state.chatInfo.value = chatInfo;
          state.chatInfo.refresh();
          LogUtils.logE(message: 'Refresh Chat list');
          chatController.initialMessageList = [];
          chatController.loadMoreData(state.chatInfo.value.messages ?? []);
        }
      }
    }
  }

  void _initChatController() async {
    LogUtils.logE(message: 'Init chat controller');
    ChatInfo? chatInfo = await _rhmService.taskService.getCommentData(taskId: state.task.id ?? 0);
    if (chatInfo != null) {
      state.chatInfo.value = chatInfo;
      chatController = ChatController(
        initialMessageList: state.chatInfo.value.messages ?? [],
        scrollController: _chatScrollController,
        currentUser: state.chatInfo.value.currentUser!,
        otherUsers: state.chatInfo.value.otherUsers ?? [],
      );
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _chatScrollController.dispose();
    chatController.dispose();
    super.onClose();
  }

  void onShowDetailReport({required Baocaocongviec report, required SubTaskDetail task}) {
    Get.toNamed(Routers.REPORT_DETAIL, arguments: {AppExtraData.DATA: report, AppExtraData.EXTRA_DATA: task});
  }

  void addNewReport({required SubTaskDetail task}) async {
    await Get.toNamed(Routers.REPORT_NEW, arguments: {AppExtraData.EXTRA_DATA: task});
    _loadData();
  }

  void onChangeStatusTask() async {
    Widget bottomSheet = CommonOptionListView(
      optionItems: TaskStatus.TASK_CREATE_FILTER,
      onSelect: (OptionModel item) {
        LogUtils.logE(message: 'Selected item');
        LogUtils.log(item);
        _onUpdateTaskStatus(newStatus: item);
      },
      selected: state.currentStatus.value,
      title: AppStrings.status_label.tr,
    );

    await Get.bottomSheet(bottomSheet, isScrollControlled: true);
  }

  _onUpdateTaskStatus({required OptionModel newStatus}) async {
    if (newStatus.key == state.currentStatus.value.key) {
      return;
    }

    try {
      DialogUtils.showLoading();
      var request = {'id': state.task.id, 'trangthai': newStatus.key};
      Dio.FormData formData = Dio.FormData.fromMap(request);

      var res = await _rhmService.taskService.updateTaskStatus(formData: formData);
      if (res['status'] == true) {
        _rhmService.toastService.showToast(message: res['message'] ?? AppStrings.common_success.tr, isSuccess: true, context: Get.context!);
        state.statusText.value = TaskStatus.statusText(status: int.parse("${newStatus.key}"));
        state.task.status = int.parse("${newStatus.key}");
        state.currentStatus.value = newStatus;
        _initRole();
      } else {
        _rhmService.toastService.showToast(message: AppStrings.error_common.tr, isSuccess: false, context: Get.context!);
      }
      DialogUtils.hideLoading();
    } catch (e) {
      DialogUtils.hideLoading();
      _rhmService.toastService.showToast(message: AppStrings.error_common.tr, isSuccess: false, context: Get.context!);
    }
  }
}
