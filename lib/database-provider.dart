
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Movie.dart';
import 'getData.dart';


class Databasemodules extends ChangeNotifier {

  static final Databasemodules _instance = Databasemodules._internal();

  Databasemodules._internal();

  factory Databasemodules.getInstance(){
    return _instance;}

  List<Movie>Action=[];
  List<Movie>Comedy=[];
  List<Movie>Drama=[];
  List<Movie>Fantasy=[];
  List<Movie>Horror=[];
  List<Movie>Mystery=[];
  List<Movie>Romance=[];
  List<Movie>Thriller=[];
  List<Movie>Adventure=[];

  static const int version = 10;
  static Database? _mydatabase;

  Future<Database?> get database async {
    if (_mydatabase != null) {
      return _mydatabase;
    }
    else {
      _mydatabase = await initDatabase();
      return _mydatabase;
    }
  }

  initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), "uni.db"),
      version: version,
      onCreate: (Database db, int version) async {
        print("onCreate");
        await db.execute('''
            CREATE TABLE Movies (
            imdbID TEXT ,
            Title TEXT ,
            Year TEXT,
            Poster TEXT,
            Type TEXT
           
            )
          ''');
      },


    );
  }

  //get all movies in watch list
  Future<List<Movie>> get movies async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query('Movies');
    List<Movie> mov = [];
    for (var value in result) {
      mov.add(Movie.fromJson(value));
    }
    return mov;
  }

//add movie to a watch list
  addMovie(Movie movie,String id) async {
    final db = await database;
    List<Map>maps= await db!.query("Movies",
        columns:["imdbID", "Title", "Year","Poster", "Type"],
        where: '"imdbID" = ?',
        whereArgs:[id]);
    if(maps.length==0) {
      final db = await database;
      var result = await db?.insert('Movies', movie.toMap());
      movie.added = true;
      notifyListeners();
      return result;
    }
    else{
      print("this movie is added before");

    }
  }
// delete all movies in watch list
  deleteAll() async {
    final db = await database;
    db!.delete('Movies');
    notifyListeners();
  }
// delete a specific movie using id
  deleteMovie(int id) async {
    final db = await database;
    db!.delete("students", where: "id=?", whereArgs: [id]);
    notifyListeners();
  }



  Future<bool> movieExsist(String id) async {
    final db = await database;
    List<Map>maps= await db!.query("Movies",
        columns:["imdbID", "Title", "Year","Poster", "Type"],
        where: '"imdbID" = ?',
        whereArgs:[id]);
    if(maps.length==0) {
      return false;
    }
else {
      return true;
    }
  }

  getCategory()async{
   List<Movie> v = await movies;
   List<Movie>v2=[];
   for(int j=0;j<v.length;j++){
      Movie movie= await fetchMovie(v[j].title);
      v2.add(movie);
   }
     for(int i=0;i<v2.length;i++){
       if(v2[i].genre.contains("Action")) {
         bool exist =false;
         for(int o=0;o<Action.length;o++){
           if(v2[i].id==Action[o].id)
             exist=true;
         }
         if(exist);
         else Action.add(v2[i]);
       }
       if(v2[i].genre.contains("Comedy")){
          bool exist =false;
       for(int o=0;o<Comedy.length;o++){
         if(v2[i].id==Comedy[o].id)
           exist=true;
       }
       if(exist);
       else Comedy.add(v2[i]);
     }

       if(v2[i].genre.contains("Drama")){
         bool exist =false;
         for(int o=0;o<Drama.length;o++){
           if(v2[i].id==Drama[o].id)
             exist=true;
         }
         if(exist);
         else Drama.add(v2[i]);
       }

       if(v2[i].genre.contains("Fantasy")){
         bool exist =false;
         for(int o=0;o<Fantasy.length;o++){
           if(v2[i].id==Fantasy[o].id)
             exist=true;
         }
         if(exist);
         else Fantasy.add(v2[i]);
       }

       if(v2[i].genre.contains("Horror")){
         bool exist =false;
         for(int o=0;o<Horror.length;o++){
           if(v2[i].id==Horror[o].id)
             exist=true;
         }
         if(exist);
         else Horror.add(v2[i]);
       }

       if(v2[i].genre.contains("Mystery")){
         bool exist =false;
         for(int o=0;o<Mystery.length;o++){
           if(v2[i].id==Mystery[o].id)
             exist=true;
         }
         if(exist);
         else Mystery.add(v2[i]);
       }

       if(v2[i].genre.contains("Romance")){
         bool exist =false;
       for(int o=0;o<Romance.length;o++){
         if(v2[i].id==Romance[o].id)
           exist=true;
       }
       if(exist);
       else Romance.add(v2[i]);
     }

       if(v2[i].genre.contains("Thriller")){
         bool exist =false;
         for(int o=0;o<Thriller.length;o++){
           if(v2[i].id==Thriller[o].id)
             exist=true;
         }
         if(exist);
         else Thriller.add(v2[i]);
       }


       if(v2[i].genre.contains("Adventure")){
         bool exist =false;
         for(int o=0;o<Adventure.length;o++){
           if(v2[i].id==Adventure[o].id)
             exist=true;
         }
         if(exist);
         else Adventure.add(v2[i]);
       }


     }


  }


}
