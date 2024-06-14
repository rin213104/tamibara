import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../action/gaming_data_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;
  final StreamController<List<Todo>> _todoStreamController = StreamController.broadcast();

  DatabaseHelper._internal();

  Stream<List<Todo>> get todoStream => _todoStreamController.stream;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    _loadTodos(); // 데이터베이스가 초기화된 후 할 일 목록을 로드
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'todo_database.db');

    return openDatabase(
      path,
<<<<<<< HEAD
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE todos(id TEXT PRIMARY KEY, title TEXT, date TEXT, durationTime INTEGER, memo TEXT, isChecked INTEGER)',
        );
=======
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE todos(id TEXT PRIMARY KEY, title TEXT, date TEXT, durationTime INTEGER, memo TEXT, isChecked INTEGER)',
        );
        await db.execute(
          'CREATE TABLE firstRunTable(id INTEGER PRIMARY KEY AUTOINCREMENT, firstRun INTEGER)',
        );
>>>>>>> origin/rin213104
      },
      version: 1,
    );
  }

  Future<void> insertTodo(Todo todo) async {
    final db = await database;
    await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _updateStream();
  }

  Future<List<Todo>> todos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todos', orderBy: 'date');
    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        date: DateTime.parse(maps[i]['date']),
        durationTime: maps[i]['durationTime'],
        memo: maps[i]['memo'],
        isChecked: maps[i]['isChecked'] == 1,
      );
    });
  }

  Future<void> updateTodo(Todo todo) async {
    final db = await database;
    await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
    _updateStream();
  }

  Future<void> deleteTodo(String id) async { // 할 일 삭제
    final db = await database;
    await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
    _updateStream();
  }

  Future<void> deletePastTodos() async { // 지난 할 일 삭제
    final db = await database;
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);

    final List<Todo> pastTodos = await db.query(
      'todos',
      where: 'date < ?',
      whereArgs: [startOfDay.toIso8601String()],
    ).then((data) => data.map((item) => Todo(
      id: item['id'] as String,
      title: item['title'] as String,
      date: DateTime.parse(item['date'] as String),
      durationTime: item['durationTime'] as int,
      memo: item['memo'] as String,
      isChecked: item['isChecked'] == 1,
    )).toList());

    for (var todo in pastTodos) {
      // 지난 할 일 삭제 및 경험치 감소
      await deleteTodo(todo.id);
      GamingDataModel().decreaseEXP();
    }
    _updateStream();
  }

  Future<Todo?> getTodoById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Todo(
        id: maps[0]['id'],
        title: maps[0]['title'],
        date: DateTime.parse(maps[0]['date']),
        durationTime: maps[0]['durationTime'],
        memo: maps[0]['memo'],
        isChecked: maps[0]['isChecked'] == 1,
      );
    }
    return null;
  }

<<<<<<< HEAD
=======
  Future<int> insertFirstRun(int isFirstRun) async {
    final db = await database;
    final int result = await db.insert(
      'firstRunTable',
      {'firstRun': isFirstRun},
    );
    return result;
  }

  Future<int?> getFirstRun() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('firstRunTable');
    if (result.isNotEmpty) {
      return result.first['firstRun'];
    }
    return null;
  }

>>>>>>> origin/rin213104
  void _updateStream() async {
    final currentTodos = await todos();
    _todoStreamController.add(currentTodos);
  }

  void _loadTodos() async {
    _updateStream();
  }

  void dispose() {
    _todoStreamController.close();
  }
}

class Todo {
  final String id;
  final String title;
  final DateTime date;
  final int durationTime;
  final String memo;
  final bool isChecked;

  Todo({
    required this.id,
    required this.title,
    required this.date,
    required this.durationTime,
    required this.memo,
    required this.isChecked,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'durationTime': durationTime,
      'memo': memo,
      'isChecked': isChecked ? 1 : 0,
    };
  }
}