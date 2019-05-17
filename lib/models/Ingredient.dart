import 'package:flutter/foundation.dart';
import 'package:recipe_temple/database/database.dart';
//import 'package:recipe_temple/models/Ingredient.dart';

class Ingredient with ChangeNotifier {
  String name;
  int use;
  int id;

  Ingredient(this.name, this.use);

  Ingredient.fromDb(Map map)
      : name = map["name"],
        use = map["use"],
        id = map["id"];

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['use'] = use;
    map['id'] = id;

    return map;
  }

  void toggleUseIngredient(int ingredientId, int newToggle) {
    RecipeDatabase db = RecipeDatabase();

    db.toggleUseIngredient(ingredientId , newToggle).then((dbIngredients) {
        use = newToggle;
        notifyListeners();
    });
  }


}
