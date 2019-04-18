import 'package:flutter/material.dart';
import 'package:recipe_temple/models/Recipe.dart';

class ViewRecipePage extends StatefulWidget {
  final Recipe recipe;

  ViewRecipePage(  this.recipe);

  @override
  ViewRecipePageState createState() => ViewRecipePageState();
}

class ViewRecipePageState extends State<ViewRecipePage> {


  @override
  Widget build(BuildContext context) {
    final Recipe recipe = widget.recipe;

    final ingredients = [];
//    for(){
//
//    }

    return Scaffold(
//        appBar: AppBar(
//          backgroundColor: Colors.green[400],
//        ),
        backgroundColor: Colors.white,
        body:CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.green[400],
              expandedHeight: 300.0,
              flexibleSpace: FlexibleSpaceBar(
                background:Image.network(
                   recipe.image,
                   fit: BoxFit.cover,
                 ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                      padding: EdgeInsets.all(10.0),
                  child: Text(recipe.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),textAlign: TextAlign.center,),
                  ),

                     ListTile(
                       leading: Icon(Icons.map),
                       title: Text('Map'),
                     ),
                     ListTile(
                       leading: Icon(Icons.photo_album),
                       title: Text('Album'),
                     ),
                     ListTile(
                       leading: Icon(Icons.phone),
                       title: Text('Phone'),
                     ),

             

                ],
              ),
            ),
          ],

        )
    );
  }
}
