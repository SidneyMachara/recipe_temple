import 'package:flutter/material.dart';
import 'package:recipe_temple/views/main_page.dart';


class LandingPage extends StatefulWidget {
  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
      onTap: () => Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new MainPage())),
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/l1.jpg'), fit: BoxFit.fill),
        ),
      ),
    ));
  }
}
