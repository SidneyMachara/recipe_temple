import 'package:flutter/material.dart';
import 'package:recipe_temple/models/Recipe.dart';


class ViewRecipePage extends StatefulWidget {
  final Recipe recipe;

  ViewRecipePage(this.recipe);

  @override
  ViewRecipePageState createState() => ViewRecipePageState();
}

class ViewRecipePageState extends State<ViewRecipePage> {
  @override
  Widget build(BuildContext context) {
    final Recipe recipe = widget.recipe;

    return Scaffold(

      backgroundColor: Colors.white,
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.green[400],
              expandedHeight: 300.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  recipe.image,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(recipe.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 22.0),),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text(
                      "Ingredients",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.0),
                    ),
                  ],
                ),
              ),
            ),
            IngredientsListWidget(recipe.getIngredients),
            SliverPadding(
              padding: EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text(
                      "Instructions",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.0),
                    ),
                  ],
                ),
              ),
            ),
            InstructionsListWidget(recipe.getInstructions)
          ],
        ),
      ),
    );
  }
}

class IngredientsListWidget extends StatelessWidget {
  final List<String> ingredientsList;

  IngredientsListWidget(this.ingredientsList);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ListTile(
            title: Text(ingredientsList[index]),
          );
        },
        childCount: ingredientsList.length,
      ),
    );
  }
}

class InstructionsListWidget extends StatelessWidget {
  final List instructionsList;

  InstructionsListWidget(this.instructionsList);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: <Widget>[
//                Padding(padding: EdgeInsets.only(top: 40.0)),
              Container(
                  margin: new EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 4.0),
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.grey[300],
                          blurRadius: 9.0,
                        ),
                      ]),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: new BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18)),
                          child: Image.network(
                            instructionsList[index].imageUrl,
                            fit: BoxFit.fill,
                          )),
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      Text(
                        "Step " + instructionsList[index].number.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22.0),
                      ),
                      ListTile(
                        title: Text(
                          instructionsList[index].stepText,
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ))
            ],
          );
        },
        childCount: instructionsList.length,
      ),
    );
  }
}
