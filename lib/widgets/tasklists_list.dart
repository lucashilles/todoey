import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_data.dart';
import 'package:todoey/screens/add_tasklist_screen.dart';

class TaskListsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
            itemCount: taskData.taskLists.length,
            itemBuilder: (context, index) {
              final tasklist = taskData.taskLists[index];
              return Dismissible(
                key: Key(tasklist['name'] + tasklist['tasklistid'].toString()),
                onDismissed: (direction) {
                  taskData.removeTaskList(tasklist['tasklistid']);
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("List de tarefas removida!"),
                    duration: Duration(seconds: 2),
                  ));
                },
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: AlignmentDirectional.centerStart,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                  title: Text(tasklist['name']),
                  trailing: Icon(Icons.edit, size: 20.0),
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Color(0x00FFFFFF),
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => AddTaskListScreen(
                        taskList: tasklist,
                      ),
                    );
                  },
                ),
              );
            });
      },
    );
  }
}
