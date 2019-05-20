import 'package:flutter/foundation.dart';
import 'package:recipe_temple/database/database.dart';
import 'package:recipe_temple/models/Recipe.dart';

class SavedRecipesPool with ChangeNotifier {
  List<Recipe> _savedRecipesPool = [];

  SavedRecipesPool() {
    _getSavedRecipes();
  }

  void _getSavedRecipes() async {
    RecipeDatabase db = RecipeDatabase();
    await db.getSavedRecipes().then((dbIngredients) {
      this._savedRecipesPool = dbIngredients;

      notifyListeners();
    });
  }

  List<Recipe> get getSavedRecipesPool => _savedRecipesPool;



  void unSaveRecipe(Recipe recipe)
  {
    RecipeDatabase db = RecipeDatabase();
    db.unSaveRecipe(recipe).then((dbResponse) {
      _getSavedRecipes();
    });
  }
}
