import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:etrade/models/product.dart';

class DbHelper {
  
  String tblProduct = "Products";
  String colId = "Id";
  String colName = "Name";
  String colDescription = "Description";
  String colPrice = "Price";
  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  //Connecting to the db.
  static Database _db;

  Future<Database> get db async{
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async{
    Directory directory = await getApplicationDocumentsDirectory(); //provided by path provider.
    String path = directory.path + "etrade.db";
    
    var dbEtrade = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbEtrade;
  }

//underscode because it'll be private method.
  void _createDb(Database db, int version) async {
    await db.execute("Create table $tblProduct($colId integer primary key, $colName text, $colDescription text, $colPrice int)");
  }

  Future<int> insert(Product product) async {
    Database db = await this.db;
    var result = await db.insert(tblProduct, product.toMap());
    return result;
  }

  Future<int> update(Product product) async {
    Database db = await this.db;
    var result = await db.update(tblProduct, product.toMap(), where: "$colId=?", whereArgs: [product.id]);
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("Delete from $tblProduct where $colId = $id");
    return result;
  }

  Future<List> getProducts() async {
    Database db = await this.db;
    var result = await db.rawQuery("Select * from $tblProduct");
    return result;
  }
}