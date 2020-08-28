import 'package:flutter/material.dart';
import 'package:todoeyflutter/widgets/task_tile.dart';
import 'package:todoeyflutter/models/task_data.dart';
import 'package:provider/provider.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, i) {
            final task = taskData.tasks[i];
            return TaskTile(
              taskName: task.name,
              isChecked: task.isDone,
              checkboxCallback: (checkboxState) {
                taskData.updateTask(task);
              },
              removeTaskFnc: () {
                taskData.removeTask(i);
              },
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
