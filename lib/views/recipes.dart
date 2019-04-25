import 'package:flutter/material.dart';
import 'package:recipe_temple/views/view_recipe.dart';
import 'package:recipe_temple/models/Recipe.dart';
//import 'package:recipe_temple/models/Ingredient.dart';
import 'package:recipe_temple/database/database.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipesPage extends StatefulWidget {
  @override
  RecipesPageState createState() => RecipesPageState();
}

class RecipesPageState extends State<RecipesPage> {

  Future<String> _getUsableIngredients() async {

    String ingredients = '?ingredients=';

    RecipeDatabase db =  RecipeDatabase();
    await db.getIngredientsToUse().then((dbIngredients) {
      String ingred;
      for(var ingredient in dbIngredients){
        ingred = ingredient.name ;
        ingredients = ingredients + ingred  +',';

      }

    });
    return ingredients.substring(0, ingredients.length - 1);
  }

  Future<List<Recipe>> _getRecipes() async {

    String ingredients = await _getUsableIngredients();
    print("http://146d445a.ngrok.io/api/recipes/recipe_search$ingredients");
    var data =
        await http.get("http://146d445a.ngrok.io/api/recipes/recipe_search$ingredients");

    var jsonData = json.decode(data.body);

    List<Recipe> recipes = [];

    for (var rec in jsonData['data']) {
      Recipe recipe = Recipe(
          rec['name'], rec['cook_time'], rec['serves'], rec['image_link'], rec['ingredients'], rec['instructions']);
      recipes.add(recipe);
    }

    print("http://146d445a.ngrok.io/api/recipes/recipe_search$ingredients");

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
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) => Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 1.0, vertical: 20.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 4.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 9.0,
                                      ),
                                    ]),
                                child: ListTile(
                                    leading: ClipRRect(
                                        borderRadius:
                                            new BorderRadius.circular(20.0),
                                        child: Image.network(
                                          snapshot.data[index].image,
                                          fit: BoxFit.fill,
                                          width: 160,
                                          height: 110,
                                        )),
                                    title: InkWell(
                                      child: Text(
                                        snapshot.data[index].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                      ),
                                      onTap: () => Navigator.of(context).push(
                                            new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new ViewRecipePage(
                                                      snapshot.data[index]),
                                            ),
                                          ),
                                    ),
                                    subtitle: Row(
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.only(top: 30.0),
                                            padding: EdgeInsets.all(2.0),
                                            decoration: BoxDecoration(
//                                  border: Border.all(color: Colors.white, width: 4.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(18)),
                                              color: Colors.green[50],
                                            ),
                                            child: Text(" 11/11",
                                                style: TextStyle(
                                                    color: Colors.green[400]))),
                                        Container(
                                            margin: EdgeInsets.only(top: 30.0),
                                            child: Text(" Pantry match",
                                                style: TextStyle())),
                                      ],
                                    )),
                              ),
                            ],
                          ));
                }
              }),
        ),
      ],
    );
  }
}


