
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Exception.dart';
import 'Movie.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';

 Future <List<Movie>> fetchMovies(String value ,String type) async {
  final response = await http
    .get(Uri.parse('https://www.omdbapi.com/?${type}=${value}&apikey=17558978'));
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body);
    if (responseJson['Response'] == 'False') {

      try {
        toomuch(responseJson["Error"]);

      }
     on TooMuch{
        Fluttertoast.showToast(
            msg: "Enter a movie name longer than 3 char please! ",
          toastLength: Toast.LENGTH_LONG,
        );
      }
      try {
        invalidName(responseJson["Error"]);
      }
      on InvalidName {
        Fluttertoast.showToast(
            msg: "invalid name",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.green,

        );
      }


    }

      Iterable list;
      list = responseJson["Search"];
      return list.map((m) => Movie.fromJson(m)).toList();

  }

  else {

    try {
      backenderror(response.statusCode);
    }

    catch(e){
      Fluttertoast.showToast(
          msg: "$e",

      );
    }
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load movie');
  }
}

 Future<Movie> fetchMovie (String title)async{
   final response = await http
       .get(Uri.parse('https://www.omdbapi.com/?t=$title&plot=short&apikey=17558978'));
   print(response.statusCode);
   if (response.statusCode == 200) {
     final responseJson = jsonDecode(response.body) ;
   Movie movie =Movie.details(responseJson);
  return  movie;
   }

   else {

     try {
       backenderror(response.statusCode);
     }

     catch(e){
       Fluttertoast.showToast(
           msg: "$e",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );
     }
     // If the server did not return a 200 OK response,
     // then throw an exception.
     throw Exception('Failed to load movie');
   }
 }

 Future<Movie> fetchPlot (String title)async {
  final response = await http
      .get(Uri.parse('https://www.omdbapi.com/?t=$title&plot=full&apikey=17558978'));
  print(response.statusCode);
  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body);
    Movie movie = Movie.details(responseJson);
    return movie;
  }


  else {
    try {
      backenderror(response.statusCode);
    }

    catch(e){
      Fluttertoast.showToast(
          msg: "$e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load movie');
  }
}