import 'package:flutter/material.dart';
import 'LoginPage.dart';
import './HomePage/HomePage.dart';
import 'main.dart';
import './Treatment/StateContainer.dart';
import './Treatment/SubmitTreatment.dart';
import 'dart:convert' show json, base64, ascii;


class MyApp extends StatelessWidget {

  final String title = "FarmApp";
  
  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if(jwt == null) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return new TreatmentStateContainer(
      child: MaterialApp(
      title: 'FarmApp Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FutureBuilder(
        future: jwtOrEmpty,            
        builder: (context, snapshot) {
          if(!snapshot.hasData) return CircularProgressIndicator();
          if(snapshot.data != "") {
            var str = snapshot.data;
            var jwt = str.split(".");
            
            if(jwt.length !=3) {
              return LoginPage(title: title);
            } else {
              var payload = json.decode(ascii.decode(base64.decode(base64.normalize(jwt[1]))));
              if(DateTime.fromMillisecondsSinceEpoch(payload["exp"]*1000).isAfter(DateTime.now())) {
                return HomePage(str, payload);
              } else {
                return LoginPage(title:title);
              }
            }
          } else {
            return LoginPage(title:title);
          }
        }
      ), 
  ));
  }
}
