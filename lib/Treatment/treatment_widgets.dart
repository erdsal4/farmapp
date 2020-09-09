import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:farmapp/models/Treatment.dart';
import 'package:farmapp/main.dart';

Widget treatmentsList(List<Treatment> treatments, bool view) {
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
              child: view ? Icon(Icons.view_comfy) : Icon(Icons.edit),
            ),
          ),
            title: Text('Treatment Name: ${treatments[index].features["treatmentName"]}'),
            dense: false
          );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider()
    );
  }
  
  Future<List<Treatment>> fetchTreatments(jwt, siteId) async {

    print("fetchingtreatments");
    final Map<String,String> headers = {
      "x-access-token": jwt,
      "Content-Type": "application/json"
    };
    final response = await http.get("https://www.farmsoilmoisture.tk/mobile/treatments/dropdown/${siteId}", headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      Iterable l = json.decode(response.body);
      return List<Treatment>.from(l.map((i) => Treatment.fromJson(i)));
    } else {
      return List<Treatment>();
    }
    
  }
