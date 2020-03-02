class Task {
  Task({this.taskId, this.description, this.isDone = false});

  int taskId;
  final String description;
  bool isDone;

  void toggleDone() {
    isDone = !isDone;
  }

  void setId(int id) {
    this.taskId = id;
  }

  String toString() {
    return this.description;
  }
}
