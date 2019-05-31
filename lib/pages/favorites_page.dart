import 'package:aula2/domain/db/movieDB.dart';
import 'package:aula2/domain/movie.dart';
import 'package:aula2/utils/nav.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> with AutomaticKeepAliveClientMixin<FavoritesPage> {

  @override
  bool get wantKeepAlive => true;

  Future<List<Movie>> future;
  List<Movie> _listContent;

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    Future<List<Movie>> future = MovieDB.getInstance().getMovies();
//    _listContent = MovieDB.getInstance().getMovies();


    return Container(
      padding: EdgeInsets.all(12),
      child: FutureBuilder<List<Movie>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Movie> movies = snapshot.data;
//            _listContent = snapshot.data;
//            return _listView(context,_listContent);
            return _listView(context,movies);
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Sem dados",style: TextStyle(
                  color: Colors.grey,
                  fontSize: 26,
                  fontStyle: FontStyle.italic
              ),),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  _listView(context, List<Movie> movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, idx) {
        final itemMovie = movies[idx];

        return GestureDetector(
//          onTap: () => _onClickMovie(context, itemMovie, idx),
          child: Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: ListTile(
              leading: Image.network(
                itemMovie.urlFoto ??
                    "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png",
                height: 120,
//                width: 200,
              ),
              title: Text(
                "${itemMovie.title}",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onClickMovie(context, movie, idx) async {
    final db = MovieDB.getInstance();
    final exists = await db.exists(movie);
    if(exists) {
      db.deleteMovie(movie.id);
//      setState(() {
//        _listContent = List.from(_listContent).removeAt(idx);
//      });
    }
  }

}

