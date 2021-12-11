import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Movie.dart';
import 'database-provider.dart';
import 'getData.dart';

class WatchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Databasemodules>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Watch List "),
          backgroundColor: Colors.redAccent[700],
        ),
        body: FutureBuilder<List<Movie>>(
            future: value.movies,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Movie> Movies = snapshot.data ?? [];
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(4),
                        height: 130,
                        child: Card(
                          child: FutureBuilder<Movie>(
                            future: fetchMovie(Movies[index].title),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                Movie Mov = snapshot.data!;

                                Movie temp = Mov;
                                return Row(
                                  children: [
                                    Image.network(
                                      Mov.image,
                                      height: 90,
                                      width: 90,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                            height: 80,
                                            width: 100,
                                            color: Colors.indigoAccent,
                                            alignment: Alignment.center,
                                            child: Icon(Icons.image));
                                      },
                                    ),
                                    Expanded(
                                        child: Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Mov.title,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(Mov.year.toString()),
                                          Text(Mov.genre),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              Mov.type,
                                              style: TextStyle(
                                                  fontFamily: 'RobotoMono',
                                                  color: Colors.redAccent[500]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Text("Error");
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text("you dont have any movies in your watch list");
              }
              return const CircularProgressIndicator();
            }),
      );
    });
  }
}
