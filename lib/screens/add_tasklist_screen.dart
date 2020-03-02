import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_data.dart';

class AddTaskListScreen extends StatefulWidget {
  AddTaskListScreen({this.taskList});
  final Map<String, dynamic> taskList;
  @override
  _AddTaskListScreenState createState() => _AddTaskListScreenState();
}

class _AddTaskListScreenState extends State<AddTaskListScreen> {
  String taskListName;

  void _submit() {
    if (widget.taskList == null) {
      Provider.of<TaskData>(context, listen: false).addTaskList(taskListName);
    } else {
      Provider.of<TaskData>(context, listen: false)
          .updateTaskList(widget.taskList['tasklistid'], taskListName);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        padding: EdgeInsets.fromLTRB(
            20.0, 20.0, 20.0, MediaQuery.of(context).viewInsets.bottom + 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              widget.taskList == null ? 'Add Task List' : 'Edit Task List Name',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20.0),
            ),
            TextField(
              autofocus: true,
              onChanged: (value) {
                taskListName = value;
              },
              onSubmitted: (value) {
                _submit();
              },
            ),
            SizedBox(height: 10.0),
            FlatButton(
              color: Colors.lightBlueAccent,
              onPressed: () {
                _submit();
              },
              child: Text(
                widget.taskList == null ? 'Add' : 'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
