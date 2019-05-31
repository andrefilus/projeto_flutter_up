import 'dart:async';
import 'dart:convert';
import 'package:aula2/domain/movie.dart';
import 'package:http/http.dart' as http;

class MovieService {
  static Future<List<Movie>> getMovies() async {
    try {
      final url = "https://api.themoviedb.org/3/movie/popular?api_key=4bbf48b3b0363565ff8a0fd6281a0948&language=pt-BR";
      final response = await http.get(url);
      print(response.body);
      final mapMovies = json.decode(response.body)['results'];

      final movies = mapMovies.map<Movie>((json) => Movie.fromJson(json)).toList();
      return movies;
    } catch(error){
      return [];
    }
  }

}