import 'package:flutter/material.dart';


class SavedRecipesPage extends StatefulWidget {
  @override
  SavedRecipesPageState createState() => SavedRecipesPageState();
}

class SavedRecipesPageState extends State<SavedRecipesPage> {
  List<String> savedRecipes = ['hi','me,','do','hi','me,','do','hi','me,','do','hi','me,','do'];

  @override
  Widget build(BuildContext context) {
    return   Container(
      child: Center(
        child: Text(" chill .. Man at work"),
      ),
    );


  }
}
