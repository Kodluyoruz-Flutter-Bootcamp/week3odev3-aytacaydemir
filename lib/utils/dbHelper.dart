// ignore: file_names
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/Grades.dart';
import '../model/Student.dart';

class DataBaseHelper {
  static Database? _database;

  String gradesTable = "grades";
  String studentsTable = "student";

  String clmnId = "id";
  String clmnlectureName = "lectureName";
  String clmnletterGrade = "letterGrade";

  String clmnStudentId = "studentId";
  String clmnName = "name";
  String clmnLastName = "lastname";

  Future<Database?> get database async {
    _database ??= await initializeDatabase();
    return _database;
  }

  Future<Database?> initializeDatabase() async {
    String dbPath = join(await getDatabasesPath(), "grades.db");
    var gradesDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return gradesDb;
  }

  void createDb(Database db, int version2) async {
    await db.execute(
        "Create table $gradesTable ($clmnId integer primary key,$clmnStudentId integer ,$clmnlectureName text ,$clmnletterGrade text) ");
    await db.execute(
        "CREATE TABLE $studentsTable ($clmnId integer primary key,$clmnName text,$clmnLastName text)");
  }

  Future<int> insert(Grades note) async {
    Database? db = await database;

    var result = await db!.insert(gradesTable, note.toMap());
    return result;
  }

  Future<int> update(Grades grade) async {
    Database? db = await database;

    var result = await db!.update(gradesTable, grade.toMap(),
        where: "id=?", whereArgs: [grade.id]);
    return result;
  }

  Future<List<Grades>> getAllGrades() async {
    Database? db = await database;

    var result = await db!.query(gradesTable);

    List<Grades> lstgrades = <Grades>[];
    for (var item in result) {
      lstgrades.add(Grades.fromMap(item));
    }

    return lstgrades;
  }

  Future<int> insertStudent(Student student) async {
    Database? db = await database;
    int result = await db!.insert(studentsTable, student.toMap());

    return result;
  }

  Future<List<Student>> getAllStudents() async {
    Database? db = await database;
    List<Student> lstStudent = <Student>[];

    var result = await db!.query(studentsTable);

    for (var item in result) {
      lstStudent.add(Student.getMap(item));
    }

    return lstStudent;
  }
}
