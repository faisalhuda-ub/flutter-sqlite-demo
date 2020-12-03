import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

import 'package:sqlite_demo/model/student.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;

  DbHelper._createObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }

  Future<Database> initDb() async {

    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'student.db';

    //create, read databases
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

  //buat tabel baru dengan nama student
  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE student (
        nim INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phone TEXT
      )
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('student', orderBy: 'name');
    return mapList;
  }

  // fungsi tambah data
  Future<int> insert(Student student) async {
    Database db = await this.database;
    int count = await db.insert('student', student.toMap());
    return count;
  }

  // fungsi update data
  Future<int> update(Student student) async {
    Database db = await this.database;
    int count = await db.update('student', student.toMap(),
        where: 'nim=?',
        whereArgs: [student.nim]);
    return count;
  }

  // fungsi hapus data
  Future<int> delete(int nim) async {
    Database db = await this.database;
    int count = await db.delete('student',
        where: 'nim=?',
        whereArgs: [nim]);
    return count;
  }

  Future<List<Student>> getStudentList() async {
    var studentMapList = await select();
    int count = studentMapList.length;
    List<Student> studentList = List<Student>();
    for (int i=0; i<count; i++) {
      studentList.add(Student.fromMap(studentMapList[i]));
    }
    return studentList;
  }

}