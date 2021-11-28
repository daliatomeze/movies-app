 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{

  final bool first ;
  HomePage({required  this.first});


  @override
  Widget build(BuildContext context) {
    if (!first) {
      return AlertDialog(
        title: Text('please Enter a valid movie name!'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context, false), // passing false
            child: Text('ok'),
          ),

        ],

      );
    }

    else {
      return Text("Search");
    }


  }
}
 
 
  