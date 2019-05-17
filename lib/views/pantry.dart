import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:recipe_temple/models/Ingredient.dart';
import 'package:recipe_temple/models/commonHelpers.dart';

import 'package:recipe_temple/states/IngredientsPool.dart';

class PantryPage extends StatefulWidget {
  @override
  PantryPageState createState() => PantryPageState();
}

class PantryPageState extends State<PantryPage> {
  String newIngredient;

  @override
  Widget build(BuildContext context) {
    bool use = true;

    void alert(String msg) {
      Scaffold.of(context).setState(() {
        CommonHelpers().showToast(context, msg);
      });
    }

    final pantry = Provider.of<IngredientsPool>(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 35.0, bottom: 15.0),
            child: Text(
              "Pantry",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: pantry.getIngredientsList.length,
            itemBuilder: (context, i) {
              var ingredient = pantry.getIngredientsList[i];

              return ChangeNotifierProvider<Ingredient>.value(
                notifier: ingredient,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
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
                      child: ListTile(
//                      contentPadding: EdgeInsets.symmetric(
//                          horizontal: 20.0, vertical: 10.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                            border: new Border(
                              right: new BorderSide(
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Icon(
                            Icons.fastfood,
                            color: Colors.greenAccent,
                          ),
                        ),
                        title: Text(
                          ingredient.name,
                          maxLines: 1,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                        subtitle: Row(
                          children: <Widget>[
                            Switch(
                              value: ingredient.use == 1
                                  ? use = true
                                  : use = false,
                              onChanged: (bool value) {
                                ingredient.toggleUseIngredient(
                                    ingredient.id, ingredient.use == 1 ? 0 : 1);
                              },
                            ),
                            Text(" Use in recipe search", style: TextStyle())
                          ],
                        ),
                        trailing: InkWell(
                          child: Icon(Icons.delete, size: 20.0),
                          onTap: () {
                            pantry.deleteIngredient(ingredient.id);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
                      pantry.saveIngredient(newIngredient);

                      Navigator.of(context).pop();
                      alert("Ingredient Saved");
                    },
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.green[300],
        child: Icon(
          Icons.add,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
      ),
    );
  }
}
