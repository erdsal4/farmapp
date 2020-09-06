// Flutter code sample for TextFormField

// This example shows how to move the focus to the next field when the user
// presses the ENTER key.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'StateContainer.dart';


class _TreatmentData {

  DateTime dateofPlanting;
    
  Map<String, dynamic> features = {};
  
}

class TreatmentForm extends StatefulWidget {
  TreatmentForm({Key key}) : super(key: key);

  @override
  _TreatmentFormState createState() => _TreatmentFormState();
}

class _TreatmentFormState extends State<TreatmentForm> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _TreatmentData _data = new _TreatmentData();
  
  Widget build(BuildContext context) {
    print("hello");
    final container = TreatmentStateContainer.of(context);
    print(container);
    return new Scaffold(
      appBar: new AppBar( title: new Text('Add treatment')),
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
                  children: <Widget>[                                                               TextFormField(
                      decoration: new InputDecoration(
                        labelText: 'Treatment Name'
                      ),                        
                      onSaved: (String value) {
                          this._data.features["treatmentName"] = value;
                        },
                      ),
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
              dateofPlanting: new DateTime.now(),
              treatmentName: this._data.features["treatmentName"],
              cropType: "corn",
              numberRows: this._data.features["numberRows"],
              numberSeeds: 33,
              irrigationSchedule: {
                "times": 2,
                "period": 'days'
              },
	            bedDim: [30,30]
            );
            Navigator.pop(context);
          } 
        },
      ),
    );
  }
}
