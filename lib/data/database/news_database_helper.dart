import 'dart:async';

import 'package:flutter_newsapp/domain/models/article_entity.dart';
import 'package:flutter_newsapp/domain/models/news_source_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NewsDatabaseHelper {
  static final NewsDatabaseHelper _instance = new NewsDatabaseHelper.internal();

  factory NewsDatabaseHelper() => _instance;

  final String tableNewsArticle = 'NewsArticle';
  final String columnTitle = 'title';
  final String columnDescription = 'description';
  final String columnContent = 'content';
  final String columnAuthor = 'author';
  final String columnPublishedAt = 'publishedAt';
  final String columnUrl = 'url';
  final String columnUrlToImage = 'urlToImage';
  final String columnSource = 'source';
  final String columnIsBookmarked = 'isBookmarked';

  final String tableNewsSource = 'NewsSource';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnCategory = 'category';
  final String columnCountry = 'country';
  final String columnLanguage = 'language';

  static Database _db;

  NewsDatabaseHelper.internal();

  Future get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'news.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('CREATE TABLE IF NOT EXISTS $tableNewsArticle(' +
        '$columnTitle TEXT PRIMARY KEY,' +
        '$columnDescription TEXT,' +
        '$columnAuthor TEXT,' +
        '$columnContent TEXT,' +
        '$columnUrl TEXT,' +
        '$columnUrlToImage TEXT,' +
        '$columnPublishedAt TEXT,' +
        '$columnIsBookmarked INTEGER,' +
        '$columnSource TEXT)');

    await db.execute('CREATE TABLE IF NOT EXISTS $tableNewsSource(' +
        '$columnId TEXT PRIMARY KEY,' +
        '$columnName TEXT,' +
        '$columnDescription TEXT,' +
        '$columnUrl TEXT,' +
        '$columnCategory TEXT,' +
        '$columnLanguage TEXT,' +
        '$columnCountry TEXT)');
  }

  Future insertNewsArticle(ArticleEntity articleEntity) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableNewsArticle, articleEntity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);

    return result;
  }

  Future insertNewsSource(NewsSourceEntity newsSourceEntity) async {
    var dbClient = await db;
    var result = await dbClient.insert(
        tableNewsSource, newsSourceEntity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);

    return result;
  }

  Future<List<Map<String, dynamic>>> getAllNewsArticles() async {
    var dbClient = await db;
    return await dbClient.rawQuery(
        'SELECT * FROM $tableNewsArticle ORDER BY $columnPublishedAt DESC');
  }

  Future<List<Map<String, dynamic>>> getAllNewsSources() async {
    var dbClient = await db;
    return await dbClient.rawQuery('SELECT * FROM $tableNewsSource');
  }

  Future getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableNewsArticle'));
  }

  Future deleteOldNewsArticles(String dateFormatted) async {
    var dbClient = await db;
    return await dbClient.rawDelete(
        'DELETE FROM $tableNewsArticle WHERE $columnPublishedAt < $dateFormatted');
  }

  Future updateBookmarked(ArticleEntity articleEntity) async {
    var dbClient = await db;
    return await dbClient.update(tableNewsArticle, articleEntity.toMap(),
        where: "$columnTitle = ?", whereArgs: [articleEntity.title]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

  Future<List<Map<String, dynamic>>> getBookmarkedNewsArticles() async {
    var dbClient = await db;
    return await dbClient.rawQuery(
        'SELECT * FROM $tableNewsArticle WHERE $columnIsBookmarked = 1 ORDER BY $columnPublishedAt DESC');
  }
}
