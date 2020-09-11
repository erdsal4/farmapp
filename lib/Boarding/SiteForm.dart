// Flutter code sample for TextFormField

// This example shows how to move the focus to the next field when the user
// presses the ENTER key.
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';

import '../main.dart';
import './BoardingPage.dart';
import '../models/User.dart';
import 'package:farmapp/models/Site.dart';

class SiteForm extends StatefulWidget {
  SiteForm({Key key}) : super(key: key);

  @override
  _SiteFormState createState() => _SiteFormState();
}

class _SiteFormState extends State<SiteForm> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Site _site = new Site();
//  List<double> coordinates = [0,0]; 
  
  Widget build(BuildContext context) {

    
    final token = Provider.of<User>(context, listen: false).token;
    
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
                  LogicalKeySet(LogicalKeyboardKey.enter):NextFocusIntent(),
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
                          _site.name = value;
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: 'Site State'
                        ),
                        onSaved: (String value) {
                          _site.state = value;
                              },
                            ),
                            SizedBox(height: 30),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: 'Site City'
                        ),
                        onSaved: (String value) {
                          _site.city = value;
                              },
                       ),

   /*                    Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("Site Location"),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  child: TextFormField(
                                    inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,5}'))],
                                    keyboardType: TextInputType.number,       
                                    initialValue: coordinates[0].toString(),
                                    onSaved: (String value) {
                                      coordinates[0] = double.parse(value);
                                    },
                                )),
                            Text("   X   "),
                            Container(
                              width: 50,
                              child: TextFormField(
                                inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,5}'))],
                                keyboardType: TextInputType.number,
                                initialValue: coordinates[1].toString(),
                                onSaved: (String value) {
                                  coordinates[1] = double.parse(value);
                                },
                              )
                            ),
                            Expanded(
                              child: Container(
                                child: RaisedButton(
                                  child: Text("Get location automatically"),
                                  onPressed: () async {
                                  Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                                  setState(() => {
                                      coordinates[0] = position.longitude;
                                      coordinates[1] = position.latitude;
                                    }
                                  );
                                }
                              )
                            ),
                          )
                      ])
                    ]), */
      
                      ]
                    )
                  )
                    )
                  )
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
            _site.location = {
              "coordinates": [10,10]
            };
            await submitSite(_site, token, context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BoardingPage() 
              )  
            );
          } 
        },
      ),
    );
  }
}
