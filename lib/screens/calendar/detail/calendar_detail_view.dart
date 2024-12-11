import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'calendar_detail_logic.dart';

class CalendarTaskDetailPage extends StatefulWidget {
  @override
  State<CalendarTaskDetailPage> createState() => _CalendarTaskDetailPageState();
}

class _CalendarTaskDetailPageState extends State<CalendarTaskDetailPage> {
  final logic = Get.find<CalendarDetailLogic>();
  final state = Get.find<CalendarDetailLogic>().state;

  @override
  void initState() {
    super.initState();
    // Nhận `taskId` từ `arguments` là một Map
    final Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    final String taskId = arguments['id'] ?? '';
    logic.fetchTaskDetailById(taskId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết lịch'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
            Get.delete<CalendarDetailLogic>();
          },
        ),
        actions: [
          Obx(() {
            return IconButton(
              icon: Icon(state.isEditing.value ? Icons.save : Icons.edit),
              onPressed: () {
                if (state.isEditing.value) {
                  _confirmSave();
                } else {
                  state.isEditing.value = true;
                }
              },
            );
          }),
        ],
      ),
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    _buildDateTimeField('Thời gian bắt đầu', state.startTimeController, logic.selectTaskStartTime),
                    _buildDateTimeField('Thời gian kết thúc', state.endTimeController, logic.selectTaskEndTime),
                    _buildTextField('Tên công việc', state.taskNameController),
                    _buildTextField('Người tạo', state.ownerNameController),
                    _buildTextField('Lãnh đạo', state.lanhdaoNameController, maxLines: 1),
                    _buildTextField('Chi tiết', state.chitietController, maxLines: 5),
                    _buildTextField('Ghi chú', state.ghiChuController, maxLines: 3),
                  ],
                ),
              ),
              _buildActionButtons(), // Thêm nút xóa và chỉnh sửa
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int? maxLines}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: TextFormField(
          controller: controller,
          enabled: state.isEditing.value,
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimeField(String label, TextEditingController controller, Function onTap) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: GestureDetector(
          onTap: state.isEditing.value ? () => onTap() : null,
          child: AbsorbPointer(
            child: TextFormField(
              controller: controller,
              enabled: false,
              decoration: InputDecoration(
                labelText: label,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.delete),
          label: Text('Xóa', style: TextStyle(color: Colors.white),),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: _confirmDelete,
        ),
      ],
    );
  }

  void _confirmSave() {
    Get.dialog(
      AlertDialog(
        title: Text('Xác nhận'),
        content: Text('Bạn có chắc chắn muốn lưu các thay đổi?'),
        actions: [
          TextButton(
            child: Text('Hủy'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('Lưu'),
            onPressed: () {
              Get.back();
              logic.saveTaskDetail();
            },
          ),
        ],
      ),
    );
  }

  void _confirmDelete() {
    Get.dialog(
      AlertDialog(
        title: Text('Xác nhận'),
        content: Text('Bạn có chắc chắn muốn xóa công việc này?'),
        actions: [
          TextButton(
            child: Text('Hủy'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('Xóa'),
            onPressed: () {
              Get.back();
              logic.deleteTask();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    state.startTimeController.dispose();
    state.endTimeController.dispose();
    state.taskNameController.dispose();
    state.ownerNameController.dispose();
    state.lanhdaoNameController.dispose();
    state.chitietController.dispose();
    state.ghiChuController.dispose();
    super.dispose();
  }
}
