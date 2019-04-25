import 'package:flutter/material.dart';
import 'package:recipe_temple/views/custom/recipe_flat_card.dart';
import 'package:recipe_temple/database/database.dart';
import 'package:recipe_temple/models/Recipe.dart';


class SavedRecipesPage extends StatefulWidget {
  @override
  SavedRecipesPageState createState() => SavedRecipesPageState();
}

class SavedRecipesPageState extends State<SavedRecipesPage> {


  Future<List<Recipe>> _getSavedRecipes() async {

    List<Recipe> savedRecipes = [];

    RecipeDatabase db =  RecipeDatabase();
    await db.getSavedRecipes().then((dbIngredients) {

      savedRecipes = dbIngredients;

    });
    return savedRecipes;
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 35.0, bottom: 15.0),
          child: Text("Saved Recipes",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              )),
        ),
        Expanded(
          child: FutureBuilder(
              future: _getSavedRecipes(),
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
                          RecipeFlatCard(snapshot, index),
                        ],
                      ));
                }
              }),
        ),
      ],
    );
  }
}
