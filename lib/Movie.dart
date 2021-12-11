
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'database-provider.dart';


class Movie {

  final String image;
  final String title;
  final String year;
  final String type;
  final String id;
  String rating = "";
  String plot = "";
  String writer = "";
  String director = "";
  String actor = "";
  String genre = "";
  bool added = false;

  Movie(
      {required this.id,required this.image, required this.title, required this.year, required this.type, required this.plot, required this.rating, required this.actor, required this.director, required this.writer, required this.genre});

  Movie.list(
      {required this.id,required this.image, required this.title, required this.year, required this.type,});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie.list(
      id:json["imdbID"],
      title: json["Title"],
      year: json["Year"],
      image: json["Poster"],
      type: json["Type"],

    );
  }

  factory Movie.details(Map<String, dynamic> json) {
    return Movie(
      id:json["imdbID"],
      title: json["Title"],
      year: json["Year"],
      image: json["Poster"],
      type: json["Type"],
      plot: json["Plot"],
      rating: json["Rated"],
      actor: json["Actors"],
      writer: json["Writer"],
      director: json["Director"],
      genre: json['Genre'],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imdbID':this.id,
      'Title': this.title,
      'Year': this.year,
      'Poster': this.image,
      'Type': this.type,

    };
  }


}