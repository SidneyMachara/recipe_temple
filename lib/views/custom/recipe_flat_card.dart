import 'package:flutter/material.dart';
import 'package:recipe_temple/views/view_recipe.dart';
import 'package:recipe_temple/states/SavedRecipesPool.dart';

import 'package:recipe_temple/models/commonHelpers.dart';
import 'package:provider/provider.dart';

import 'package:recipe_temple/models/Recipe.dart';

class RecipeFlatCard extends StatelessWidget {
  final isOnline;

//  final VoidCallback _onLongPress;

  RecipeFlatCard(this.isOnline);

  @override
  Widget build(BuildContext context) {
    Recipe recipe = Provider.of<Recipe>(context);

    return InkWell(
      splashColor: Colors.green[400],
      highlightColor: Colors.white,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 1.0, vertical: 20.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 4.0),
            borderRadius: BorderRadius.all(Radius.circular(18)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 9.0,
              ),
            ]),
        child: ListTile(
            leading: ClipRRect(
                borderRadius: new BorderRadius.circular(20.0),
                child: Image.network(
                  recipe.image,
                  fit: BoxFit.fill,
                  width: 160,
                  height: 110,
                )),
            title: Text(
              recipe.name,
              style: TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
            ),
            subtitle: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 30.0),
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
//                                  border: Border.all(color: Colors.white, width: 4.0),
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      color: Colors.green[50],
                    ),
                    child: Text(" 11/11",
                        style: TextStyle(color: Colors.green[400]))),
                Container(
                    margin: EdgeInsets.only(top: 30.0),
                    child: Text(" Pantry match", style: TextStyle())),
              ],
            )),
      ),
      onDoubleTap: () {
        if (isOnline) {
          recipe.saveRecipe();
          CommonHelpers().showToast(context, "Recipe saved");
        } else {
          Provider.of<SavedRecipesPool>(context).unSaveRecipe(recipe);
          CommonHelpers().showToast(context, "Recipe Removed");
        }
      },

      onTap: () => Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (BuildContext context) => new ViewRecipePage(recipe),
            ),
          ),
//      onLongPress: _onLongPress,
    );
  }
}
