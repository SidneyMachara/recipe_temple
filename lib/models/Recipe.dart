import 'package:recipe_temple/models/Step.dart';


class Recipe
{
  final name;
  final cookTime;
  final serves;
  final image;
  final id;

  final _ingredients;
  final _instructions;

  Recipe(this.id, this.name, this.cookTime, this.serves, this.image, this._ingredients, this._instructions);



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



  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['cook_time'] = cookTime;
    map['serves'] = serves;
    map['image_url'] = image;
    map['id'] = id;

    return map;
  }




}