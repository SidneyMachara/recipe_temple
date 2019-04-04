import 'package:flutter/material.dart';

class ViewPage extends StatefulWidget {
  @override
  ViewPageState createState() => ViewPageState();
}

class ViewPageState extends State<ViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[400],
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
                height: 300,
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg',
                  fit: BoxFit.fill,
                )),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text("Meat Roll",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  )),
            ),
            Expanded(
                child:ListView(
                  children: <Widget>[
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
        ));
  }
}
