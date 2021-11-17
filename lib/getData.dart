import 'Movie.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';

 Future <List<MovieItem>> fetchMovies(String value) async {
  final response = await http
    .get(Uri.parse('https://www.omdbapi.com/?s=${value}&apikey=17558978'));
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body) ;
    Iterable list = responseJson["Search"] ;
    return list.map((m) =>MovieItem.fromJson(m)).toList() ;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load movie');
  }
}