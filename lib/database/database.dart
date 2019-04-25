import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

import 'dart:async';
import 'dart:io';

import 'package:recipe_temple/models/Ingredient.dart';
import 'package:recipe_temple/models/Recipe.dart';

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
    await db.execute("CREATE TABLE Ingredients (id INTEGER PRIMARY KEY, name String,use integer)");
    print("Ingredients table was Created!");

    await db.execute("CREATE TABLE saved_recipes (id INTEGER PRIMARY KEY, name String,image_url String, serves String, cook_time String)");
    print("Saved Recipes table was Created!");

    await db.execute("CREATE TABLE saved_recipe_ingredients (id INTEGER PRIMARY KEY, saved_recipe_id INTEGER,name String)");
    print("recipe_ingredients table was Created!");

    await db.execute("CREATE TABLE saved_recipe_instructions (id INTEGER PRIMARY KEY, saved_recipe_id INTEGER, step integer, image String,text String)");
    print("saved_recipe_instructions table was Created!");

    await db.execute("CREATE TABLE shopping_lists (id INTEGER PRIMARY KEY, ingredient_name String)");
    print("shopping_list table was Created!");
  }

  Future<List<Ingredient>> getIngredients() async {
    var dbClient = await db;
    List<Map> res = await dbClient.query("Ingredients");
    return res.map((m) => Ingredient.fromDb(m)).toList();
  }


  Future<List<Ingredient>> getIngredientsToUse() async {
    var dbClient = await db;
    List<Map> res = await dbClient.query("Ingredients",where: "use = ?", whereArgs: [1]);
    return res.map((m) => Ingredient.fromDb(m)).toList();
  }

  Future<List<Recipe>> getSavedRecipes() async {

    var dbClient = await db;
    List<dynamic> recipesList = await dbClient.query("saved_recipes");
    List<Recipe> recipes =[];

    for(var rec in recipesList) {
      List<dynamic> ingredients = await dbClient.query("saved_recipe_ingredients",where: "saved_recipe_id = ?", whereArgs: [rec['id']]);
      List<dynamic> instructions = await dbClient.query("saved_recipe_instructions",where: "saved_recipe_id = ?", whereArgs: [rec['id']]);
      print(instructions);
      Recipe recipe = Recipe(
          rec['id'], rec['name'], rec['cook_time'], rec['serves'], rec['image_url'], ingredients, instructions);

      recipes.add(recipe);
      print(recipe.getInstructions[0]);
    }
    print("--> done fetching saved recipes");
    return recipes;
  }

  Future<Ingredient> getIngredient(int id) async {
    var dbClient = await db;
    var res = await dbClient.query("Ingredients", where: "id = ?", whereArgs: [id]);
    if (res.length == 0) return null;
    return Ingredient.fromDb(res[0]);
  }

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

  Future<int> saveRecipe(Recipe recipe) async {
    var dbClient = await db;
    try {
      //save recipe
      int res =  await dbClient.insert("saved_recipes", recipe.toMap());
       //save its ingredients
       for(var ingred in recipe.getIngredients) {
         await dbClient.insert("saved_recipe_ingredients", {'name':ingred, 'saved_recipe_id':recipe.id});
       }
       //save its instructions
       for(var instru in recipe.getInstructions) {
         await dbClient.insert("saved_recipe_instructions", {'saved_recipe_id':recipe.id, 'step':instru.number, 'image':instru.imageUrl,'text':instru.stepText});
       }
      print("recipe saved");
      return res;
    } catch (e) {

      print("failed to save recipe or ingr,or instru");
      print("most likely becouse its already saved");
      return 0;
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

  Future<int> toggleUseIngredient(int id, int newUse) async {
    var dbClient = await db;
//    int res = await dbClient.update("Ingredients", ingredient,
//        where: "id = ?", whereArgs: [ingredient['id']]);
//    print("Ingredient updated $res");
    int res = await dbClient.rawUpdate(
        'UPDATE Ingredients SET use = ? WHERE id = ?',
        [newUse,  id]);

    return res;
  }

  Future closeDb() async {
    var dbClient = await db;
    dbClient.close();
  }
}