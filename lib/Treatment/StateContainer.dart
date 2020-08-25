import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Treatment {

  DateTime dateofPlanting;
    
  Map<String, dynamic> features = {};

  Treatment(this.dateofPlanting, this.features);
  
}

class TreatmentStateContainer extends StatefulWidget {

  final Widget child;
  final List<Treatment> treatments;

  TreatmentStateContainer({
    @required this.child,
    this.treatments,
  });

  static TreatmentStateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedTreatmentStateContainer)
            as _InheritedTreatmentStateContainer)
        .data;
  }

  @override
  TreatmentStateContainerState createState() => new TreatmentStateContainerState();
}

class TreatmentStateContainerState extends State<TreatmentStateContainer> {

  List<Treatment> treatments;

  void addtoTreatmentList({DateTime dateofPlanting,
	    String treatmentName,
      String cropType,
      num numberRows,
      num numberSeeds,
      Map<String, dynamic> irrigationSchedule,
	    List<num> bedDim	
  }) {
    Map<String, dynamic> features = {
      "treatmentName": treatmentName,
      "cropType": cropType,
      "numberRows": numberRows,
      "numberSeeds": numberSeeds,
      "irrigationSchedule": irrigationSchedule,
      "bedDim": bedDim
    };
    Treatment treatment = new Treatment(dateofPlanting, features);

    if (treatments == null) {
      setState(() {
          treatments = <Treatment>[treatment];
      });
    } else {
    
    print(treatment);
    setState(() {
        treatments.add(treatment);
    });
    print(treatments);
  }
}
  @override
  Widget build(BuildContext context) {
    return new _InheritedTreatmentStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedTreatmentStateContainer extends InheritedWidget {
  final TreatmentStateContainerState data;

  _InheritedTreatmentStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedTreatmentStateContainer old) => true;
}
