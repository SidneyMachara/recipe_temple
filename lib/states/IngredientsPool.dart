import 'package:flutter/foundation.dart';
import 'package:recipe_temple/database/database.dart';
import 'package:recipe_temple/models/Ingredient.dart';

class IngredientsPool with ChangeNotifier {
  List<Ingredient> _ingredientsList = [];

  IngredientsPool() {
    getDbIngredients();
  }

  void getDbIngredients() {
    RecipeDatabase db = RecipeDatabase();
    db.getIngredients().then((dbIngredients) {
      this._ingredientsList = dbIngredients;
      notifyListeners();
    });
  }

  List<Ingredient> get getIngredientsList => _ingredientsList;

  void deleteIngredient(int ingredientId) {
    RecipeDatabase db = RecipeDatabase();
    db.deleteIngredient(ingredientId).then((dbIngredients) {
      getDbIngredients();
    });
  }

  void saveIngredient(String newIngredient) {
    RecipeDatabase db = RecipeDatabase();
    db.addIngredient(Ingredient(newIngredient, 1)).then((dbIngredients) {
      getDbIngredients();
    });
  }

}
