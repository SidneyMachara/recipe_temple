import 'package:flutter/material.dart';
import 'package:recipe_temple/views/pantry.dart';
import 'package:recipe_temple/views/recipes.dart';
import 'package:recipe_temple/views/shopping_list.dart';
import 'package:recipe_temple/views/saved_recipes.dart';

import 'package:provider/provider.dart';
import 'package:recipe_temple/states/IngredientsPool.dart';




class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    PantryPage(),
    RecipesPage(),
    ShoppingListPage(),
    SavedRecipesPage()
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => IngredientsPool(),
      child: Scaffold(
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
                  icon: Icon(Icons.save), title: Text('Saved'))
            ],
          ),
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
