import 'package:budget_tracker/models/item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper = DatabaseHelper._createInstance();
  static Database? _database;

  String itemTable = 'item_table';
  String colId = 'id';
  String colTitle = 'title';
  String colPrice = 'price';
  String colCategory = 'category';
  String colDate = 'date';

  DatabaseHelper._createInstance();
  factory DatabaseHelper() {
    // ignore: unnecessary_null_comparison
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }

  Future<Database?> get database async {
    // ignore: unnecessary_null_comparison
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'items.db';

    final itemsDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return itemsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $itemTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT,$colPrice TEXT, $colDate TEXT, $colCategory INTEGER)',
    );
  }

  Future<List<Map<String, dynamic>>> getItemMapList() async {
    Database? db = await this.database;
    // var result = await db!
    //     .rawQuery('SELECT * FROM $itemTable order by $colCategory ASC');
    final List<Map<String, dynamic>> result = await db!.query(
      itemTable,
    );
    return result;
  }

  Future<int> insertItem(Item item) async {
    Database? db = await this.database;
    final int result = await db!.insert(itemTable, item.toMap());
    return result;
  }

  Future<int> updateItem(Item item) async {
    var db = await this.database;
    final int result = await db!.update(itemTable, item.toMap(),
        where: '$colId = ?', whereArgs: [item.id]);
    return result;
  }

  Future<int> deleteItem(int id) async {
    var db = await this.database;
    int result =
        await db!.rawDelete('DELETE FROM $itemTable WHERE $colId = $id');
    return result;
  }

  Future<int?> getCount() async {
    Database? db = await this.database;
    List<Map<String, dynamic>> x =
        await db!.rawQuery('SELECT COUNT (*) from $itemTable');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Item>> getItemList() async {
    final List<Map<String, dynamic>> itemMapList = await getItemMapList();
    // int count = itemMapList.length;
    List<Item> itemList = <Item>[];
    // for (int i = 0; i < count; i++) {
    //   itemList.add(Item.fromMapObject(itemMapList[i]));
    // }
    // return itemList;
    itemMapList.forEach((itemMap) {
      itemList.add(Item.fromMap(itemMap));
    });
    itemList.sort((a, b) => a.date.compareTo(b.date));
    return itemList;
  }
}
