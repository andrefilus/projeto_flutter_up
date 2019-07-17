import 'dart:async';
import 'dart:convert' as convert;
import 'package:aula2/domain/movie.dart';
import 'package:aula2/domain/service/response.dart';
import 'package:http/http.dart' as http;

class MovieService {
  static Future<List<Movie>> getMovies() async {
    try {
//      final url = "https://api.themoviedb.org/3/movie/popular?api_key=4bbf48b3b0363565ff8a0fd6281a0948&language=pt-BR";
      final url = "https://pos-up-avancado.herokuapp.com/movies";
      final response = await http.get(url);
      print(response.body);
//      final mapMovies = json.decode(response.body)['results'];
      final mapMovies = convert.json.decode(response.body);

      final movies = mapMovies.map<Movie>((json) => Movie.fromJson(json)).toList();
      return movies;
    } catch(error){
      return [];
    }
  }

  static void postFavoriteMovie(Movie movie) async {
    try {
      final url = "https://pos-up-avancado.herokuapp.com/movies";
      print("> post: $url");

      final headers = {"Content-Type":"application/json"};
      final body = convert.json.encode(movie.toMap());
      print("   > $body");

      final response = await http.post(url, headers: headers, body: body)
          .timeout(Duration(seconds: 10));

      final s = response.body;
      print("   < $s");

//      final r = Response.fromJson(convert.json.decode(s));

//      return r;
    } catch(error){
      print(error.toString());
    }
  }

}