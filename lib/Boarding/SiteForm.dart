// Flutter code sample for TextFormField

// This example shows how to move the focus to the next field when the user
// presses the ENTER key.
import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../providers/User.dart';
import '../providers/SiteProvider.dart';

class _SiteData {

  
  String name;
  String city;
  String state;
  Map<String, dynamic> location = {};

  Map<String, dynamic> toJson() =>
  {
    'name': name,
    'city': city,
    'state': state,
    'location': location
  };
  
}

class SiteForm extends StatefulWidget {
  SiteForm({Key key}) : super(key: key);

  @override
  _SiteFormState createState() => _SiteFormState();
}

class _SiteFormState extends State<SiteForm> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _SiteData _data = new _SiteData();
  
  void displayDialog(context, title, text) => showDialog(
    context: context,
      builder: (context) =>
      AlertDialog(
          title: Text(title),
          content: Text(text)
        ),
      );

  
  void siteSubmit(_SiteData data, String token) async {

    print("heresubmitting");
     final Map<String,String> headers = {
       "x-access-token": token,
       "Content-Type": "application/json"
     };
     print(jsonEncode(data));
     var res = await http.post(
       "$SERVER_DOMAIN/sites",
       body: jsonEncode(data),
       headers: headers
     );
     print(res.statusCode);
     print(res.body);
     if(res.statusCode != 200) {
        displayDialog(context, "An error occured", "Could not add the site.");
     };
   }
  
  Widget build(BuildContext context) {

    final token = Provider.of<User>(context, listen: false).token;
    final sites = Provider.of<SiteProvider>(context, listen: false);

    return new Scaffold(
      appBar: new AppBar( title: new Text('Add Site')),
      body:  Material(
        child: Container(
          margin: EdgeInsets.fromLTRB(40, 10, 30, 10),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                child: Text(
                  "ENTER SITE INFORMATION",
                  style: TextStyle(height: 5, fontSize: 20),
                )
              )
            ),
            Expanded(
              child: Shortcuts(
                shortcuts: <LogicalKeySet, Intent>{
            // Pressing enter on the field will now move to the next field.
            LogicalKeySet(LogicalKeyboardKey.enter): NextFocusIntent(),
          },
          child: FocusTraversalGroup(
            child: Form(
              key: this._formKey,
              autovalidate: true,
              onChanged: () {
                Form.of(primaryFocus.context).save();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListView(
                  children: <Widget>[                                                               TextFormField(
                      decoration: new InputDecoration(
                        labelText: 'Site Name'
                      ),                        
                      onSaved: (String value) {
                          _data.name = value;
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: 'Site State'
                        ),
                        onSaved: (String value) {
                          _data.state = value;
                              },
                            ),      
                          ]
                        )
                      )
                    )               
                  ),
                )
              )
            ]
          )
        )
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () async {
          final form = _formKey.currentState;
          if (form.validate()) {
            _data.city = "LA";
            _data.location = {
              "coordinates": [10,10]
            };
            await siteSubmit(_data, token);
            await sites.fetchSites(token);
            Navigator.pop(
                    context
                  );
          } 
        },
      ),
    );
  }
}
