import 'package:flutter/material.dart';
import 'package:todoey/screens/add_tasklist_screen.dart';
import 'package:todoey/widgets/tasklists_list.dart';

class TaskListsScreen extends StatelessWidget {
  static String id = 'tasklists_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Lists'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Color(0x00FFFFFF),
            isScrollControlled: true,
            context: context,
            builder: (context) => AddTaskListScreen(),
          );
        },
      ),
      body: TaskListsList(),
    );
  }
}
