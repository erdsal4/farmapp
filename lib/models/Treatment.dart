import 'dart:collection';
import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'package:farmapp/widgets/displayDialog.dart';

class Treatment {

  String siteId;
  DateTime dateofPlanting;
    
  Map<String, dynamic> features = {
/*    "treatmentName": '',
    "cropType": '',
    "numberRows": 0,
    "numberSeeds": 0,
    "irrigationSchedule": {
      "times": 0,
      "period": ''
    },
   "bedDim": List<num>() */
  };

  Treatment([this.dateofPlanting, this.features , this.siteId]);

  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      json['dateofPlanting'],
      json['features'],
      json['site']
    );
  }

  Map<String,dynamic> toJson(){

    return {
        "site": this.siteId,
        "dateofPlanting": this.dateofPlanting.toIso8601String(),
        "features": this.features,
    };
  }
  
}

void submitTreatments(List<Treatment> treatments, String token, BuildContext context) async {

  print("submittingtreatments");
  final Map<String,String> headers = {
    "x-access-token": token,
    "Content-Type": "application/json"
  };
  print(treatments.first.dateofPlanting);
  String json = jsonEncode(treatments.first);
  //String json = jsonEncode(treatments.map((i) => i.toJson()).toList()).toString();
  print(json);
  var res = await http.post(
    "$SERVER_DOMAIN/treatments",
    body: json,
    headers: headers
     );
     print(res.statusCode);
     print(res.body);
     if(res.statusCode != 200) {
        displayDialog(context, "An error occured", "Could not add the treatments.");
     };

}
