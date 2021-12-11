import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Movie.dart';
import 'getData.dart';

class DetailsPage extends StatelessWidget {
  final String Title;

  DetailsPage({required this.Title});

  late Future<Movie> movieList;
  late Future<Movie> movies;
  Future<Movie> getData() {
    movieList = fetchMovie(this.Title);
    return movieList;
  }

  @override
  Widget build(BuildContext context) {
    List Genre=[];
    movies = getData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        backgroundColor: Colors.redAccent[700],
      ),
        body: Container(
      child: FutureBuilder<Movie>(
          future: movies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Movie Movies = snapshot.data!;

              Movie temp = Movies;
              return Column(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(Movies.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Center(
                            child:Text(Movies.title,style: TextStyle(fontWeight:FontWeight.bold ,fontSize: 20)),),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("error",style: TextStyle(color: Colors.white),);
            }

            return const CircularProgressIndicator();
          }),
    ));
  }
}
