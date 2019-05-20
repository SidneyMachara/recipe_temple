import 'package:flutter/material.dart';
import 'package:recipe_temple/views/custom/recipe_flat_card.dart';
import 'package:provider/provider.dart';
import 'package:recipe_temple/states/SavedRecipesPool.dart';

import 'package:recipe_temple/database/database.dart';
import 'package:recipe_temple/models/Recipe.dart';
import 'package:recipe_temple/models/commonHelpers.dart';

class SavedRecipesPage extends StatefulWidget {
  @override
  SavedRecipesPageState createState() => SavedRecipesPageState();
}

class SavedRecipesPageState extends State<SavedRecipesPage> {
  @override
  Widget build(BuildContext context) {
    final savedRecipesPool = Provider.of<SavedRecipesPool>(context);

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
          child: ListView.builder(
            itemCount: savedRecipesPool.getSavedRecipesPool.length,
            itemBuilder: (BuildContext context, int index) {
              final recipe = savedRecipesPool.getSavedRecipesPool[index];

              return ChangeNotifierProvider<Recipe>.value(
                notifier: recipe,
                child: Column(
                    children: <Widget>[
                      RecipeFlatCard( false),
                    ],
                  ),
              );
  }
          ),
        ),
      ],
    );
  }
}
