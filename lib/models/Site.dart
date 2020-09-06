import 'package:flutter/material.dart';

class Site {

 // @JsonKey(name: '_id')  
  
  final String name;
//  final String id;

  const Site({this.name});

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
      name: json['name'],
     // id: json['_id']
    );
  }
  
  
}
