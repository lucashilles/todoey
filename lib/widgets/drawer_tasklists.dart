import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_data.dart';

class DrawerTaskLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return Builder(
          builder: (context) {
            List<Widget> labels = [];
            if (taskData.taskLists == null) {
              labels.add(
                ListTile(
                  title: Text('You have no lists...'),
                  dense: true,
                ),
              );
            } else {
              labels.clear();
              for (var tasklist in taskData.taskLists) {
                labels.add(
                  ListTile(
                    leading: Icon(Icons.label, size: 20.0),
                    title: Text('${tasklist['name']}'),
                    dense: true,
                    selected: tasklist['tasklistid'] ==
                        taskData.activeTaskList['tasklistid'],
                    onTap: () {
                      taskData.setActiveTaskList(tasklist);
                    },
                  ),
                );
              }
            }
            return ListBody(
              children: labels,
            );
          },
        );
      },
    );
  }
}

//child: ListBody(
//children: <Widget>[
//ListTile(
//leading: Icon(Icons.label, size: 20.0),
//title: Text('Task List 1'),
//dense: true,
//selected: true,
//),
//ListTile(
//leading: Icon(Icons.label, size: 20.0),
//title: Text('Task List 2'),
//dense: true,
//),
//ListTile(
//leading: Icon(Icons.label, size: 20.0),
//title: Text('Task List 3'),
//dense: true,
//),
//],
//),
