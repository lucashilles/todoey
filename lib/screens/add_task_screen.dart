import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_data.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String taskName;

  void _submit() {
    if (taskName == "" || taskName == null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Can't create empty task!"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      Provider.of<TaskData>(context, listen: false).addTask(taskName);
      Navigator.pop(context);
    }
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
              'New Task',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20.0),
            ),
            TextField(
              autofocus: true,
              onChanged: (value) {
                taskName = value;
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
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
