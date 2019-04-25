import 'package:flutter/material.dart';
import 'package:recipe_temple/views/pantry.dart';
import 'package:recipe_temple/views/recipes.dart';
import 'package:recipe_temple/views/shopping_list.dart';
import 'package:recipe_temple/views/saved_recipes.dart';

import 'package:recipe_temple/database/database.dart';
import 'package:recipe_temple/models/Ingredient.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [PantryPage(), RecipesPage(), ShoppingListPage(), SavedRecipesPage()];

  String newIngredient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
//      appBar: AppBar(
//        title: Text(''),
//      ),
        body: _children[_currentIndex],

        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.white,
          ),
          child: BottomNavigationBar(

            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.green[500],

            onTap: onTabTapped,
            currentIndex: _currentIndex,
            // this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text('Pantry'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.fastfood),
                title: new Text('Recipes'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text('Shopping List'),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.save),
                  title: Text('Saved')
              )
            ],
          ),

        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          return showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: new Text("Add Ingredient to pantry"),
                content: new Row(
                  children: <Widget>[
                    new Expanded(
                        child: new TextField(
                          autofocus: true,
                          decoration: new InputDecoration(
                              labelText: 'Ingredient', hintText: 'eg. yum yum'),
                          onChanged: (value) {
                            newIngredient = value;


                          },
                        ))
                  ],
                ),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("ADD"),
                    onPressed: () {
                      Scaffold.of(context).setState((){
                        savedIngredient();
                      });


                      Navigator.of(context).pop();


                    },
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.green[300],
        child: Icon(Icons.add,),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
      )
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void savedIngredient(){
    RecipeDatabase db = RecipeDatabase();
    db.addIngredient(Ingredient(newIngredient, 1 )).then((dbIngredients) {
      setState(() {  });
    });
  }
}


