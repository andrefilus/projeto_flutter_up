import 'dart:async';

import 'package:aula2/domain/movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MovieDB {
  static final MovieDB _instance = new MovieDB.getInstance();

  factory MovieDB() => _instance;

  MovieDB.getInstance();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'aula2.db');
    print("db $path");
    //await deleteDatabase(path);

    var db = await openDatabase(path, version: 2, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE movies (id INTEGER PRIMARY KEY, title TEXT, overview TEXT, vote_average TEXT, poster_path TEXT)');
  }

  Future<int> saveMovie(Movie movie) async {
    var dbClient = await db;
    final sql =
        'insert or replace into movies (id,title,overview,vote_average,poster_path) VALUES '
        '(?,?,?,?,?)';
    print(sql);
    var id = await dbClient.rawInsert(sql, [
      movie.id,
      movie.title,
      movie.overview,
      movie.vote_average,
      movie.poster_path
    ]);
    print('id: $id');
    return id;
  }

  Future<List<Movie>> getMovies() async {
    final dbClient = await db;

    final mapMovies = await dbClient.rawQuery('select * from movies');

    final movies = mapMovies.map<Movie>((json) => Movie.fromJson(json)).toList();

    return movies;
  }

  Future<int> getCount() async {
    final dbClient = await db;
    final result = await dbClient.rawQuery('select count(*) from movies');
    return Sqflite.firstIntValue(result);
  }

  Future<Movie> getMovie(int id) async {
    var dbClient = await db;
    final result = await dbClient.rawQuery('select * from movies where id = ?',[id]);

    if (result.length > 0) {
      return new Movie.fromJson(result.first);
    }

    return null;
  }

  Future<bool> exists(Movie movieItem) async {
    var movie = await getMovie(movieItem.id);
    var exists = movie != null;
    return exists;
  }

  Future<int> deleteMovie(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from movies where id = ?',[id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}