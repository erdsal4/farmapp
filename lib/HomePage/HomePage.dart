import 'package:flutter/material.dart';
import 'package:farmapp/Treatment/ViewTreatments.dart';
import 'package:farmapp/Treatment/SubmitTreatment.dart';
import 'package:farmapp/Boarding/BoardingPage.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
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
                child: Text(' Farm\n App'),
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
                menuItem(" View\n Treatments\n in\n Site", context, ViewPage()),
                menuItem(' Add\n Treatment\n to\n Site', context, SubmitTreatmentList()),
                menuItem(' Change\n Site', context, BoardingPage()),
                menuItem('Settings', context, BoardingPage()),
              ],
            )
          )
          ]
        )
      )
    );
  }
}

Widget menuItem(String str, BuildContext context, Widget page) {


  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page
        )
      );
    },
    child: Container(
      alignment : Alignment.centerLeft,
      padding : EdgeInsets.all(10.0),
      child: Text(str,
        style: TextStyle(fontSize: 20.0),
      ),
      color: Colors.teal[100],
    )
  );
  
}
