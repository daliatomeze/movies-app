import 'Movie.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';

 Future <List<Movie>> fetchMovies(String value ,String type) async {
  final response = await http
    .get(Uri.parse('https://www.omdbapi.com/?${type}=${value}&apikey=17558978'));
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body) ;
    Iterable list;

       list= responseJson["Search"] ;
       return list.map((m) =>Movie.fromJson(m)).toList() ;}


  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load movie');
  }
}

 Future<Movie> fetchMovie (String Title)async{
   final response = await http
       .get(Uri.parse('https://www.omdbapi.com/?t=${Title}&apikey=17558978'));
   print(response.body);
   print(response.statusCode);
   if (response.statusCode == 200) {
     final responseJson = jsonDecode(response.body) ;
   Movie movie =Movie.fromJson(responseJson);
  return  movie;}

   else {
     // If the server did not return a 200 OK response,
     // then throw an exception.
     throw Exception('Failed to load movie');
   }
 }