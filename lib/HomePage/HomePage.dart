import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext build) {
    
    return new Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Container(
        margin: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Container(
              width: 400.0,
              height: 200.0,
              child: FittedBox(
                fit: BoxFit.contain,
                alignment: Alignment.topLeft,
                child: Text(' FARM\n APP'),
              )
            ),
            Container(
              width : 400.0,
              height: 400.0,
              child: 
              GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                menuItem(" View\n Treatments\n in\n Site"),
                menuItem(' Add\n Treatment\n to\n Site'),
                menuItem(' Change\n Site'),
                menuItem('Settings'),
              ],
            )
          )
          ]
        )
      )
    );
  }
}

Widget menuItem(String str) {

  return Container(
    child:
    FittedBox(
      fit: BoxFit.contain,
      child: Text(str),
    ),
    color: Colors.teal[100],
  );
  
}
