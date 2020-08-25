import 'package:flutter/material.dart';
import 'StateContainer.dart';
import 'TreatmentForm.dart';


class TreatmentList extends StatefulWidget {

  @override
  TreatmentListState createState() => new TreatmentListState(); 

  
}

class TreatmentListState extends State<TreatmentList> {

  List<Treatment> treatments;  

  Widget get _currentTreatments {
    return new ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: treatments.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
           leading: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {},
            child: Container(
              width: 48,
              height: 48,
              padding: EdgeInsets.symmetric(vertical: 4.0),
              alignment: Alignment.center,
              child: Icon(Icons.edit),
            ),
          ),
            title: Text('Treatment Name: ${treatments[index].features["treatmentName"]}'),
            dense: false
          );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider()
    );
  }
    
  void _treatmentForm(BuildContext context) {
    print("treatmentform");
    Navigator.push(
      context,
      new MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return new TreatmentForm();
        },
      ),
    );
  }
  

  Widget get treatmentFormTile {
    return ListTile(
          leading: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => _treatmentForm(context),
            child: Container(
              width: 48,
              height: 48,
              padding: EdgeInsets.symmetric(vertical: 4.0),
              alignment: Alignment.center,
              child: Icon(Icons.add),
            ),
          ),
          title: Text('Click to add new treatment'),
          dense: false,
        );
      }

  @override
  Widget build(BuildContext context) {
    final container = TreatmentStateContainer.of(context);
    treatments = container.treatments;
    // print(treatments.length.toString());
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Inherited Widget Test'),
      ),
      body:
     Container(
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[            
            (treatments != null ? _currentTreatments : Text("No treatment added")),
            treatmentFormTile,
          ]
        )
      ), 
        
          floatingActionButton: new FloatingActionButton(
            child: new Icon(Icons.add),
            onPressed: () {
              _treatmentForm(context); 
            }
          )

    );
  } 
  
}
