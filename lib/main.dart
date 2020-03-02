import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_data.dart';
import 'package:todoey/screens/tasklists_screen.dart';
import 'package:todoey/screens/tasks_screen.dart';

void main() async => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        title: 'Do it!',
        initialRoute: TasksScreen.id,
        routes: {
          TasksScreen.id: (context) => TasksScreen(),
          TaskListsScreen.id: (context) => TaskListsScreen(),
        },
      ),
    );
  }
}
