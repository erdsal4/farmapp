import 'package:flutter/material.dart';
import '../LoginPage.dart';
import '../main.dart';
import 'dart:convert' show json, base64, ascii;
import 'SiteSelection.dart';
import '../Treatment/StateContainer.dart';
import '../Treatment/SubmitTreatment.dart';

class MyInheritedWidget extends InheritedWidget {
  final String jwt;
  final Map<String, dynamic> payload;

  MyInheritedWidget({this.jwt, this.payload, Widget child}): super(child:child);
  
  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) => false;

  static MyInheritedWidget of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(MyInheritedWidget) as MyInheritedWidget);
}
  
}

class HomePage extends StatelessWidget {
  HomePage(this.jwt,this.payload);

  factory HomePage.fromBase64(String jwt) => 
    HomePage(
      jwt,
      json.decode(
        ascii.decode(
          base64.decode(base64.normalize(jwt.split(".")[1]))
        )
      )
    );  
  
  final String jwt;
  final Map<String, dynamic> payload;

  @override
  Widget build(BuildContext context){
   return new MyInheritedWidget(
    jwt: jwt,
    payload: payload,
    child: Scaffold(
      appBar: AppBar(title: Text("Secret Data Screen")),
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
                child: Text("Back to login screen"),
                onPressed: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(title: "FarmApp") 
                    )
                  )
                )
              ),
              SizedBox(height: 20),
              Container(
                width: 300.0,
                child: RaisedButton(
                child: Text("Add treatments"),
                onPressed: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TreatmentList()
                    )
                  )
                )
              )
              
              ]
            )
          ]
        )
    )
    )
  );
}

}

  
