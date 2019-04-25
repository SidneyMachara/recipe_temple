import 'package:recipe_temple/models/Step.dart';


class Recipe
{
  final name;
  final cookTime;
  final serves;
  final image;

  final _ingredients;
  final _instructions;

  Recipe(this.name, this.cookTime, this.serves, this.image, this._ingredients, this._instructions);

  List<String> get getIngredients
  {
    List<String> ingredients =[];

    for( var ing in _ingredients){
      ingredients.add(ing['name']);
    }

    return ingredients;
  }



  List<Step> get getInstructions
  {
    List<Step> instructions =[];

    for( var step in _instructions){
      instructions.add( Step(step['image'], step['text'], 'Step ' + step['step'].toString() ));
    }

    return instructions;
  }


}