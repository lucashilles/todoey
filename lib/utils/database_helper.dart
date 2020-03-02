import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoey/models/task.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var tasksDatabase = await openDatabase(
      join(await getDatabasesPath(), 'doit.db'),
      onCreate: (db, version) {
        _createDB(db);
      },
      version: 1,
    );
    return tasksDatabase;
  }

  void _createDB(Database db) async {
    await db.execute(
      'CREATE TABLE tasks(taskid INTEGER PRIMARY KEY ASC AUTOINCREMENT, description TEXT, isdone INTEGER, tasklistid INTEGER)',
    );
    await db.execute(
      'CREATE TABLE tasklists(tasklistid INTEGER PRIMARY KEY ASC AUTOINCREMENT, name TEXT)',
    );
    await initializeTables();
  }

  Future<void> initializeTables() async {
    Database db = await this.database;
    Batch batch = db.batch();
    batch.insert('tasklists', {
      'name': 'Do it!',
    });
    batch.insert('tasks', {
      'description': 'Abra o menu no circulo branco',
      'isdone': 0,
      'tasklistid': 1
    });
    batch.insert('tasks', {
      'description': 'Adicione uma nota no +',
      'isdone': 0,
      'tasklistid': 1
    });
    batch.insert('tasks', {
      'description': 'Me deslize para me apagar',
      'isdone': 0,
      'tasklistid': 1
    });
    batch.insert('tasks',
        {'description': 'Tarefa finalizada', 'isdone': 0, 'tasklistid': 1});
    batch.insert('tasks', {
      'description': 'Você pode criar várias listas de notas',
      'isdone': 0,
      'tasklistid': 1
    });
    await batch.commit(noResult: true);
  }

  Future<int> insertTask(Task task, int taskList) async {
    Database db = await this.database;
    int id;
    List<Map<String, dynamic>> maps = await db.query('SQLITE_SEQUENCE',
        columns: ['seq'], where: 'name = ?', whereArgs: ['tasks']);
    id = 1 + (maps != null ? maps[0]['seq'] : 0);
    db.insert('tasks', {
      'description': task.description,
      'isdone': (task.isDone ? 1 : 0),
      'tasklistid': taskList
    });
    return id;
  }

  Future<int> insertTaskList(String taskList) async {
    Database db = await this.database;
    int id;
    List<Map<String, dynamic>> maps = await db.query('SQLITE_SEQUENCE',
        columns: ['seq'], where: 'name = ?', whereArgs: ['tasklists']);
    id = 1 + (maps != null ? maps[0]['seq'] : 0);
    db.insert('tasklists', {'name': taskList});
    return id;
  }

  Future<List<Map<String, dynamic>>> getTaskLists() async {
    Database db = await this.database;
    return db.query('tasklists');
  }

  Future<List<Map<String, dynamic>>> getTasks(int taskListID) async {
    Database db = await this.database;
    return await db
        .query('tasks', where: 'tasklistid = ?', whereArgs: [taskListID]);
  }

  void updateTask(int id, bool isDone) async {
    Database db = await this.database;
    db.update('tasks', {'isdone': (isDone ? 1 : 0)},
        where: 'taskid = ?', whereArgs: [id]);
  }

  void updateTaskList(int id, String name) async {
    Database db = await this.database;
    db.update('tasklists', {'name': name},
        where: 'tasklistid = ?', whereArgs: [id]);
  }

  void deleteTask(int id) async {
    Database db = await this.database;
    db.delete('tasks', where: 'taskid = ?', whereArgs: [id]);
  }

  void deleteTaskList(int id) async {
    Database db = await this.database;
    db.delete('tasklists', where: 'tasklistid = ?', whereArgs: [id]);
  }
}
