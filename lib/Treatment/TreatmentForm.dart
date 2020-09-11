// Flutter code sample for TextFormField

// This example shows how to move the focus to the next field when the user
// presses the ENTER key.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'StateContainer.dart';
import 'package:farmapp/models/User.dart';
import 'package:farmapp/models/Treatment.dart';

class TreatmentForm extends StatefulWidget {
  TreatmentForm({Key key}) : super(key: key);

  @override
  _TreatmentFormState createState() => _TreatmentFormState();
}

class _TreatmentFormState extends State<TreatmentForm> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Treatment _data = new Treatment(DateTime.now(),{"irrigationSchedule":{}, "bedDim" : [0,0]},'');
  //String selectedCrop;
  //String selectedFreq;
  
  Widget freqDropdown() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(5.0))
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
            icon: Icon(Icons.arrow_downward),
            iconSize: 16,
            elevation: 0,
            style: TextStyle(color: Colors.black),
            value: this._data.features["irrigationSchedule"]["period"],
            //selectedFreq,
            onChanged: (String freq) {
              setState(() {
                  this._data.features["irrigationSchedule"]["period"] = freq;
                  //selectedFreq = freq;
              });
              
            },
            items: <String>['days', 'hours']
            .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
            })
            .toList(),
            hint: Text('Choose frequency')
          )
        )
      )
    );
}  

  Widget cropDropdown() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(5.0))
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
            icon: Icon(Icons.arrow_downward),
            iconSize: 16,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            value: this._data.features["cropType"],
            onChanged: (String newCrop) {
              setState(() {
                  this._data.features["cropType"] = newCrop;
                  // selectedCrop = newCrop;
              });
              
            },
            items: <String>['crop1', 'crop2', 'crop3']
            .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
            })
            .toList(),
            hint: Text('Select crop type')
          )
        )
      )
    ); 
  }   

  
  Widget build(BuildContext context) {

    final container = TreatmentStateContainer.of(context);
    final user = Provider.of<User>(context, listen: false);
    final siteN = user.siteN;
    final DateTime now = new DateTime.now();
    _data.dateofPlanting = DateTime(now.year, now.month, now.day);
    _data.siteId = user.siteId;
        
    return new Scaffold(
      appBar: new AppBar( title: new Text('Create new treatment')),
      body:  Material(
        child: Container(
          margin: EdgeInsets.fromLTRB(40, 10, 30, 10),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                child: Text(
                  "ENTER TREATMENT INFORMATION",
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
                  children: <Widget>[
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("Site"),
                        ),
                        
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: siteN,
                      ),
                      enabled: false
                    ),
                ]),
                SizedBox(height:30),
                    TextFormField(
                      decoration: new InputDecoration(
                        labelText: 'Treatment Name'
                      ),                        
                      onSaved: (String value) {
                        print(this._data.features);
                          this._data.features["treatmentName"] = value;
                        },
                      ),
                      SizedBox(height: 30),
                      InputDatePickerFormField(
                        initialDate: _data.dateofPlanting, 
                        firstDate: new DateTime(2010,1,1),
                        lastDate: new DateTime(2030,12,31),
                        fieldLabelText: "Enter date of planting",
                        onDateSaved: (DateTime newDate) => {this._data.dateofPlanting = newDate}
                      ),
                      SizedBox(height: 30),
                      cropDropdown(),
                      SizedBox(height: 30),
                      TextFormField(
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          labelText: 'Number of Planting Rows'
                        ),
                        onSaved: (String value) {
                          this._data.features["numberRows"] = int.parse(value);
                              },
                            ),
                        SizedBox(height: 30),
                        TextFormField(
                          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            labelText: 'Number of Planting Seeds'
                          ),
                          onSaved: (String value) {
                            this._data.features["numberSeeds"] = int.parse(value);
                          },
                        ),
                        SizedBox(height: 30),
                      
                        Row(
                          children: [
                            Container(
                              width: 150,
                              child: TextFormField(
                                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                  labelText: 'Irrigation Schedule'
                                ),
                                onSaved: (String value) {
                                  this._data.features["irrigationSchedule"]["times"] = int.parse(value);
                                },
                            )),
                            Expanded(child: Container(child:freqDropdown()))
                        ]),
                        SizedBox(height:40),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("Enter bed dimension in feet"),
                            ),
                            Row(
                              children: [
                                Container(
                              width: 100,
                              child: TextFormField(
                                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                  labelText: 'length(ft)'
                                ),
                                onSaved: (String value) {
                                  this._data.features["bedDim"][0] = int.parse(value);
                                },
                            )),
                            Text("   X   "),
                            Container(
                              width: 100,
                              child: TextFormField(
                                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                  labelText: 'width(ft)'
                                ),
                                onSaved: (String value) {
                                  this._data.features["bedDim"][1] = int.parse(value);
                                },
                              )
                            )
                      ])]
                    ),
                        SizedBox(height:40)
                        
                      
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
        onPressed: () {
          final form = _formKey.currentState;
           if (form.validate()) {
             container.addtoTreatmentList(
               this._data
            );
            Navigator.pop(context);
          } 
        },
      ),
    );
  }
}
 
