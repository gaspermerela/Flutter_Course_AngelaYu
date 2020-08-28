import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  bool isChecked = false;
  final String taskName;
  final Function checkboxCallback;
  final Function removeTaskFnc;

  TaskTile(
      {this.isChecked,
      this.taskName,
      this.checkboxCallback,
      this.removeTaskFnc});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: removeTaskFnc,
      title: Text(
        taskName,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w400,
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        checkColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: checkboxCallback,
      ),
    );
  }
}
