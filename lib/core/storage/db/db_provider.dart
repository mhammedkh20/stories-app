import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stories_app/core/storage/db/queries.dart';

class DBProvider with Queries {
  static final DBProvider _instance = DBProvider._internal();
  late final Database _database;

  factory DBProvider() {
    return _instance;
  }

  DBProvider._internal();

  Database get database => _database;

  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'app_database.sql');
    _database = await openDatabase(
      path,
      version: 1,
      onOpen: (Database db) {},
      onCreate: (Database db, int version) async {
        dbInstance = db;
        await createCategoriesTable();
        await createStoriesTable();
        await createMovieTable();
        await createPhotoFriendTable();
        await createShareFriendTable();
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) {},
      onDowngrade: (Database db, int oldVersion, int newVersion) {},
    );
  }
}

/**
    INT
    INTEGER
    TINYINT
    SMALLINT
    MEDIUMINT                 INTEGER	1
    BIGINT
    UNSIGNED BIG INT
    INT2
    INT8
    ---------------------------------------
    CHARACTER(20)
    VARCHAR(255)
    VARYING CHARACTER(255)
    NCHAR(55)                 TEXT	2
    NATIVE CHARACTER(70)
    NVARCHAR(100)
    TEXT
    CLOB
    ---------------------------------------
    BLOB
    no datatype specified	BLOB	3
    REAL
    DOUBLE
    DOUBLE PRECISION
    FLOAT	REAL	4             NUMERIC	5
    NUMERIC
    DECIMAL(10,5)
    BOOLEAN
    DATE
    DATETIME
    ----------------------------------------
 */
