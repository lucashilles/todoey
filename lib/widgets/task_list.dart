import 'package:flutter/material.dart';
import 'package:todoey/models/task_data.dart';
import 'package:todoey/widgets/task_tile.dart';
import 'package:provider/provider.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 60.0),
          itemCount: taskData.taskCount,
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return Dismissible(
              key: Key(task.toString()),
              onDismissed: (direction) {
                taskData.removeTask(task);
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("Tarefa removida!")));
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
              child: TaskTile(
                title: task.description,
                isChecked: task.isDone,
                checkboxCallback: (value) {
                  taskData.updateTask(task);
                },
              ),
            );
          },
        );
      },
    );
  }
}
