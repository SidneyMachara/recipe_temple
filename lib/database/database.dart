import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async';
import 'dart:io';

import 'package:recipe_temple/models/Ingredient.dart';

class RecipeDatabase{
  static final RecipeDatabase _instance = RecipeDatabase._internal();

  factory RecipeDatabase() => _instance;

  static Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    }

    _db = await initDB();
    return _db;
  }

  RecipeDatabase._internal();

  Future<Database> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var theDB = await openDatabase(path,version: 1,onCreate: _onCreate);
    return theDB;
  }

  void _onCreate(Database db,int version) async{
    await db.execute("CREATE TABLE Ingredients (id INTEGER PRIMARY KEY, name String,use bool, avatar String)");

    print("Ingredients table was Created!");
  }

  Future<List<Ingredient>> getIngredients() async {
    var dbClient = await db;
    List<Map> res = await dbClient.query("Ingredients");
    return res.map((m) => Ingredient.fromDb(m)).toList();
  }
//
//  Future<Ingredient> getMovie(String id) async {
//    var dbClient = await db;
//    var res = await dbClient.query("Ingredients", where: "id = ?", whereArgs: [id]);
//    if (res.length == 0) return null;
//    return Ingredient.fromDb(res[0]);
//  }

  Future<int> addIngredient(Ingredient ingredient) async {
    var dbClient = await db;
    try {
      int res = await dbClient.insert("Ingredients", ingredient.toMap());
      print("Ingredient added $res");
      return res;
    } catch (e) {
      int res = await updateIngredient(ingredient);
      return res;
    }
  }

  Future<int> updateIngredient(Ingredient ingredient) async {
    var dbClient = await db;
    int res = await dbClient.update("Ingredients", ingredient.toMap(),
        where: "id = ?", whereArgs: [ingredient.id]);
    print("Ingredient updated $res");
    return res;
  }

  Future<int> deleteIngredient(int id) async {
    var dbClient = await db;
    var res = await dbClient.delete("Ingredients", where: "id = ?", whereArgs: [id]);
    print("Ingredients deleted $res");
    return res;
  }

  Future closeDb() async {
    var dbClient = await db;
    dbClient.close();
  }
}