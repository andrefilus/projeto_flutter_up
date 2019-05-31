import 'package:aula2/domain/movie.dart';
import 'package:aula2/domain/db/movieDB.dart';
import 'package:aula2/domain/service/favorite_service.dart';
import 'package:aula2/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;

  const MoviePage(this.movie);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {

  Movie get movie => widget.movie;

  bool _isFavorito = false;

  @override
  void initState() {
    super.initState();

    MovieDB.getInstance().exists(movie).then((b){
      if(b) {
        setState(() {
          _isFavorito = b;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(movie.title),
      ),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        Image.network(movie.urlFoto ?? "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png"),
        _firstRow(),
        _secondRow(),
      ],
    );
  }

  _firstRow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                movie.title,
                style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                movie.vote_average.toString(),
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () { _onClickFavorito(context,movie); },
          child: Icon(
            Icons.favorite,
            color: _isFavorito ? Colors.red : Colors.grey,
            size: 36,
          ),
        )
      ],
    );
  }

  _secondRow() {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            movie.overview,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Future _onClickFavorito(context, movie) async {

    final db = MovieDB.getInstance();
    final exists = await db.exists(movie);
    if(exists) {
      db.deleteMovie(movie.id);
      print("Filme apagado $movie");
    } else {
      int id = await db.saveMovie(movie);
      print("Filme salvo $id");
    }
    setState(() {
      _isFavorito = !exists;
    });
  }

}