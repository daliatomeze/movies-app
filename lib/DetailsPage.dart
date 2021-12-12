import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Movie.dart';
import 'getData.dart';

class DetailsPage extends StatefulWidget {
  final String Title;

  DetailsPage({required this.Title});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Future<Movie> movieList;

  late Future<Movie> movies;

  //return movie with short plot
  Future<Movie> getData() {
    movieList = fetchMovie(this.widget.Title);
    return movieList;
  }

//return movie with full plot
  getplot() {
    setState(() {
      movies = fetchPlot(this.widget.Title);
    });
  }

  void initState() {
    super.initState();
    movies = getData();
  }

  @override
  Widget build(BuildContext context) {
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
                                child: Text(Movies.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ),
                              Expanded(
                                child: ListView(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text('Year'),
                                      subtitle: Text(Movies.year),
                                    ),
                                    ListTile(
                                      title: Text('Type'),
                                      subtitle: Text(Movies.type),
                                    ),
                                    ListTile(
                                      title: Text('rating'),
                                      subtitle: Text(Movies.rating),
                                    ),
                                    ListTile(
                                      title: Text('Writer'),
                                      subtitle: Text(Movies.writer),
                                    ),
                                    ListTile(
                                      title: Text('director'),
                                      subtitle: Text(Movies.director),
                                    ),
                                    ListTile(
                                      title: Text('Actors'),
                                      subtitle: Text(Movies.actor),
                                    ),
                                    ListTile(
                                      title: Text('Plot'),
                                      subtitle: Text(Movies.plot),
                                      onTap: () {
                                        print(Movies.plot);
                                        getplot();
                                        print(Movies.plot);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    "error",
                    style: TextStyle(color: Colors.white),
                  );
                }

                return const CircularProgressIndicator();
              }),
        ));
  }
}
