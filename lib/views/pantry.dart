import 'package:flutter/material.dart';
import 'package:recipe_temple/models/Ingredient.dart';
import 'package:recipe_temple/database/database.dart';
import 'package:recipe_temple/models/commonHelpers.dart';

class PantryPage extends StatefulWidget {
  @override
  PantryPageState createState() => PantryPageState();
}

class PantryPageState extends State<PantryPage> {
  List<Ingredient> ingredients = List();
  String newIngredient;

  @override
  void initState() {
    super.initState();

    _setIngredients();
  }

  void _setIngredients() {
    RecipeDatabase db = RecipeDatabase();
    db.getIngredients().then((dbIngredients) {
      setState(() => ingredients = dbIngredients);
    });
  }

  void saveIngredient() {
    RecipeDatabase db = RecipeDatabase();
    db.addIngredient(Ingredient(newIngredient, 1)).then((dbIngredients) {
      setState(() {
        _setIngredients();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool use = true;
//    void useInRecipe(bool value) => setState(() => use = value);
    void alertSaved() {
      Scaffold.of(context).setState(() {
        CommonHelpers().showToast(context, "Ingredient Saved");
      });
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 35.0, bottom: 15.0),
            child: Text("Pantry",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                )),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: ingredients.length,
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
                                  ingredients[i].name,
                                  maxLines: 1,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                subtitle: Row(
                                  children: <Widget>[
                                    Switch(
                                      value: ingredients[i].use == 1
                                          ? use = true
                                          : use = false,
                                      onChanged: (bool value) {
                                        RecipeDatabase db = RecipeDatabase();

                                        db
                                            .toggleUseIngredient(
                                                ingredients[i].id,
                                                ingredients[i].use == 1 ? 0 : 1)
                                            .then((dbIngredients) {
                                          setState(() {
                                            use = value;
                                          });
                                        });
                                      },
                                    ),
                                    Text(" Use in recipe search",
                                        style: TextStyle())
                                  ],
                                ),
                                trailing: InkWell(
                                  child: Icon(Icons.delete, size: 20.0),
                                  onTap: () {
                                    RecipeDatabase db = RecipeDatabase();
                                    db
                                        .deleteIngredient(ingredients[i].id)
                                        .then((dbIngredients) {
                                      setState(() {
                                        _setIngredients();
                                        CommonHelpers().showToast(
                                            context, "Ingredient Deleted");
                                      });
                                    });
                                  },
                                )),
                          ),
                        ],
                      ))),
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
                      alertSaved();

                      saveIngredient();
                      Navigator.of(context).pop();
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
