import 'package:sqflite/sqflite.dart';
import 'db_const.dart';

mixin Queries {
  late Database dbInstance;

  Future<void> createShareFriendTable() async {
    await dbInstance.execute('CREATE TABLE ${DBConst.TABLE_SHARE_FRIEND} ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'audioUrl TEXT NULLABLE,'
        'createdAt TEXT NULLABLE,'
        'country TEXT NULLABLE,'
        'thumbnail TEXT NULLABLE,'
        'updatedAt TEXT NULLABLE,'
        'description TEXT NULLABLE,'
        'likes INTEGER NULLABLE,'
        'name TEXT NULLABLE,'
        'status TEXT NULLABLE,'
        'timeRef TEXT NULLABLE,'
        'title TEXT NULLABLE,'
        'file TEXT NULLABLE,'
        'url TEXT NULLABLE'
        ')');
  }

  Future<void> createPhotoFriendTable() async {
    await dbInstance.execute('CREATE TABLE ${DBConst.TABLE_PHOTO_FRIEND} ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'createdAt TEXT NULLABLE,'
        'country TEXT NULLABLE,'
        'updatedAt TEXT NULLABLE,'
        'file TEXT NULLABLE,'
        'likes INTEGER NULLABLE,'
        'name TEXT NULLABLE,'
        'status TEXT NULLABLE'
        ')');
  }

  Future<void> createMovieTable() async {
    await dbInstance.execute(
      'CREATE TABLE ${DBConst.TABLE_MOVIE_WEEK} ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'audioUrl TEXT NULLABLE,'
      'createdAt TEXT NULLABLE,'
      'description TEXT NULLABLE,'
      'likes TEXT INTEGER,'
      'thumbnail TEXT NULLABLE,'
      'title TEXT NULLABLE,'
      'updatedAt TEXT NULLABLE,'
      'url TEXT NULLABLE,'
      'isMove BOOLEAN NULLABLE,'
      'okvideo TEXT NULLABLE,'
      'show BOOLEAN NULLABLE'
      ')',
    );
  }

  Future<void> createCategoriesTable() async {
    await dbInstance.execute('CREATE TABLE ${DBConst.TABLE_CATRGORIES} ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'count INTEGER NULLABLE,'
        'createdAt TEXT NULLABLE,'
        'name TEXT NULLABLE,'
        'thumbnail TEXT NULLABLE,'
        'updatedAt TEXT NULLABLE'
        ')');
  }

  Future<void> createStoriesTable() async {
    await dbInstance.execute('CREATE TABLE ${DBConst.TABLE_STORYIES} ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'idCategory INTEGER,'
        'audioUrl TEXT NULLABLE,'
        'createdAt TEXT NULLABLE,'
        'description TEXT NULLABLE,'
        'likes TEXT INTEGER,'
        'thumbnail TEXT NULLABLE,'
        'title TEXT NULLABLE,'
        'updatedAt TEXT NULLABLE,'
        'url TEXT NULLABLE,'
        'url2 TEXT NULLABLE,'
        'audioUrl2 TEXT NULLABLE,'
        'isMove BOOLEAN NULLABLE,'
        'okvideo TEXT NULLABLE,'
        'show BOOLEAN NULLABLE,'
        ' FOREIGN KEY (id) REFERENCES categories(id)'
        ')');
  }
}
