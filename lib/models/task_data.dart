import 'package:flutter/foundation.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/utils/database_helper.dart';

class TaskData extends ChangeNotifier {
  TaskData() {
    _populateTaskList();
  }

  DatabaseHelper databaseHelper = DatabaseHelper();
  Map<String, dynamic> activeTaskList = {'tasklistid': 0, 'name': ''};
  List<dynamic> taskLists = [];
  List<Task> tasks = [];

  void _populateTaskList() async {
    taskLists = List<dynamic>.from(await databaseHelper.getTaskLists());
    for (int i = 0; i < taskLists.length; i++) {
      taskLists[i] = Map<String, dynamic>.from(taskLists[i]);
    }
    if (taskLists.length > 0) {
      activeTaskList = taskLists[0];
      _setTasks(activeTaskList['tasklistid']);
    }
  }

  void _setTasks(int taskListId) async {
    List<dynamic> tasksFromList = await databaseHelper.getTasks(taskListId);
    tasks.clear();
    for (var t in tasksFromList) {
      tasks.add(Task(
        taskId: t['taskid'],
        description: t['description'],
        isDone: t['isdone'] == 1 ? true : false,
      ));
    }
    notifyListeners();
  }

  int get taskCount {
    return tasks.length;
  }

  void setActiveTaskList(Map<String, dynamic> taskList) {
    activeTaskList = taskList;
    _setTasks(activeTaskList['tasklistid']);
  }

  void addTaskList(String name) async {
    int id;
    id = await databaseHelper.insertTaskList(name);
    taskLists.add({'name': name, 'tasklistid': id});
    notifyListeners();
  }

  void addTask(String descr, {bool isdone = false}) async {
    int id;
    Task t = Task(description: descr);
    id = await databaseHelper.insertTask(t, activeTaskList['tasklistid']);
    t.setId(id);
    tasks.add(t);
    notifyListeners();
  }

  void updateTaskList(int id, String name) async {
    for (Map<String, dynamic> tl in taskLists) {
      if (tl['tasklistid'] == id) {
        tl['name'] = name;
        break;
      }
    }
    databaseHelper.updateTaskList(id, name);
    notifyListeners();
  }

  void updateTask(Task task) async {
    task.toggleDone();
    databaseHelper.updateTask(task.taskId, task.isDone);
    notifyListeners();
  }

  void removeTaskList(int id) {
    for (Map<String, dynamic> tl in taskLists) {
      if (tl['tasklistid'] == id) {
        taskLists.remove(tl);
        if (id == activeTaskList['tasklistid']) {
          if (taskLists.length > 0) {
            activeTaskList = taskLists[0];
            _setTasks(activeTaskList['tasklistid']);
          } else {
            activeTaskList = {'tasklistid': 0, 'name': ''};
            tasks.clear();
          }
        }
        break;
      }
    }
    databaseHelper.deleteTaskList(id);
    notifyListeners();
  }

  void removeTask(Task task) {
    tasks.remove(task);
    databaseHelper.deleteTask(task.taskId);
    notifyListeners();
  }
}
