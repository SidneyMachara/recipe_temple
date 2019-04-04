import 'package:flutter/material.dart';
import 'package:recipe_temple/views/view_recipe.dart';

class RecipesPage extends StatefulWidget {
  @override
  RecipesPageState createState() => RecipesPageState();
}

class RecipesPageState extends State<RecipesPage> {
  List<String> recipes = [
    'hi',
    'me,',
    'do',
    'hi',
    'me,',
    'do',
    'hi',
    'me,',
    'do',
    'hi',
    'me,',
    'do',
    'hi',
    'me,',
    'do',
    'hi',
    'me,',
    'do',
    'hi',
    'me,',
    'do',
    'hi',
    'me,',
    'do'
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 35.0 ,bottom: 15.0),
          child: Text("Let's cook it!",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          )),),
        Expanded(
            child:ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, i) => Column(
                  children: <Widget>[

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.0, vertical: 20.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 4.0),
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 9.0,
                            ),
                          ]),
                      child: ListTile(
                          leading: ClipRRect(
                              borderRadius: new BorderRadius.circular(20.0),
                              child: Image.network(
                                'https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg',
                                fit: BoxFit.fill,
                                width: 160,
                                height: 110,
                              )),
                          title: InkWell(
                            child: Text(
                              "Egg meat roll",
                              style: TextStyle(fontWeight: FontWeight.bold),maxLines: 2,
                            ),
                            onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) => new ViewPage())),
                          ),
                          subtitle: Row(

                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(top: 30.0),
                                  padding: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
//                                  border: Border.all(color: Colors.white, width: 4.0),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                                    color: Colors.green[50],
                                  ),
                                  child: Text(" 11/11",
                                      style: TextStyle(color: Colors.green[400]))),
                              Container(
                                  margin: EdgeInsets.only(top: 30.0),
                                  child: Text(" Pantry match", style: TextStyle())
                              ),


                            ],
                          )),
                    ),
                  ],
                )),
        ),
      ],
    );
  }
}
