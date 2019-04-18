import 'package:flutter/material.dart';


class ShoppingListPage extends StatefulWidget {
  @override
  ShoppingListPageState createState() => ShoppingListPageState();
}

class ShoppingListPageState extends State<ShoppingListPage> {
  List<String> shoppingList = ['hi','me,','do','hi','me,','do','hi','me,','do','hi','me,','do'];

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Center(
        child: Text(" chill .. Man at work"),
      ),
    );

  }
}
