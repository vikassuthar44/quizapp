import 'package:path/path.dart';
import 'package:quiz_app/database/ResultModel.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  late Database database;

  Future openDb() async {
    database = await openDatabase(join(await getDatabasesPath(), "quiz.db"),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE quizResult(id INTEGER PRIMARY KEY autoincrement, categoryName TEXT, totalQuestion TEXT, dateAndTime TEXT, score TEXT)",
      );
    });
  }

  Future insert(ResultModel resultModel) async {
    await openDb();
    return await database.insert('quizResult', resultModel.toJson());
  }

  Future<List<ResultModel>> getResultModelList() async {
    await openDb();
    final List<Map<String, dynamic>> map = await database.query('quizResult');
    
    return List.generate(map.length, (index) {
      return ResultModel(
          id: map[index]['id'],
          categoryName: map[index]['categoryName'],
          totalQuestion: map[index]['totalQuestion'],
          dateAndTime: map[index]['dateAndTime'],
          score: map[index]['score']);
    });
  }
}
