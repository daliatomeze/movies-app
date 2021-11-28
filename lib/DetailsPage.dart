
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Movie.dart';
import 'getData.dart';
class DetailsPage extends  StatelessWidget {
  final String Title;

  DetailsPage({required this.Title});

  late Future <Movie> movieList;
  late Future <Movie> movies;
  Future <Movie> getData() {
    movieList = fetchMovie(this.Title);
    return movieList;
  }

  @override
  Widget build(BuildContext context) {
    movies=getData();
    return Scaffold(
        body:Container(
          child:  FutureBuilder<Movie>(
              future: movies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                Movie Movies = snapshot.data! ;
                  Movie temp =Movies;
                  return MovieItem( Movie: temp,);
                }
                else if(snapshot.hasError){
                  return Text("error");

                }

                return const CircularProgressIndicator();
              }

          ),
        )

    );
  }
}