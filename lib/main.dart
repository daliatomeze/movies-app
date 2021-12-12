import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/watchList.dart';
import 'package:provider/provider.dart';
import 'Genre.dart';
import 'Movie.dart';
import 'database-provider.dart';
import 'getData.dart';
import 'HomePageDesign.dart';
import 'DetailsPage.dart';
import 'package:favorite_button/favorite_button.dart';


void main() {
  runApp(ChangeNotifierProvider<Databasemodules>(
      create: (context) => Databasemodules.getInstance(), child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Movie>> futureList;
  final searchMovies = TextEditingController();
  bool first = false;



  @override
  void initState() {
    super.initState();
   futureList = fetchMovies(searchMovies.toString(), 's');
  }


  // fetch data
  setList() {
    setState(() {
      print("text= " + searchMovies.text);
      futureList = fetchMovies(searchMovies.text, 's');
      first = true;
      searchMovies.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline6: TextStyle(
              fontSize: 36.0, fontStyle: FontStyle.italic, color: Colors.white),
          bodyText1: TextStyle(
              fontSize: 14.0, fontFamily: 'Hind', color: Colors.white),
          bodyText2: TextStyle(
              fontSize: 14.0, fontFamily: 'Hind', color: Colors.black87),
        ),
      ),
      home: Consumer<Databasemodules>(builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent[700],
            title: const Text('Movies'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.smart_display_rounded),
                hoverColor: Colors.redAccent[700],
                tooltip: 'Show Snackbar',
                onPressed: () {
                  value.deleteAll();
                },
              ),
            ],
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
                              style: TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Search",
                                  fillColor: Colors.white12,
                                  filled: true,
                                  hoverColor: Colors.white12,
                                  focusColor: Colors.white12),
                              controller: searchMovies,
                              cursorColor: Colors.white,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            child: FloatingActionButton(
                              onPressed: () => {
                                setList(),
                              },
                              child: Icon(Icons.search),
                              hoverColor: Colors.redAccent,
                              backgroundColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: FutureBuilder<List<Movie>>(
                    future: futureList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Movie> Movies = snapshot.data ?? [];
                        return ListView.builder(
                          itemCount: Movies.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsPage(
                                          Title: Movies[index].title),
                                    ));
                              },
                              child: Container(
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 4,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(4),
                                height: 120,
                                child: Card(
                                  child: Row(
                                    children: [
                                      Image.network(
                                        Movies[index].image,
                                        height: 90,
                                        width: 90,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                              height: 100,
                                              width: 100,
                                              color: Colors.indigoAccent,
                                              alignment: Alignment.center,
                                              child: Icon(Icons.image));
                                        },
                                      ),
                                      Expanded(
                                          child: Container(
                                        color: Colors.white,
                                        padding:
                                            EdgeInsets.fromLTRB(20, 5, 5, 5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              Movies[index].title,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(Movies[index].year.toString()),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                Movies[index].type,
                                                style: TextStyle(
                                                    fontFamily: 'RobotoMono',
                                                    color:
                                                        Colors.redAccent[500]),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                              width: 35,
                                              child: FutureBuilder(
                                                future: value.movieExsist(
                                                    Movies[index].id),
                                                builder: (c, s) {
                                                  if (s.hasData) {
                                                    bool newBool =
                                                        s.data as bool;

                                                    return FavoriteButton(
                                                      isFavorite: newBool,
                                                      iconSize: 30,
                                                      valueChanged:
                                                          (_isFavorite) {
                                                        if (_isFavorite) {
                                                          value.addMovie(
                                                              Movies[index],
                                                              Movies[index].id);
                                                          print("let add");
                                                        } else {
                                                          value.deleteMovie( Movies[index].id);
                                                        }
                                                      },
                                                    );
                                                  } else {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return HomePage(first: first);
                      }
                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ],
            ),
          ),
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color:Colors.black87,

                  ), child: Text("My MoVie APP"),

                ),
                ListTile(
                  hoverColor: Colors.redAccent[700],
                  title: const Text(
                    'Watch List',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: Icon(Icons.smart_display_rounded ,color: Colors.redAccent),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WatchList(value.movies)));
                  },
                ),
                ListTile(
                  hoverColor: Colors.redAccent[700],
                  title: const Text(
                    'Genre Screen',
                    style: TextStyle(color: Colors.black,),
                  ),
                  leading: Icon(Icons.category_outlined,color: Colors.green,),
                  onTap: () {
                    Navigator.push(context,

                        MaterialPageRoute(builder: (context) =>
                    GenreScreen("Genre Screen",["Action","Comedy","Drama","Fantasy","Horror","Mystery","Romance","Thriller","adventure"],[value.Action,value.Comedy,value.Drama,value.Fantasy,value.Horror,value.Mystery,value.Romance,value.Thriller,value.Adventure])));
                  },
                ),

              ],
            ),
          ),
        );
      }),
    );
  }
}
