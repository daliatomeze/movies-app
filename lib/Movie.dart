
import 'package:flutter/material.dart';


class Movie {

  final String image;
  final String title;
  final String year;
  final String Type;

  Movie(
      {required this.image, required this.title, required this.year, required this.Type});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      image: json["Poster"],
      title: json["Title"],
      year: json["Year"],
      Type: json["Type"],
    );
  }
}





class MovieItem extends StatelessWidget{

  final  Movie;
  MovieItem(
      {required this.Movie});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      height: 120,
      child: Card(
        child: Row(
          children: [
            Image.network(Movie.image),
            Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Movie.title, style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(Movie.year.toString()),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(Movie.Type),
                      ),
                      Icon(Icons.add)

                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );


  }

}