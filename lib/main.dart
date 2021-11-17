

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Movie.dart';
import 'getData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<MovieItem>> futureList;
  final searchMovies = TextEditingController();


  @override
  void initState() {
    super.initState();
     futureList = fetchMovies(searchMovies.toString());

  }


  setList() {
    setState(() {
      print("text= "+searchMovies.text);
      futureList = fetchMovies(searchMovies.text);
      searchMovies.text="";
    });

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      theme: ThemeData(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[200],
          title: const Text('Movies'),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Search"),
                            controller: searchMovies,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: FloatingActionButton(
                            onPressed: () => {
                              setList(),
                            },
                            child: Icon(Icons.search),
                            hoverColor: Colors.indigo[200],
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<List<MovieItem>>(
                  future: futureList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<MovieItem> Movies = snapshot.data ?? [];
                      return ListView.builder(
                        itemCount: Movies.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MovieItem(
                            image: Movies[index].image,
                            title: Movies[index].title,
                            year: Movies[index].year,
                            Type: Movies[index].Type,
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Container(

                          child:
                          Column(
                            mainAxisAlignment:MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                              Icons.search,
                              color:  Colors.grey,
                                size: 20,
                            ),
                            Text("Search To show movies! ",
                              style: TextStyle(color: Colors.grey,),
                            ),
                          ],
                          ),
                      );

                    }

                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
