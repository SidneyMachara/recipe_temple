import 'package:flutter/material.dart';


class ShoppingListPage extends StatefulWidget {
  @override
  ShoppingListPageState createState() => ShoppingListPageState();
}

class ShoppingListPageState extends State<ShoppingListPage> {
  List<String> shoppingList = ['hi','me,','do','hi','me,','do','hi','me,','do','hi','me,','do'];

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        itemCount: shoppingList.length,
        itemBuilder: (context, i) => Column(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),

              ),
              elevation: 3.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
              child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(width: 1.0,))),
                        child: Icon(Icons.autorenew,),
                      ),
                      title: Text(
                        "Introduction to Driving",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                      subtitle: Row(
                        children: <Widget>[
                          Icon(Icons.linear_scale, color: Colors.redAccent),
                          Text(" Intermediate", style: TextStyle())
                        ],
                      ),
                      trailing:
                      Icon(Icons.keyboard_arrow_right,size: 30.0))
              ),
            ),

          ],
        )
    );


  }
}
