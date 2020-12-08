import 'package:sqflite/sqflite.dart';
import 'package:tauwisata/data/model/favorite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createObject();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createObject();
    }

    return _databaseHelper;
  }

  static const String _tblFavorite = 'favorites';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/tauwisata.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblFavorite (
             id VARCHAR PRIMARY KEY,
             photoUrl TEXT,
             name TEXT,
             location TEXT,
             description TEXT,
             price TEXT,
             category TEXT,
             total_favorite INTEGER,
             sub_menu TEXT
           )     
        ''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }

  void addToFavorite(FavoriteModel favorite) async {
    final db = await database;
    await db.insert(_tblFavorite, favorite.toJson());
  }

  Future<List<FavoriteModel>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(_tblFavorite);

    return results.map((res) => FavoriteModel.fromJson(res)).toList();
  }

  Future<Map> getFavoriteByPhotoUrl(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;

    await db.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
