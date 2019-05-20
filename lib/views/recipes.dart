import 'package:flutter/material.dart';
import 'package:recipe_temple/views/custom/recipe_flat_card.dart';
import 'package:recipe_temple/models/Recipe.dart';
import 'package:recipe_temple/database/database.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipesPage extends StatefulWidget {
  @override
  RecipesPageState createState() => RecipesPageState();
}

class RecipesPageState extends State<RecipesPage> {

  Future<String> _getUsableIngredients() async {

    String ingredients =
        '?ingredients='; // TODO : has a problem with ingredients that have space eg (vegetable oil)

    RecipeDatabase db = RecipeDatabase();
    await db.getIngredientsToUse().then((dbIngredients) {
      String ingred;
      for (var ingredient in dbIngredients) {
        ingred = ingredient.name;
        ingredients = ingredients + ingred + ',';
      }
    });

    return ingredients.substring(0, ingredients.length - 1);
  }

  Future<List<Recipe>> _getRecipes() async {
    String ingredients = await _getUsableIngredients();
    print("http://178.128.207.244/api/recipes/recipe_search$ingredients");
    var data = await http
        .get("http://178.128.207.244/api/recipes/recipe_search$ingredients");

    var jsonData = json.decode(data.body);

    List<Recipe> recipes = [];

    for (var rec in jsonData['data']) {
      Recipe recipe = Recipe(
          rec['id'],
          rec['name'],
          rec['cook_time'],
          rec['serves'],
          rec['image_link'],
          rec['ingredients'],
          rec['instructions']);
      recipes.add(recipe);
    }

    print("http://178.128.207.244/api/recipes/recipe_search$ingredients");
 
    return recipes;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 35.0, bottom: 15.0),
          child: Text("Let's cook it!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              )),
        ),
        Expanded(
          child: FutureBuilder(
              future: _getRecipes(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {

                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if( snapshot.data == [] ) {return Container(
                  child: Center(
                    child: Text("No recipes found"),
                  ),
                );
                } else {

                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final recipe = snapshot.data[index];
                        return ChangeNotifierProvider<Recipe>.value(
                          notifier: recipe ,
                          child: Column(
                            children: <Widget>[
                              RecipeFlatCard(true),
                            ],
                          ),
                        );
                      });
                }
              }),
        ),
      ],
    );
  }
}
