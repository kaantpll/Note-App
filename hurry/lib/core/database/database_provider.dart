import 'package:hurry/core/models/notes_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String TABLE_NAME = "notes";
  static const String COLUMN_ID = "id";
  static const String COLUMN_TITLE = "title";
  static const String COLUMN_NOTE = "note";

  DatabaseProvider._();

  static DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDatabase();
      return _database;
    }
  }

  Future<Database> initDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, "note.db"),
      version: 1,
      onCreate: (Database database, int version) async {
        await database.execute(
            "CREATE TABLE $TABLE_NAME($COLUMN_ID INTEGER PRIMARY KEY,$COLUMN_TITLE VARCHAR(30),$COLUMN_NOTE VARCHAR(150)");
      },
    );
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    var notes = await db
        .query(TABLE_NAME, columns: [COLUMN_ID, COLUMN_TITLE, COLUMN_NOTE]);
    List<Note> noteList = List<Note>();
    notes.forEach((i) {
      Note note = Note.fromMap(i);
      noteList.add(note);
    });
    return noteList;
  }

  Future<Note> insertNote(Note note) async {
    final db = await database;
    note.id = await db.insert(TABLE_NAME, note.toMap());
    return note;
  }

  Future<int> update(Note note) async {
    final db = await database;
    return await db.update(TABLE_NAME, note.toMap(),
        where: "id = ?", whereArgs: [note.id]);
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(TABLE_NAME, where: "id = ?", whereArgs: [id]);
  }
}
