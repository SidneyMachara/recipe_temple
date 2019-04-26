import 'package:flutter/material.dart';
import 'package:recipe_temple/database/database.dart';

class ShoppingListPage extends StatefulWidget {
  @override
  ShoppingListPageState createState() => ShoppingListPageState();
}

class ShoppingListPageState extends State<ShoppingListPage> {
  List<String> shoppingList = [];

  @override
  void initState() {
    RecipeDatabase db = RecipeDatabase();
    db.suggestShoppingList().then((dbIngredients) {
      setState(() {
        shoppingList = dbIngredients;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 35.0, bottom: 15.0),
            child: Text("Shooping List",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                )),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: shoppingList.length,
                  itemBuilder: (context, i) => Column(
                        children: <Widget>[
                          Container(
                            margin: new EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 4.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                                color: Colors.white,
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.grey[300],
                                    blurRadius: 9.0,
                                  ),
                                ]),
                            child: ListTile(
//                      contentPadding: EdgeInsets.symmetric(
//                          horizontal: 20.0, vertical: 10.0),
                              leading: Container(
                                padding: EdgeInsets.only(right: 12.0),
                                decoration: new BoxDecoration(
                                    border: new Border(
                                        right: new BorderSide(
                                  width: 1.0,
                                ))),
                                child: Icon(
                                  Icons.fastfood,
                                  color: Colors.greenAccent,
                                ),
                              ),
                              title: Text(
                                shoppingList[i],
                                maxLines: 1,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ))),
        ],
      ),
    );
  }
}
