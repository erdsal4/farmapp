import 'package:flutter/material.dart';
import 'package:farmapp/LoginPage.dart';
import 'package:farmapp/main.dart';
import 'SiteSelection.dart';
import 'SiteForm.dart';

import 'package:farmapp/HomePage/HomePage.dart';

class BoardingPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Select your site")),
      body: Container(
        margin: EdgeInsets.fromLTRB(10.0, 100.0, 10.0, 100.0),
        padding: EdgeInsets.all(16),
        child: Column(
        children: <Widget>[
          Expanded(
           child: SiteSelection()
          ),
          Column(
            children: <Widget>[
              
              Container(
                width: 300.0,
                child: RaisedButton(
                child: Text("Save and go to Home Page"),
                onPressed: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage()
                    )
                  )
                )
              ),
              SizedBox(height: 20),
              Container(
                width: 300.0,
                child: RaisedButton(
                  child: Text("Add new Site"),
                  onPressed: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SiteForm()
                    )
                  )
                  )
                ),
              SizedBox(height: 20),
              Container(
                width: 300.0,
                child: RaisedButton(
                child: Text("Back to login screen"),
                onPressed: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage() 
                    )
                  )
                )
              ),
              
            ]
            )
          ]
        )
      )
    );
}

}

  
