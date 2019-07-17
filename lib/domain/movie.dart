class Movie {
  int id;
  String title;
  String poster_path;
  double vote_average;
  String overview;

  String get urlFoto {
//    return "https://image.tmdb.org/t/p/w300/"+poster_path;
    return "https://image.tmdb.org/t/p/w300/"+poster_path;
  }

  Movie.fromJson(Map<String, dynamic> map)  :
        id = map["id"] as int,
        title = map["title"],
        poster_path = map["poster_path"],
        overview = map["overview"],
        vote_average = double.parse(map["vote_average"].toString());

  Map toMap() {
    Map<String,dynamic> map = {
      "title": title,
      "poster_path": poster_path,
      "overview": overview,
      "vote_average": vote_average
    };
    if(id != null) {
      map["id"] = id;
    }
    return map;
  }


  @override
  String toString() {
    return 'Movie{id: $id, title: $title, urlFoto: $urlFoto}';
  }

}