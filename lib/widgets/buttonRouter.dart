import 'package:flutter/material.dart';

Widget buttonRouter(String text, Widget page, BuildContext context){
  return Container(
    width: 300.0,
    child: RaisedButton(
      child: Text(text),
      onPressed: () =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page 
        )
      )
    )
  );

}
